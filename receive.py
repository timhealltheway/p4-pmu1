#!/usr/bin/env python3
import os
import sys

from scapy.fields import *
from scapy.utils import rdpcap,hexdump
from scapy.all import (
    UDP,
    TCP,
    FieldLenField,
    FieldListField,
    IntField,
    IPOption,
    ShortField,
    get_if_list,
    sniff,
    Packet
)
from scapy.layers.inet import _IPOption_HDR


def get_if():
    ifs=get_if_list()
    iface=None
    for i in get_if_list():
        if "eth0" in i:
            iface=i
            break;
    if not iface:
        print("Cannot find eth0 interface")
        exit(1)
    return iface

# class IPOption_MRI(IPOption):
#     name = "MRI"
#     option = 31
#     fields_desc = [ _IPOption_HDR,
#                     FieldLenField("length", None, fmt="B",
#                                   length_of="swids",
#                                   adjust=lambda pkt,l:l+4),
#                     ShortField("count", 0),
#                     FieldListField("swids",
#                                    [],
#                                    IntField("", 0),
#                                    length_from=lambda pkt:pkt.count*4) ]

class PMU(Packet):
    name = "IEEE C37.118 Synchrophasor Protocol"
    fields_desc = [ XBitField('Synchronization_word',0xaa01,16),
                    BitField('Framesize', 48,16),
                    BitField('Id_code', 60,16),
                    UTCTimeField("timestamp",1217548801)
                    ]

def handle_pkt(pkt):
    if UDP in pkt and pkt[UDP].dport == 1234:
        print("got a packet")
        pkt.show2()
        hexdump(pkt)
        sys.stdout.flush()


def main():
    ifaces = [i for i in os.listdir('/sys/class/net/') if 'eth' in i]
    iface = ifaces[0]
    print("sniffing on %s" % iface)
    sys.stdout.flush()
    sniff(iface = iface,
          prn = lambda x: handle_pkt(x))

if __name__ == '__main__':
    main()
