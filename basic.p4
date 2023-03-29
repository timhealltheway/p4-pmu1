/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_IPV4 = 0x800;
const bit<16> TYPE_PMU = 0xaa01;

/*************************************************************************
*********************** H E A D E R S  ***********************************
*************************************************************************/

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}


header ipv4_t {
    bit<4>    version;
    bit<4>    ihl;
    bit<8>    diffserv;
    bit<16>   totalLen;
    bit<16>   identification;
    bit<3>    flags;
    bit<13>   fragOffset;
    bit<8>    ttl;
    bit<8>    protocol;
    bit<16>   hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}

header udp_t{
  bit<16> srcPort;
  bit<16> desPort;
  bit<16> len;
  bit<16> checksum;
}

header pmu_t{
  bit<16> sync;
  bit<16> frame_size;
  bit<16> idcode;
  bit<32> soc;
  bit<16> flags;
  bit<32> phasorVA_Vol;
  bit<32> phasorVA_Ang;
  bit<32> phasorVB_Vol;
  bit<32> phasorVB_Ang;
  bit<32> phasorVC_Vol;
  bit<32> phasorVC_Ang;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
    udp_t        udp;
    pmu_t        pmu;
}

/*************************************************************************
*********************** P A R S E R  ***********************************
*************************************************************************/

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        transition parse_ethernet;
    }

    state parse_ethernet{
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType){
          TYPE_IPV4: parse_ipv4;
          default: accept;
        }
    }

    state parse_ipv4{
        packet.extract(hdr.ipv4);
        transition select(hdr.ipv4.protocol){
          17: parse_udp;
          default: accept;
        }
    }

    state parse_udp{
      packet.extract(hdr.udp);
      transition select(hdr.udp.srcPort){
          1234: parse_pmu;
          default: accept;
      }
    }

    state parse_pmu{
        packet.extract(hdr.pmu);
        transition accept;
    }

}


/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}

/*************************************************************************
**************  COS-SIN-TAN  P R O C E S S I N G   *******************
*************************************************************************/
control cos_value_va(in bit<32> degree, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_cos_result(bit<32> y){
          output_val = y;
          result = 5000;
      }

      action set_cos_test(){
          result = 55;
      }

      table cos_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_cos_result;
            set_cos_test;
          }
          const entries = {
            89: set_cos_test; // to add more
            174: set_cos_result(-89);
            1: set_cos_result(89);
            8660: set_cos_result(150);
            8661 : set_cos_result(30);
            8750 : set_cos_result(32);

          }
      }

      apply{
          cos_base_degree.apply();
      }
}

control cos_value_vb(in bit<32> degree, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_cos_result(bit<32> y){
          output_val = y;
          result = 5000;
      }

      action set_cos_test(){
          result = 55;
      }

      table cos_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_cos_result;
            set_cos_test;
          }
          const entries = {
            89: set_cos_test; // to add more
            174: set_cos_result(-89);
            1: set_cos_result(89);
            8660: set_cos_result(150);
            8661 : set_cos_result(30);
            8750 : set_cos_result(32);

          }
      }

      apply{
          cos_base_degree.apply();
      }
}

control cos_value_vc(in bit<32> degree, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_cos_result(bit<32> y){
          output_val = y;
          result = 5000;
      }

      action set_cos_test(){
          result = 55;
      }

      table cos_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_cos_result;
            set_cos_test;
          }
          const entries = {
            89: set_cos_test; // to add more
            174: set_cos_result(-89);
            1: set_cos_result(89);
            8660: set_cos_result(150);
            8661 : set_cos_result(30);
            8750 : set_cos_result(32);

          }
      }

      apply{
          cos_base_degree.apply();
      }
}

control sin_value_va(in bit<32> degree, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_sin_result(bit<32> y){
          output_val = y;
          result = y;
      }

      action set_sin_test(){
          result = 60;
      }

      table sin_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_sin_result;
            set_sin_test;
          }
          const entries = {
            89: set_sin_result(60); // to add more
            9998: set_sin_result(-89);
            5001: set_sin_result(150);
            5000: set_sin_result(30);
          }
      }

      apply{
          sin_base_degree.apply();
      }
}

control sin_value_vb(in bit<32> degree, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_sin_result(bit<32> y){
          output_val = y;
          result = y;
      }

      action set_sin_test(){
          result = 60;
      }

      table sin_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_sin_result;
            set_sin_test;
          }
          const entries = {
            89: set_sin_result(60); // to add more
            9998: set_sin_result(-89);
            5001: set_sin_result(150);
            5000: set_sin_result(30);
          }
      }

      apply{
          sin_base_degree.apply();
      }
}

control sin_value_vc(in bit<32> degree, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_sin_result(bit<32> y){
          output_val = y;
          result = y;
      }

      action set_sin_test(){
          result = 60;
      }

      table sin_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_sin_result;
            set_sin_test;
          }
          const entries = {
            89: set_sin_result(60); // to add more
            9998: set_sin_result(-89);
            5001: set_sin_result(150);
            5000: set_sin_result(30);
          }
      }

      apply{
          sin_base_degree.apply();
      }
}

control tan_value(in pmu_t pmu, out bit<32> result){
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_tan_result(bit<32> y){
          output_val = y; //set_cos_result(60) = output value
          result = y;
      }

      table tan_base_degree{
          key = {
              pmu.phasorVA_Ang : exact;
          }
          actions = {
            set_tan_result;
          }
          const entries = {
            5000: set_tan_result(60); // to add more
            174: set_tan_result(89);
          }
      }

      apply{
          tan_base_degree.apply();
      }
}

