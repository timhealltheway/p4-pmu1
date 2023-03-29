#!/usr/bin/env python3
import random
import socket
import sys

from scapy.all import bytes_hex,raw,IP, TCP, UDP,Ether, get_if_hwaddr, get_if_list, sendp,send,bind_layers,Packet
from scapy.utils import rdpcap,hexdump
from scapy.fields import *
import readline
import binascii


def get_if():
    ifs=get_if_list()
    iface=None # "h1-eth0"
    for i in get_if_list():
        if "eth0" in i:
            iface=i
            break;
    if not iface:
        print("Cannot find eth0 interface")
        exit(1)
    return iface

def expand(x):
    yield x
    while x.payload:
        x = x.payload
        yield x


class PMU(Packet):
    name = "IEEE C37.118 Synchrophasor Protocol"
    fields_desc = [ XBitField('Synchronization_word',0xaa01,16),
                    BitField('Framesize', 48,16),
                    BitField('Id_code', 60,16),
                    UTCTimeField("timestamp",1217548801),
                    XBitField('Flags',1,16),
                    XBitField('PhasorVA_Vol',100,32),
                    XBitField('PhasorVA_Ang',89,32),
                    XBitField('PhasorVB_Vol',99,32),
                    XBitField('PhasorVB_Ang',150,32),
                    XBitField('PhasorVC_Vol',100,32),
                    XBitField('PhasorVC_Ang',30,32)
                    ]

bind_layers(UDP,PMU,dport=1234)

def main():

    if len(sys.argv)<3:
        print('pass 2 arguments: <destination> "<message>"')
        exit(1)

    addr = socket.gethostbyname(sys.argv[1])
    iface = get_if()

    print("starting sending****************************************    ")
    print("sending on interface %s to %s" % (iface, str(addr)))
    #sending packet from pcap file
    pkts = rdpcap("/home/p4/p4/C37.118_1PMU_UDP.pcap",1)
    for p in pkts:

        p = Ether(src = get_if_hwaddr(iface), dst = 'ff:ff:ff:ff:ff:ff')
        p = p /IP(dst=addr)
        p = p /UDP(dport=1234, sport=1234)
        p = p/ PMU(timestamp = 1217548803)

        p.show()
        hexdump(p)

        sendp(p,iface=iface,verbose=False)

        if p.haslayer(IP):
            ip_layer = p[IP]
            print("IP source:", ip_layer.src)
            PMU_layer = p[PMU]
            print("Synchronization_word:", PMU_layer.Synchronization_word)
            print("time", type(PMU_layer.timestamp))
            # print("Timestamp:", PMU_layer.timestamp)
        # p = Ether(src=get_if_hwaddr(iface), dst='ff:ff:ff:ff:ff:ff')
        # p = p /IP(dst=addr)
        # p = p /TCP(dport=1234, sport=random.randint(49152,65535))
        # p = p/ PMU()
        # hexdump(p)
        # p.show()
        # print(p.summary())
            # print(p[Ether].src)
            # print(p.summary())
            # p.show2()
        # print(p[TCP])
        # p[Ether].dst = new_dst_mac
        # p[IP].src = new_src_ip
        # p[IP].dst = new_dst_ip



        # p =  Ether(src=get_if_hwaddr(iface), dst='ff:ff:ff:ff:ff:ff')
        # p = p /IP(dst=addr) / TCP(dport=1234, sport=random.randint(49152,65535)) / sys.argv[2]
        # print(p.summary());
        # p.show2()
        # sendp(p,iface=iface,verbose=False) #sending packet at layer 2
    # pkt =  Ether(src=get_if_hwaddr(iface), dst='ff:ff:ff:ff:ff:ff')
    # pkt = pkt /IP(dst=addr) / TCP(dport=1234, sport=random.randint(49152,65535)) / sys.argv[2]
    # pkt.show2()
    # sendp(pkt, iface=iface, verbose=False)


if __name__ == '__main__':
    main()