/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {
    register<bit<32>>(1) va_vol;
    register<bit<32>>(1) va_ang;
    register<bit<32>>(1) vb_vol;
    register<bit<32>>(1) vb_ang;
    register<bit<32>>(1) vc_vol;
    register<bit<32>>(1) vc_ang;
    register<bit<32>>(1) r;
    register<bit<32>>(10) a;
    bit<32> va_cos_res;
    bit<32> va_sin_res;
    bit<32> vb_cos_res;
    bit<32> vb_sin_res;
    bit<32> vc_cos_res;
    bit<32> vc_sin_res;

    bit<32> va_real;
    bit<32> va_img;
    bit<32> vb_real;
    bit<32> vb_img;
    bit<32> vc_real;
    bit<32> vc_img;

    bit<32> jpt_real_res;
    bit<32> jpt_img_res;

    //init function variables
    cos_value_va() cos_value_va;
    cos_value_vb() cos_value_vb;
    cos_value_vc() cos_value_vc;
    sin_value_va() sin_value_va;
    sin_value_vb() sin_value_vb;
    sin_value_vc() sin_value_vc;

    action drop() {
        mark_to_drop(standard_metadata);
    }

    action ipv4_forward(macAddr_t dstAddr, egressSpec_t port) {
        /* TODO: fill out code in action body */
        standard_metadata.egress_spec = port;
        hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
        hdr.ethernet.dstAddr = dstAddr;
        hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
    }

    action calculate_complex_voltage(in bit<32> mag, in bit<32> cos_ang,in bit<32> sin_ang, out bit<32> real,
    out bit<32> img){
        real = cos_ang * mag;
        img  = sin_ang * mag;
    }

    action jpt_algo(in bit<32> kMin1, in bit<32> kMin2, in bit<32> kMin3, out bit<32> jpt_res){
        jpt_res = 3 * kMin1 - 3 * kMin2 + kMin3;
    }

    action update_register(){
        va_vol.write(0, hdr.pmu.phasorVA_Vol);
        va_ang.write(0,hdr.pmu.phasorVA_Ang);
        vb_vol.write(0, hdr.pmu.phasorVB_Vol);
        vb_ang.write(0,hdr.pmu.phasorVB_Ang);
        vc_vol.write(0, hdr.pmu.phasorVC_Vol);
        vc_ang.write(0,hdr.pmu.phasorVC_Ang);
    }

    action test(){
        bit<32> last;
        bit<32> now;
        bit<32> ival;

        va_vol.read(now,0); //assign now to va_vol value from register
        last = hdr.pmu.phasorVB_Vol;
        ival = now - last +1 ;
        r.write(0,ival);

    }

    table ipv4_lpm {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }
        actions = {
            ipv4_forward;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    //print pmu or any other header value
    table debug_pmu_header{
        key = {
            hdr.pmu.sync : exact;
            hdr.pmu.soc : exact;
            hdr.pmu.phasorVA_Vol: exact;
        }
        actions ={}
    }

    apply {
        /* TODO: fix ingress control logic
         *  - ipv4_lpm should be applied only when IPv4 header is valid
         */
         if(hdr.ipv4.isValid()){
            ipv4_lpm.apply();
            if(hdr.pmu.isValid()){
              debug_pmu_header.apply();
              update_register();
              test();

              //calculate cos and sin value
              cos_value_va.apply(hdr.pmu.phasorVA_Ang,va_cos_res);
              sin_value_va.apply(hdr.pmu.phasorVA_Ang,va_sin_res);
              a.write(0, va_cos_res);
              cos_value_vb.apply(hdr.pmu.phasorVB_Ang,vb_cos_res);
              sin_value_vb.apply(hdr.pmu.phasorVB_Ang,vb_sin_res);
              cos_value_vc.apply(hdr.pmu.phasorVB_Ang,vc_cos_res);
              sin_value_vc.apply(hdr.pmu.phasorVB_Ang,vc_sin_res);



              //get real and img value
              calculate_complex_voltage(hdr.pmu.phasorVA_Vol, va_cos_res,va_sin_res, va_real,
              va_img);
              a.write(1, va_real);
              a.write(2,va_img);
              calculate_complex_voltage(hdr.pmu.phasorVB_Vol, vb_cos_res,vb_sin_res, vb_real,
              vb_img);
              calculate_complex_voltage(hdr.pmu.phasorVC_Vol, vc_cos_res,vc_sin_res, vc_real,
              vc_img);

              //jpt algo
              jpt_algo(va_real, vb_real,vc_real,jpt_real_res);
              jpt_algo(va_img,vb_img,vc_img,jpt_img_res);


            }
         }
    }


}

/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
*************************************************************************/

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
     apply {
        update_checksum(
            hdr.ipv4.isValid(),
            { hdr.ipv4.version,
              hdr.ipv4.ihl,
              hdr.ipv4.diffserv,
              hdr.ipv4.totalLen,
              hdr.ipv4.identification,
              hdr.ipv4.flags,
              hdr.ipv4.fragOffset,
              hdr.ipv4.ttl,
              hdr.ipv4.protocol,
              hdr.ipv4.srcAddr,
              hdr.ipv4.dstAddr },
            hdr.ipv4.hdrChecksum,
            HashAlgorithm.csum16);
    }
}


/*************************************************************************
***********************  D E P A R S E R  *******************************
*************************************************************************/

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        /* TODO: add deparser logic */
        packet.emit(hdr.ethernet);
        packet.emit(hdr.ipv4);
        packet.emit(hdr.udp);
        packet.emit(hdr.pmu);


    }
}

/*************************************************************************
***********************  S W I T C H  *******************************
*************************************************************************/

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
