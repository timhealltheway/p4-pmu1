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

      action set_cos_result(bit<32> y){
          result = 5000;
      }

      action set_cos_test(){
          result = 17;
      }

      action set_cos_0_result(){
        result = 1000;
      }
      action set_cos_1_result(){result = 999; }
      action set_cos_2_result(){result = 999; }
      action set_cos_3_result(){result = 998; }
      action set_cos_4_result(){result = 997; }
      action set_cos_5_result(){result = 996; }
      action set_cos_6_result(){result = 994; }
      action set_cos_7_result(){result = 992; }
      action set_cos_8_result(){result = 990; }
      action set_cos_9_result(){result = 987; }
      action set_cos_10_result(){result = 984; }
      action set_cos_11_result(){result = 981; }
      action set_cos_12_result(){result = 978; }
      action set_cos_13_result(){result = 974; }
      action set_cos_14_result(){result = 970; }
      action set_cos_15_result(){result = 965; }
      action set_cos_16_result(){result = 961; }
      action set_cos_17_result(){result = 956; }
      action set_cos_18_result(){result = 951; }
      action set_cos_19_result(){result = 945; }
      action set_cos_20_result(){result = 939; }
      action set_cos_21_result(){result = 933; }
      action set_cos_22_result(){result = 927; }
      action set_cos_23_result(){result = 920; }
      action set_cos_24_result(){result = 913; }
      action set_cos_25_result(){result = 906; }
      action set_cos_26_result(){result = 898; }
      action set_cos_27_result(){result = 891; }
      action set_cos_28_result(){result = 882; }
      action set_cos_29_result(){result = 874; }


      table cos_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_cos_result;
            set_cos_test;

            set_cos_0_result;
            set_cos_1_result;
            set_cos_2_result;
            set_cos_3_result;
            set_cos_4_result;
            set_cos_5_result;
            set_cos_6_result;
            set_cos_7_result;
            set_cos_8_result;
            set_cos_9_result;
            set_cos_10_result;
            set_cos_11_result;
            set_cos_12_result;
            set_cos_13_result;
            set_cos_14_result;
            set_cos_15_result;
            set_cos_16_result;
            set_cos_17_result;
            set_cos_18_result;
            set_cos_19_result;
            set_cos_20_result;
            set_cos_21_result;
            set_cos_22_result;
            set_cos_23_result;
            set_cos_24_result;
            set_cos_25_result;
            set_cos_26_result;
            set_cos_27_result;
            set_cos_28_result;
            set_cos_29_result;


          }
          const entries = {
            89: set_cos_test; // to add more
            174: set_cos_result(-89);
            8660: set_cos_result(150);
            8661 : set_cos_result(30);
            8750 : set_cos_result(32);
            0: set_cos_0_result;
            1: set_cos_1_result;
            2: set_cos_2_result;
            3: set_cos_3_result;
            4: set_cos_4_result;
            5: set_cos_5_result;
            6: set_cos_6_result;
            7: set_cos_7_result;
            8: set_cos_8_result;
            9: set_cos_9_result;
            10: set_cos_10_result;
            11: set_cos_11_result;
            12: set_cos_12_result;
            13: set_cos_13_result;
            14: set_cos_14_result;
            15: set_cos_15_result;
            16: set_cos_16_result;
            17: set_cos_17_result;
            18: set_cos_18_result;
            19: set_cos_19_result;
            20: set_cos_20_result;
            21: set_cos_21_result;
            22: set_cos_22_result;
            23: set_cos_23_result;
            24: set_cos_24_result;
            25: set_cos_25_result;
            26: set_cos_26_result;
            27: set_cos_27_result;
            28: set_cos_28_result;
            29: set_cos_29_result;
          }
      }

      apply{
          cos_base_degree.apply();
      }
}

control cos_value_vb(in bit<32> degree, out bit<32> result){

      action set_cos_result(bit<32> y){
          result = 5000;
      }

      action set_cos_test(){
          result = 17;
      }

      action set_cos_0_result(){
        result = 1000;
      }
      action set_cos_1_result(){result = 999; }
      action set_cos_2_result(){result = 999; }
      action set_cos_3_result(){result = 998; }
      action set_cos_4_result(){result = 997; }
      action set_cos_5_result(){result = 996; }
      action set_cos_6_result(){result = 994; }
      action set_cos_7_result(){result = 992; }
      action set_cos_8_result(){result = 990; }
      action set_cos_9_result(){result = 987; }
      action set_cos_10_result(){result = 984; }
      action set_cos_11_result(){result = 981; }
      action set_cos_12_result(){result = 978; }
      action set_cos_13_result(){result = 974; }
      action set_cos_14_result(){result = 970; }
      action set_cos_15_result(){result = 965; }
      action set_cos_16_result(){result = 961; }
      action set_cos_17_result(){result = 956; }
      action set_cos_18_result(){result = 951; }
      action set_cos_19_result(){result = 945; }
      action set_cos_20_result(){result = 939; }
      action set_cos_21_result(){result = 933; }
      action set_cos_22_result(){result = 927; }
      action set_cos_23_result(){result = 920; }
      action set_cos_24_result(){result = 913; }
      action set_cos_25_result(){result = 906; }
      action set_cos_26_result(){result = 898; }
      action set_cos_27_result(){result = 891; }
      action set_cos_28_result(){result = 882; }
      action set_cos_29_result(){result = 874; }


      table cos_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_cos_result;
            set_cos_test;

            set_cos_0_result;
            set_cos_1_result;
            set_cos_2_result;
            set_cos_3_result;
            set_cos_4_result;
            set_cos_5_result;
            set_cos_6_result;
            set_cos_7_result;
            set_cos_8_result;
            set_cos_9_result;
            set_cos_10_result;
            set_cos_11_result;
            set_cos_12_result;
            set_cos_13_result;
            set_cos_14_result;
            set_cos_15_result;
            set_cos_16_result;
            set_cos_17_result;
            set_cos_18_result;
            set_cos_19_result;
            set_cos_20_result;
            set_cos_21_result;
            set_cos_22_result;
            set_cos_23_result;
            set_cos_24_result;
            set_cos_25_result;
            set_cos_26_result;
            set_cos_27_result;
            set_cos_28_result;
            set_cos_29_result;


          }
          const entries = {
            89: set_cos_test; // to add more
            174: set_cos_result(-89);
            8660: set_cos_result(150);
            8661 : set_cos_result(30);
            8750 : set_cos_result(32);
            0: set_cos_0_result;
            1: set_cos_1_result;
            2: set_cos_2_result;
            3: set_cos_3_result;
            4: set_cos_4_result;
            5: set_cos_5_result;
            6: set_cos_6_result;
            7: set_cos_7_result;
            8: set_cos_8_result;
            9: set_cos_9_result;
            10: set_cos_10_result;
            11: set_cos_11_result;
            12: set_cos_12_result;
            13: set_cos_13_result;
            14: set_cos_14_result;
            15: set_cos_15_result;
            16: set_cos_16_result;
            17: set_cos_17_result;
            18: set_cos_18_result;
            19: set_cos_19_result;
            20: set_cos_20_result;
            21: set_cos_21_result;
            22: set_cos_22_result;
            23: set_cos_23_result;
            24: set_cos_24_result;
            25: set_cos_25_result;
            26: set_cos_26_result;
            27: set_cos_27_result;
            28: set_cos_28_result;
            29: set_cos_29_result;
          }
      }

      apply{
          cos_base_degree.apply();
      }
}

control cos_value_vc(in bit<32> degree, out bit<32> result){

      action set_cos_result(bit<32> y){
          result = 5000;
      }

      action set_cos_test(){
          result = 17;
      }

      action set_cos_0_result(){
        result = 1000;
      }
      action set_cos_1_result(){result = 999; }
      action set_cos_2_result(){result = 999; }
      action set_cos_3_result(){result = 998; }
      action set_cos_4_result(){result = 997; }
      action set_cos_5_result(){result = 996; }
      action set_cos_6_result(){result = 994; }
      action set_cos_7_result(){result = 992; }
      action set_cos_8_result(){result = 990; }
      action set_cos_9_result(){result = 987; }
      action set_cos_10_result(){result = 984; }
      action set_cos_11_result(){result = 981; }
      action set_cos_12_result(){result = 978; }
      action set_cos_13_result(){result = 974; }
      action set_cos_14_result(){result = 970; }
      action set_cos_15_result(){result = 965; }
      action set_cos_16_result(){result = 961; }
      action set_cos_17_result(){result = 956; }
      action set_cos_18_result(){result = 951; }
      action set_cos_19_result(){result = 945; }
      action set_cos_20_result(){result = 939; }
      action set_cos_21_result(){result = 933; }
      action set_cos_22_result(){result = 927; }
      action set_cos_23_result(){result = 920; }
      action set_cos_24_result(){result = 913; }
      action set_cos_25_result(){result = 906; }
      action set_cos_26_result(){result = 898; }
      action set_cos_27_result(){result = 891; }
      action set_cos_28_result(){result = 882; }
      action set_cos_29_result(){result = 874; }


      table cos_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_cos_result;
            set_cos_test;

            set_cos_0_result;
            set_cos_1_result;
            set_cos_2_result;
            set_cos_3_result;
            set_cos_4_result;
            set_cos_5_result;
            set_cos_6_result;
            set_cos_7_result;
            set_cos_8_result;
            set_cos_9_result;
            set_cos_10_result;
            set_cos_11_result;
            set_cos_12_result;
            set_cos_13_result;
            set_cos_14_result;
            set_cos_15_result;
            set_cos_16_result;
            set_cos_17_result;
            set_cos_18_result;
            set_cos_19_result;
            set_cos_20_result;
            set_cos_21_result;
            set_cos_22_result;
            set_cos_23_result;
            set_cos_24_result;
            set_cos_25_result;
            set_cos_26_result;
            set_cos_27_result;
            set_cos_28_result;
            set_cos_29_result;


          }
          const entries = {
            89: set_cos_test; // to add more
            174: set_cos_result(-89);
            8660: set_cos_result(150);
            8661 : set_cos_result(30);
            8750 : set_cos_result(32);
            0: set_cos_0_result;
            1: set_cos_1_result;
            2: set_cos_2_result;
            3: set_cos_3_result;
            4: set_cos_4_result;
            5: set_cos_5_result;
            6: set_cos_6_result;
            7: set_cos_7_result;
            8: set_cos_8_result;
            9: set_cos_9_result;
            10: set_cos_10_result;
            11: set_cos_11_result;
            12: set_cos_12_result;
            13: set_cos_13_result;
            14: set_cos_14_result;
            15: set_cos_15_result;
            16: set_cos_16_result;
            17: set_cos_17_result;
            18: set_cos_18_result;
            19: set_cos_19_result;
            20: set_cos_20_result;
            21: set_cos_21_result;
            22: set_cos_22_result;
            23: set_cos_23_result;
            24: set_cos_24_result;
            25: set_cos_25_result;
            26: set_cos_26_result;
            27: set_cos_27_result;
            28: set_cos_28_result;
            29: set_cos_29_result;
          }
      }

      apply{
          cos_base_degree.apply();
      }
}

control sin_value_va(in bit<32> degree, out bit<32> result){

      action set_sin_result(bit<32> y){
          result = y;
      }

      action set_sin_test(){
          result = 999;
      }

      action set_sin_0_result(){result = 0; }
      action set_sin_1_result(){result = 17; }
      action set_sin_2_result(){result = 34; }
      action set_sin_3_result(){result = 52; }
      action set_sin_4_result(){result = 69; }
      action set_sin_5_result(){result = 87; }
      action set_sin_6_result(){result = 104; }
      action set_sin_7_result(){result = 121; }
      action set_sin_8_result(){result = 139; }
      action set_sin_9_result(){result = 156; }
      action set_sin_10_result(){result = 173; }
      action set_sin_11_result(){result = 190; }
      action set_sin_12_result(){result = 207; }
      action set_sin_13_result(){result = 224; }
      action set_sin_14_result(){result = 241; }
      action set_sin_15_result(){result = 258; }
      action set_sin_16_result(){result = 275; }
      action set_sin_17_result(){result = 292; }
      action set_sin_18_result(){result = 309; }
      action set_sin_19_result(){result = 325; }
      action set_sin_20_result(){result = 342; }
      action set_sin_21_result(){result = 358; }
      action set_sin_22_result(){result = 374; }
      action set_sin_23_result(){result = 390; }
      action set_sin_24_result(){result = 406; }
      action set_sin_25_result(){result = 422; }
      action set_sin_26_result(){result = 438; }
      action set_sin_27_result(){result = 453; }
      action set_sin_28_result(){result = 469; }
      action set_sin_29_result(){result = 484; }


      table sin_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_sin_result;
            set_sin_test;
            set_sin_0_result;
            set_sin_1_result;
            set_sin_2_result;
            set_sin_3_result;
            set_sin_4_result;
            set_sin_5_result;
            set_sin_6_result;
            set_sin_7_result;
            set_sin_8_result;
            set_sin_9_result;
            set_sin_10_result;
            set_sin_11_result;
            set_sin_12_result;
            set_sin_13_result;
            set_sin_14_result;
            set_sin_15_result;
            set_sin_16_result;
            set_sin_17_result;
            set_sin_18_result;
            set_sin_19_result;
            set_sin_20_result;
            set_sin_21_result;
            set_sin_22_result;
            set_sin_23_result;
            set_sin_24_result;
            set_sin_25_result;
            set_sin_26_result;
            set_sin_27_result;
            set_sin_28_result;
            set_sin_29_result;


          }
          const entries = {
            89: set_sin_test(); // to add more
            9998: set_sin_result(-89);
            5001: set_sin_result(150);
            5000: set_sin_result(30);
            0: set_sin_0_result;
            1: set_sin_1_result;
            2: set_sin_2_result;
            3: set_sin_3_result;
            4: set_sin_4_result;
            5: set_sin_5_result;
            6: set_sin_6_result;
            7: set_sin_7_result;
            8: set_sin_8_result;
            9: set_sin_9_result;
            10: set_sin_10_result;
            11: set_sin_11_result;
            12: set_sin_12_result;
            13: set_sin_13_result;
            14: set_sin_14_result;
            15: set_sin_15_result;
            16: set_sin_16_result;
            17: set_sin_17_result;
            18: set_sin_18_result;
            19: set_sin_19_result;
            20: set_sin_20_result;
            21: set_sin_21_result;
            22: set_sin_22_result;
            23: set_sin_23_result;
            24: set_sin_24_result;
            25: set_sin_25_result;
            26: set_sin_26_result;
            27: set_sin_27_result;
            28: set_sin_28_result;
            29: set_sin_29_result;

          }
      }

      apply{
          sin_base_degree.apply();
      }
}

control sin_value_vb(in bit<32> degree, out bit<32> result){

      action set_sin_result(bit<32> y){
          result = y;
      }

      action set_sin_test(){
          result = 999;
      }

      action set_sin_0_result(){result = 0; }
      action set_sin_1_result(){result = 17; }
      action set_sin_2_result(){result = 34; }
      action set_sin_3_result(){result = 52; }
      action set_sin_4_result(){result = 69; }
      action set_sin_5_result(){result = 87; }
      action set_sin_6_result(){result = 104; }
      action set_sin_7_result(){result = 121; }
      action set_sin_8_result(){result = 139; }
      action set_sin_9_result(){result = 156; }
      action set_sin_10_result(){result = 173; }
      action set_sin_11_result(){result = 190; }
      action set_sin_12_result(){result = 207; }
      action set_sin_13_result(){result = 224; }
      action set_sin_14_result(){result = 241; }
      action set_sin_15_result(){result = 258; }
      action set_sin_16_result(){result = 275; }
      action set_sin_17_result(){result = 292; }
      action set_sin_18_result(){result = 309; }
      action set_sin_19_result(){result = 325; }
      action set_sin_20_result(){result = 342; }
      action set_sin_21_result(){result = 358; }
      action set_sin_22_result(){result = 374; }
      action set_sin_23_result(){result = 390; }
      action set_sin_24_result(){result = 406; }
      action set_sin_25_result(){result = 422; }
      action set_sin_26_result(){result = 438; }
      action set_sin_27_result(){result = 453; }
      action set_sin_28_result(){result = 469; }
      action set_sin_29_result(){result = 484; }


      table sin_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_sin_result;
            set_sin_test;
            set_sin_0_result;
            set_sin_1_result;
            set_sin_2_result;
            set_sin_3_result;
            set_sin_4_result;
            set_sin_5_result;
            set_sin_6_result;
            set_sin_7_result;
            set_sin_8_result;
            set_sin_9_result;
            set_sin_10_result;
            set_sin_11_result;
            set_sin_12_result;
            set_sin_13_result;
            set_sin_14_result;
            set_sin_15_result;
            set_sin_16_result;
            set_sin_17_result;
            set_sin_18_result;
            set_sin_19_result;
            set_sin_20_result;
            set_sin_21_result;
            set_sin_22_result;
            set_sin_23_result;
            set_sin_24_result;
            set_sin_25_result;
            set_sin_26_result;
            set_sin_27_result;
            set_sin_28_result;
            set_sin_29_result;


          }
          const entries = {
            89: set_sin_test(); // to add more
            9998: set_sin_result(-89);
            5001: set_sin_result(150);
            5000: set_sin_result(30);
            0: set_sin_0_result;
            1: set_sin_1_result;
            2: set_sin_2_result;
            3: set_sin_3_result;
            4: set_sin_4_result;
            5: set_sin_5_result;
            6: set_sin_6_result;
            7: set_sin_7_result;
            8: set_sin_8_result;
            9: set_sin_9_result;
            10: set_sin_10_result;
            11: set_sin_11_result;
            12: set_sin_12_result;
            13: set_sin_13_result;
            14: set_sin_14_result;
            15: set_sin_15_result;
            16: set_sin_16_result;
            17: set_sin_17_result;
            18: set_sin_18_result;
            19: set_sin_19_result;
            20: set_sin_20_result;
            21: set_sin_21_result;
            22: set_sin_22_result;
            23: set_sin_23_result;
            24: set_sin_24_result;
            25: set_sin_25_result;
            26: set_sin_26_result;
            27: set_sin_27_result;
            28: set_sin_28_result;
            29: set_sin_29_result;

          }
      }

      apply{
          sin_base_degree.apply();
      }
}

control sin_value_vc(in bit<32> degree, out bit<32> result){

      action set_sin_result(bit<32> y){
          result = y;
      }

      action set_sin_test(){
          result = 999;
      }

      action set_sin_0_result(){result = 0; }
      action set_sin_1_result(){result = 17; }
      action set_sin_2_result(){result = 34; }
      action set_sin_3_result(){result = 52; }
      action set_sin_4_result(){result = 69; }
      action set_sin_5_result(){result = 87; }
      action set_sin_6_result(){result = 104; }
      action set_sin_7_result(){result = 121; }
      action set_sin_8_result(){result = 139; }
      action set_sin_9_result(){result = 156; }
      action set_sin_10_result(){result = 173; }
      action set_sin_11_result(){result = 190; }
      action set_sin_12_result(){result = 207; }
      action set_sin_13_result(){result = 224; }
      action set_sin_14_result(){result = 241; }
      action set_sin_15_result(){result = 258; }
      action set_sin_16_result(){result = 275; }
      action set_sin_17_result(){result = 292; }
      action set_sin_18_result(){result = 309; }
      action set_sin_19_result(){result = 325; }
      action set_sin_20_result(){result = 342; }
      action set_sin_21_result(){result = 358; }
      action set_sin_22_result(){result = 374; }
      action set_sin_23_result(){result = 390; }
      action set_sin_24_result(){result = 406; }
      action set_sin_25_result(){result = 422; }
      action set_sin_26_result(){result = 438; }
      action set_sin_27_result(){result = 453; }
      action set_sin_28_result(){result = 469; }
      action set_sin_29_result(){result = 484; }


      table sin_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_sin_result;
            set_sin_test;
            set_sin_0_result;
            set_sin_1_result;
            set_sin_2_result;
            set_sin_3_result;
            set_sin_4_result;
            set_sin_5_result;
            set_sin_6_result;
            set_sin_7_result;
            set_sin_8_result;
            set_sin_9_result;
            set_sin_10_result;
            set_sin_11_result;
            set_sin_12_result;
            set_sin_13_result;
            set_sin_14_result;
            set_sin_15_result;
            set_sin_16_result;
            set_sin_17_result;
            set_sin_18_result;
            set_sin_19_result;
            set_sin_20_result;
            set_sin_21_result;
            set_sin_22_result;
            set_sin_23_result;
            set_sin_24_result;
            set_sin_25_result;
            set_sin_26_result;
            set_sin_27_result;
            set_sin_28_result;
            set_sin_29_result;


          }
          const entries = {
            89: set_sin_test(); // to add more
            9998: set_sin_result(-89);
            5001: set_sin_result(150);
            5000: set_sin_result(30);
            0: set_sin_0_result;
            1: set_sin_1_result;
            2: set_sin_2_result;
            3: set_sin_3_result;
            4: set_sin_4_result;
            5: set_sin_5_result;
            6: set_sin_6_result;
            7: set_sin_7_result;
            8: set_sin_8_result;
            9: set_sin_9_result;
            10: set_sin_10_result;
            11: set_sin_11_result;
            12: set_sin_12_result;
            13: set_sin_13_result;
            14: set_sin_14_result;
            15: set_sin_15_result;
            16: set_sin_16_result;
            17: set_sin_17_result;
            18: set_sin_18_result;
            19: set_sin_19_result;
            20: set_sin_20_result;
            21: set_sin_21_result;
            22: set_sin_22_result;
            23: set_sin_23_result;
            24: set_sin_24_result;
            25: set_sin_25_result;
            26: set_sin_26_result;
            27: set_sin_27_result;
            28: set_sin_28_result;
            29: set_sin_29_result;

          }
      }

      apply{
          sin_base_degree.apply();
      }
}

control tan_value(in bit<32> degree, out bit<32> result){
      /**
      x = degree, result =
      x = 0,      y = tan(0)
      x = 0.1,    y = tan(0.1)
      x =....
      x = 1       y = tan(1)
      x = 1.2     y = tan(1.2)
      x...
      x = 2       y = tan(2)
      x = 2.4     y = tan(2.4)
      ...
      x=4         y = tan(4)
      x = 4.8     y = tan(4.8)
      x = 8       y = tan(8)
      x = 9.6
      x = 45      y = 1
      x >45 and x <50 y > 1 and y < 100000
      x>50 x<60    y > 100000 and y < 10000000
      **/
      bit<10> inpt_val; // hdr.pmu.phasor
      bit<32> output_val;

      action set_tan_result(bit<32> y){
          output_val = y; //set_cos_result(60) = output value
          result = y;
      }

      action set_arctan_0_result(){result = 0; }
      action set_arctan_17_result(){result = 0; }
      action set_arctan_16_result(){result = 0; }
      action set_arctan_18_result(){result = 1; }
      action set_arctan_19_result(){result = 1; }
      action set_arctan_34_result(){result = 1; }
      action set_arctan_33_result(){result = 1; }
      action set_arctan_35_result(){result = 2; }
      action set_arctan_36_result(){result = 2; }
      action set_arctan_37_result(){result = 2; }
      action set_arctan_38_result(){result = 2; }
      action set_arctan_52_result(){result = 3; }
      action set_arctan_51_result(){result = 2; }
      action set_arctan_50_result(){result = 2; }
      action set_arctan_53_result(){result = 3; }
      action set_arctan_54_result(){result = 3; }
      action set_arctan_55_result(){result = 3; }
      action set_arctan_56_result(){result = 3; }
      action set_arctan_57_result(){result = 3; }
      action set_arctan_58_result(){result = 3; }
      action set_arctan_69_result(){result = 3; }
      action set_arctan_68_result(){result = 3; }
      action set_arctan_67_result(){result = 3; }
      action set_arctan_71_result(){result = 4; }
      action set_arctan_70_result(){result = 4; }
      action set_arctan_72_result(){result = 4; }
      action set_arctan_73_result(){result = 4; }
      action set_arctan_74_result(){result = 4; }
      action set_arctan_75_result(){result = 4; }
      action set_arctan_76_result(){result = 4; }
      action set_arctan_77_result(){result = 4; }
      action set_arctan_87_result(){result = 5; }
      action set_arctan_86_result(){result = 4; }
      action set_arctan_85_result(){result = 4; }
      action set_arctan_89_result(){result = 5; }
      action set_arctan_88_result(){result = 5; }
      action set_arctan_90_result(){result = 5; }
      action set_arctan_91_result(){result = 5; }
      action set_arctan_92_result(){result = 5; }
      action set_arctan_93_result(){result = 5; }
      action set_arctan_94_result(){result = 5; }
      action set_arctan_95_result(){result = 5; }
      action set_arctan_96_result(){result = 5; }
      action set_arctan_97_result(){result = 5; }
      action set_arctan_98_result(){result = 5; }
      action set_arctan_104_result(){result = 6; }
      action set_arctan_103_result(){result = 5; }
      action set_arctan_102_result(){result = 5; }
      action set_arctan_101_result(){result = 5; }
      action set_arctan_107_result(){result = 6; }
      action set_arctan_105_result(){result = 6; }
      action set_arctan_106_result(){result = 6; }
      action set_arctan_108_result(){result = 6; }
      action set_arctan_109_result(){result = 6; }
      action set_arctan_110_result(){result = 6; }
      action set_arctan_111_result(){result = 6; }
      action set_arctan_112_result(){result = 6; }
      action set_arctan_113_result(){result = 6; }
      action set_arctan_114_result(){result = 6; }
      action set_arctan_115_result(){result = 6; }
      action set_arctan_116_result(){result = 6; }
      action set_arctan_117_result(){result = 6; }
      action set_arctan_121_result(){result = 6; }
      action set_arctan_120_result(){result = 6; }
      action set_arctan_119_result(){result = 6; }
      action set_arctan_124_result(){result = 7; }
      action set_arctan_123_result(){result = 7; }
      action set_arctan_118_result(){result = 6; }
      action set_arctan_122_result(){result = 6; }
      action set_arctan_125_result(){result = 7; }
      action set_arctan_126_result(){result = 7; }
      action set_arctan_127_result(){result = 7; }
      action set_arctan_128_result(){result = 7; }
      action set_arctan_129_result(){result = 7; }
      action set_arctan_130_result(){result = 7; }
      action set_arctan_131_result(){result = 7; }
      action set_arctan_132_result(){result = 7; }
      action set_arctan_133_result(){result = 7; }
      action set_arctan_134_result(){result = 7; }
      action set_arctan_135_result(){result = 7; }
      action set_arctan_136_result(){result = 7; }
      action set_arctan_139_result(){result = 7; }
      action set_arctan_138_result(){result = 7; }
      action set_arctan_142_result(){result = 8; }
      action set_arctan_141_result(){result = 8; }
      action set_arctan_137_result(){result = 7; }
      action set_arctan_143_result(){result = 8; }
      action set_arctan_140_result(){result = 8; }
      action set_arctan_144_result(){result = 8; }
      action set_arctan_145_result(){result = 8; }
      action set_arctan_146_result(){result = 8; }
      action set_arctan_147_result(){result = 8; }
      action set_arctan_148_result(){result = 8; }
      action set_arctan_149_result(){result = 8; }
      action set_arctan_150_result(){result = 8; }
      action set_arctan_151_result(){result = 8; }
      action set_arctan_152_result(){result = 8; }
      action set_arctan_153_result(){result = 8; }
      action set_arctan_154_result(){result = 8; }
      action set_arctan_155_result(){result = 8; }
      action set_arctan_156_result(){result = 8; }
      action set_arctan_159_result(){result = 9; }
      action set_arctan_158_result(){result = 9; }
      action set_arctan_160_result(){result = 9; }
      action set_arctan_157_result(){result = 8; }
      action set_arctan_161_result(){result = 9; }
      action set_arctan_162_result(){result = 9; }
      action set_arctan_163_result(){result = 9; }
      action set_arctan_164_result(){result = 9; }
      action set_arctan_165_result(){result = 9; }
      action set_arctan_166_result(){result = 9; }
      action set_arctan_167_result(){result = 9; }
      action set_arctan_168_result(){result = 9; }
      action set_arctan_169_result(){result = 9; }
      action set_arctan_170_result(){result = 9; }
      action set_arctan_171_result(){result = 9; }
      action set_arctan_172_result(){result = 9; }
      action set_arctan_173_result(){result = 9; }
      action set_arctan_174_result(){result = 9; }
      action set_arctan_176_result(){result = 10; }
      action set_arctan_175_result(){result = 10; }
      action set_arctan_177_result(){result = 10; }
      action set_arctan_178_result(){result = 10; }
      action set_arctan_179_result(){result = 10; }
      action set_arctan_180_result(){result = 10; }
      action set_arctan_181_result(){result = 10; }
      action set_arctan_182_result(){result = 10; }
      action set_arctan_183_result(){result = 10; }
      action set_arctan_184_result(){result = 10; }
      action set_arctan_185_result(){result = 10; }
      action set_arctan_186_result(){result = 10; }
      action set_arctan_187_result(){result = 10; }
      action set_arctan_188_result(){result = 10; }
      action set_arctan_189_result(){result = 10; }
      action set_arctan_190_result(){result = 10; }
      action set_arctan_191_result(){result = 10; }
      action set_arctan_192_result(){result = 11; }
      action set_arctan_193_result(){result = 11; }
      action set_arctan_194_result(){result = 11; }
      action set_arctan_195_result(){result = 11; }
      action set_arctan_196_result(){result = 11; }
      action set_arctan_197_result(){result = 11; }
      action set_arctan_198_result(){result = 11; }
      action set_arctan_199_result(){result = 11; }
      action set_arctan_200_result(){result = 11; }
      action set_arctan_201_result(){result = 11; }
      action set_arctan_202_result(){result = 11; }
      action set_arctan_203_result(){result = 11; }
      action set_arctan_204_result(){result = 11; }
      action set_arctan_205_result(){result = 11; }
      action set_arctan_206_result(){result = 11; }
      action set_arctan_207_result(){result = 11; }
      action set_arctan_209_result(){result = 11; }
      action set_arctan_208_result(){result = 11; }
      action set_arctan_211_result(){result = 12; }
      action set_arctan_210_result(){result = 12; }
      action set_arctan_212_result(){result = 12; }
      action set_arctan_213_result(){result = 12; }
      action set_arctan_214_result(){result = 12; }
      action set_arctan_215_result(){result = 12; }
      action set_arctan_216_result(){result = 12; }
      action set_arctan_217_result(){result = 12; }
      action set_arctan_218_result(){result = 12; }
      action set_arctan_219_result(){result = 12; }
      action set_arctan_220_result(){result = 12; }
      action set_arctan_221_result(){result = 12; }
      action set_arctan_222_result(){result = 12; }
      action set_arctan_223_result(){result = 12; }
      action set_arctan_224_result(){result = 12; }
      action set_arctan_225_result(){result = 12; }
      action set_arctan_227_result(){result = 13; }
      action set_arctan_228_result(){result = 13; }
      action set_arctan_226_result(){result = 12; }
      action set_arctan_229_result(){result = 13; }
      action set_arctan_230_result(){result = 13; }
      action set_arctan_231_result(){result = 13; }
      action set_arctan_232_result(){result = 13; }
      action set_arctan_233_result(){result = 13; }
      action set_arctan_234_result(){result = 13; }
      action set_arctan_235_result(){result = 13; }
      action set_arctan_236_result(){result = 13; }
      action set_arctan_237_result(){result = 13; }
      action set_arctan_238_result(){result = 13; }
      action set_arctan_239_result(){result = 13; }
      action set_arctan_240_result(){result = 13; }
      action set_arctan_241_result(){result = 13; }
      action set_arctan_242_result(){result = 13; }
      action set_arctan_243_result(){result = 13; }
      action set_arctan_245_result(){result = 14; }
      action set_arctan_246_result(){result = 14; }
      action set_arctan_244_result(){result = 13; }
      action set_arctan_247_result(){result = 14; }
      action set_arctan_248_result(){result = 14; }
      action set_arctan_249_result(){result = 14; }
      action set_arctan_250_result(){result = 14; }
      action set_arctan_251_result(){result = 14; }
      action set_arctan_252_result(){result = 14; }
      action set_arctan_253_result(){result = 14; }
      action set_arctan_255_result(){result = 14; }
      action set_arctan_256_result(){result = 14; }
      action set_arctan_254_result(){result = 14; }
      action set_arctan_257_result(){result = 14; }
      action set_arctan_258_result(){result = 14; }
      action set_arctan_260_result(){result = 14; }
      action set_arctan_261_result(){result = 14; }
      action set_arctan_259_result(){result = 14; }
      action set_arctan_262_result(){result = 15; }
      action set_arctan_263_result(){result = 15; }
      action set_arctan_264_result(){result = 15; }
      action set_arctan_265_result(){result = 15; }
      action set_arctan_266_result(){result = 15; }
      action set_arctan_267_result(){result = 15; }
      action set_arctan_268_result(){result = 15; }
      action set_arctan_269_result(){result = 15; }
      action set_arctan_270_result(){result = 15; }
      action set_arctan_272_result(){result = 15; }
      action set_arctan_273_result(){result = 15; }
      action set_arctan_271_result(){result = 15; }
      action set_arctan_275_result(){result = 15; }
      action set_arctan_276_result(){result = 15; }
      action set_arctan_274_result(){result = 15; }
      action set_arctan_277_result(){result = 15; }
      action set_arctan_278_result(){result = 15; }
      action set_arctan_279_result(){result = 15; }
      action set_arctan_280_result(){result = 16; }
      action set_arctan_281_result(){result = 16; }
      action set_arctan_283_result(){result = 16; }
      action set_arctan_284_result(){result = 16; }
      action set_arctan_282_result(){result = 16; }
      action set_arctan_285_result(){result = 16; }
      action set_arctan_286_result(){result = 16; }
      action set_arctan_287_result(){result = 16; }
      action set_arctan_289_result(){result = 16; }
      action set_arctan_290_result(){result = 16; }
      action set_arctan_288_result(){result = 16; }
      action set_arctan_292_result(){result = 16; }
      action set_arctan_293_result(){result = 16; }
      action set_arctan_291_result(){result = 16; }
      action set_arctan_295_result(){result = 16; }
      action set_arctan_296_result(){result = 16; }
      action set_arctan_294_result(){result = 16; }
      action set_arctan_297_result(){result = 17; }
      action set_arctan_299_result(){result = 17; }
      action set_arctan_298_result(){result = 17; }
      action set_arctan_300_result(){result = 17; }
      action set_arctan_301_result(){result = 17; }


      action set_tan_test(){
          result = 29;
      }

      table tan_base_degree{
          key = {
              degree : exact;
          }
          actions = {
            set_tan_result;
            set_tan_test;
            set_arctan_0_result;
            set_arctan_17_result;
            set_arctan_16_result;
            set_arctan_18_result;
            set_arctan_19_result;
            set_arctan_34_result;
            set_arctan_33_result;
            set_arctan_35_result;
            set_arctan_36_result;
            set_arctan_37_result;
            set_arctan_38_result;
            set_arctan_52_result;
            set_arctan_51_result;
            set_arctan_50_result;
            set_arctan_53_result;
            set_arctan_54_result;
            set_arctan_55_result;
            set_arctan_56_result;
            set_arctan_57_result;
            set_arctan_58_result;
            set_arctan_69_result;
            set_arctan_68_result;
            set_arctan_67_result;
            set_arctan_71_result;
            set_arctan_70_result;
            set_arctan_72_result;
            set_arctan_73_result;
            set_arctan_74_result;
            set_arctan_75_result;
            set_arctan_76_result;
            set_arctan_77_result;
            set_arctan_87_result;
            set_arctan_86_result;
            set_arctan_85_result;
            set_arctan_89_result;
            set_arctan_88_result;
            set_arctan_90_result;
            set_arctan_91_result;
            set_arctan_92_result;
            set_arctan_93_result;
            set_arctan_94_result;
            set_arctan_95_result;
            set_arctan_96_result;
            set_arctan_97_result;
            set_arctan_98_result;
            set_arctan_104_result;
            set_arctan_103_result;
            set_arctan_102_result;
            set_arctan_101_result;
            set_arctan_107_result;
            set_arctan_105_result;
            set_arctan_106_result;
            set_arctan_108_result;
            set_arctan_109_result;
            set_arctan_110_result;
            set_arctan_111_result;
            set_arctan_112_result;
            set_arctan_113_result;
            set_arctan_114_result;
            set_arctan_115_result;
            set_arctan_116_result;
            set_arctan_117_result;
            set_arctan_121_result;
            set_arctan_120_result;
            set_arctan_119_result;
            set_arctan_124_result;
            set_arctan_123_result;
            set_arctan_118_result;
            set_arctan_122_result;
            set_arctan_125_result;
            set_arctan_126_result;
            set_arctan_127_result;
            set_arctan_128_result;
            set_arctan_129_result;
            set_arctan_130_result;
            set_arctan_131_result;
            set_arctan_132_result;
            set_arctan_133_result;
            set_arctan_134_result;
            set_arctan_135_result;
            set_arctan_136_result;
            set_arctan_139_result;
            set_arctan_138_result;
            set_arctan_142_result;
            set_arctan_141_result;
            set_arctan_137_result;
            set_arctan_143_result;
            set_arctan_140_result;
            set_arctan_144_result;
            set_arctan_145_result;
            set_arctan_146_result;
            set_arctan_147_result;
            set_arctan_148_result;
            set_arctan_149_result;
            set_arctan_150_result;
            set_arctan_151_result;
            set_arctan_152_result;
            set_arctan_153_result;
            set_arctan_154_result;
            set_arctan_155_result;
            set_arctan_156_result;
            set_arctan_159_result;
            set_arctan_158_result;
            set_arctan_160_result;
            set_arctan_157_result;
            set_arctan_161_result;
            set_arctan_162_result;
            set_arctan_163_result;
            set_arctan_164_result;
            set_arctan_165_result;
            set_arctan_166_result;
            set_arctan_167_result;
            set_arctan_168_result;
            set_arctan_169_result;
            set_arctan_170_result;
            set_arctan_171_result;
            set_arctan_172_result;
            set_arctan_173_result;
            set_arctan_174_result;
            set_arctan_176_result;
            set_arctan_175_result;
            set_arctan_177_result;
            set_arctan_178_result;
            set_arctan_179_result;
            set_arctan_180_result;
            set_arctan_181_result;
            set_arctan_182_result;
            set_arctan_183_result;
            set_arctan_184_result;
            set_arctan_185_result;
            set_arctan_186_result;
            set_arctan_187_result;
            set_arctan_188_result;
            set_arctan_189_result;
            set_arctan_190_result;
            set_arctan_191_result;
            set_arctan_192_result;
            set_arctan_193_result;
            set_arctan_194_result;
            set_arctan_195_result;
            set_arctan_196_result;
            set_arctan_197_result;
            set_arctan_198_result;
            set_arctan_199_result;
            set_arctan_200_result;
            set_arctan_201_result;
            set_arctan_202_result;
            set_arctan_203_result;
            set_arctan_204_result;
            set_arctan_205_result;
            set_arctan_206_result;
            set_arctan_207_result;
            set_arctan_209_result;
            set_arctan_208_result;
            set_arctan_211_result;
            set_arctan_210_result;
            set_arctan_212_result;
            set_arctan_213_result;
            set_arctan_214_result;
            set_arctan_215_result;
            set_arctan_216_result;
            set_arctan_217_result;
            set_arctan_218_result;
            set_arctan_219_result;
            set_arctan_220_result;
            set_arctan_221_result;
            set_arctan_222_result;
            set_arctan_223_result;
            set_arctan_224_result;
            set_arctan_225_result;
            set_arctan_227_result;
            set_arctan_228_result;
            set_arctan_226_result;
            set_arctan_229_result;
            set_arctan_230_result;
            set_arctan_231_result;
            set_arctan_232_result;
            set_arctan_233_result;
            set_arctan_234_result;
            set_arctan_235_result;
            set_arctan_236_result;
            set_arctan_237_result;
            set_arctan_238_result;
            set_arctan_239_result;
            set_arctan_240_result;
            set_arctan_241_result;
            set_arctan_242_result;
            set_arctan_243_result;
            set_arctan_245_result;
            set_arctan_246_result;
            set_arctan_244_result;
            set_arctan_247_result;
            set_arctan_248_result;
            set_arctan_249_result;
            set_arctan_250_result;
            set_arctan_251_result;
            set_arctan_252_result;
            set_arctan_253_result;
            set_arctan_255_result;
            set_arctan_256_result;
            set_arctan_254_result;
            set_arctan_257_result;
            set_arctan_258_result;
            set_arctan_260_result;
            set_arctan_261_result;
            set_arctan_259_result;
            set_arctan_262_result;
            set_arctan_263_result;
            set_arctan_264_result;
            set_arctan_265_result;
            set_arctan_266_result;
            set_arctan_267_result;
            set_arctan_268_result;
            set_arctan_269_result;
            set_arctan_270_result;
            set_arctan_272_result;
            set_arctan_273_result;
            set_arctan_271_result;
            set_arctan_275_result;
            set_arctan_276_result;
            set_arctan_274_result;
            set_arctan_277_result;
            set_arctan_278_result;
            set_arctan_279_result;
            set_arctan_280_result;
            set_arctan_281_result;
            set_arctan_283_result;
            set_arctan_284_result;
            set_arctan_282_result;
            set_arctan_285_result;
            set_arctan_286_result;
            set_arctan_287_result;
            set_arctan_289_result;
            set_arctan_290_result;
            set_arctan_288_result;
            set_arctan_292_result;
            set_arctan_293_result;
            set_arctan_291_result;
            set_arctan_295_result;
            set_arctan_296_result;
            set_arctan_294_result;
            set_arctan_297_result;
            set_arctan_299_result;
            set_arctan_298_result;
            set_arctan_300_result;
            set_arctan_301_result;

          }
          const entries = {
            5633600: set_tan_test; // to add more
            0 : set_arctan_0_result;
            17 : set_arctan_17_result;
            16 : set_arctan_16_result;
            18 : set_arctan_18_result;
            19 : set_arctan_19_result;
            34 : set_arctan_34_result;
            33 : set_arctan_33_result;
            35 : set_arctan_35_result;
            36 : set_arctan_36_result;
            37 : set_arctan_37_result;
            38 : set_arctan_38_result;
            52 : set_arctan_52_result;
            51 : set_arctan_51_result;
            50 : set_arctan_50_result;
            53 : set_arctan_53_result;
            54 : set_arctan_54_result;
            55 : set_arctan_55_result;
            56 : set_arctan_56_result;
            57 : set_arctan_57_result;
            58 : set_arctan_58_result;
            69 : set_arctan_69_result;
            68 : set_arctan_68_result;
            67 : set_arctan_67_result;
            71 : set_arctan_71_result;
            70 : set_arctan_70_result;
            72 : set_arctan_72_result;
            73 : set_arctan_73_result;
            74 : set_arctan_74_result;
            75 : set_arctan_75_result;
            76 : set_arctan_76_result;
            77 : set_arctan_77_result;
            87 : set_arctan_87_result;
            86 : set_arctan_86_result;
            85 : set_arctan_85_result;
            89 : set_arctan_89_result;
            88 : set_arctan_88_result;
            90 : set_arctan_90_result;
            91 : set_arctan_91_result;
            92 : set_arctan_92_result;
            93 : set_arctan_93_result;
            94 : set_arctan_94_result;
            95 : set_arctan_95_result;
            96 : set_arctan_96_result;
            97 : set_arctan_97_result;
            98 : set_arctan_98_result;
            104 : set_arctan_104_result;
            103 : set_arctan_103_result;
            102 : set_arctan_102_result;
            101 : set_arctan_101_result;
            107 : set_arctan_107_result;
            105 : set_arctan_105_result;
            106 : set_arctan_106_result;
            108 : set_arctan_108_result;
            109 : set_arctan_109_result;
            110 : set_arctan_110_result;
            111 : set_arctan_111_result;
            112 : set_arctan_112_result;
            113 : set_arctan_113_result;
            114 : set_arctan_114_result;
            115 : set_arctan_115_result;
            116 : set_arctan_116_result;
            117 : set_arctan_117_result;
            121 : set_arctan_121_result;
            120 : set_arctan_120_result;
            119 : set_arctan_119_result;
            124 : set_arctan_124_result;
            123 : set_arctan_123_result;
            118 : set_arctan_118_result;
            122 : set_arctan_122_result;
            125 : set_arctan_125_result;
            126 : set_arctan_126_result;
            127 : set_arctan_127_result;
            128 : set_arctan_128_result;
            129 : set_arctan_129_result;
            130 : set_arctan_130_result;
            131 : set_arctan_131_result;
            132 : set_arctan_132_result;
            133 : set_arctan_133_result;
            134 : set_arctan_134_result;
            135 : set_arctan_135_result;
            136 : set_arctan_136_result;
            139 : set_arctan_139_result;
            138 : set_arctan_138_result;
            142 : set_arctan_142_result;
            141 : set_arctan_141_result;
            137 : set_arctan_137_result;
            143 : set_arctan_143_result;
            140 : set_arctan_140_result;
            144 : set_arctan_144_result;
            145 : set_arctan_145_result;
            146 : set_arctan_146_result;
            147 : set_arctan_147_result;
            148 : set_arctan_148_result;
            149 : set_arctan_149_result;
            150 : set_arctan_150_result;
            151 : set_arctan_151_result;
            152 : set_arctan_152_result;
            153 : set_arctan_153_result;
            154 : set_arctan_154_result;
            155 : set_arctan_155_result;
            156 : set_arctan_156_result;
            159 : set_arctan_159_result;
            158 : set_arctan_158_result;
            160 : set_arctan_160_result;
            157 : set_arctan_157_result;
            161 : set_arctan_161_result;
            162 : set_arctan_162_result;
            163 : set_arctan_163_result;
            164 : set_arctan_164_result;
            165 : set_arctan_165_result;
            166 : set_arctan_166_result;
            167 : set_arctan_167_result;
            168 : set_arctan_168_result;
            169 : set_arctan_169_result;
            170 : set_arctan_170_result;
            171 : set_arctan_171_result;
            172 : set_arctan_172_result;
            173 : set_arctan_173_result;
            174 : set_arctan_174_result;
            176 : set_arctan_176_result;
            175 : set_arctan_175_result;
            177 : set_arctan_177_result;
            178 : set_arctan_178_result;
            179 : set_arctan_179_result;
            180 : set_arctan_180_result;
            181 : set_arctan_181_result;
            182 : set_arctan_182_result;
            183 : set_arctan_183_result;
            184 : set_arctan_184_result;
            185 : set_arctan_185_result;
            186 : set_arctan_186_result;
            187 : set_arctan_187_result;
            188 : set_arctan_188_result;
            189 : set_arctan_189_result;
            190 : set_arctan_190_result;
            191 : set_arctan_191_result;
            192 : set_arctan_192_result;
            193 : set_arctan_193_result;
            194 : set_arctan_194_result;
            195 : set_arctan_195_result;
            196 : set_arctan_196_result;
            197 : set_arctan_197_result;
            198 : set_arctan_198_result;
            199 : set_arctan_199_result;
            200 : set_arctan_200_result;
            201 : set_arctan_201_result;
            202 : set_arctan_202_result;
            203 : set_arctan_203_result;
            204 : set_arctan_204_result;
            205 : set_arctan_205_result;
            206 : set_arctan_206_result;
            207 : set_arctan_207_result;
            209 : set_arctan_209_result;
            208 : set_arctan_208_result;
            211 : set_arctan_211_result;
            210 : set_arctan_210_result;
            212 : set_arctan_212_result;
            213 : set_arctan_213_result;
            214 : set_arctan_214_result;
            215 : set_arctan_215_result;
            216 : set_arctan_216_result;
            217 : set_arctan_217_result;
            218 : set_arctan_218_result;
            219 : set_arctan_219_result;
            220 : set_arctan_220_result;
            221 : set_arctan_221_result;
            222 : set_arctan_222_result;
            223 : set_arctan_223_result;
            224 : set_arctan_224_result;
            225 : set_arctan_225_result;
            227 : set_arctan_227_result;
            228 : set_arctan_228_result;
            226 : set_arctan_226_result;
            229 : set_arctan_229_result;
            230 : set_arctan_230_result;
            231 : set_arctan_231_result;
            232 : set_arctan_232_result;
            233 : set_arctan_233_result;
            234 : set_arctan_234_result;
            235 : set_arctan_235_result;
            236 : set_arctan_236_result;
            237 : set_arctan_237_result;
            238 : set_arctan_238_result;
            239 : set_arctan_239_result;
            240 : set_arctan_240_result;
            241 : set_arctan_241_result;
            242 : set_arctan_242_result;
            243 : set_arctan_243_result;
            245 : set_arctan_245_result;
            246 : set_arctan_246_result;
            244 : set_arctan_244_result;
            247 : set_arctan_247_result;
            248 : set_arctan_248_result;
            249 : set_arctan_249_result;
            250 : set_arctan_250_result;
            251 : set_arctan_251_result;
            252 : set_arctan_252_result;
            253 : set_arctan_253_result;
            255 : set_arctan_255_result;
            256 : set_arctan_256_result;
            254 : set_arctan_254_result;
            257 : set_arctan_257_result;
            258 : set_arctan_258_result;
            260 : set_arctan_260_result;
            261 : set_arctan_261_result;
            259 : set_arctan_259_result;
            262 : set_arctan_262_result;
            263 : set_arctan_263_result;
            264 : set_arctan_264_result;
            265 : set_arctan_265_result;
            266 : set_arctan_266_result;
            267 : set_arctan_267_result;
            268 : set_arctan_268_result;
            269 : set_arctan_269_result;
            270 : set_arctan_270_result;
            272 : set_arctan_272_result;
            273 : set_arctan_273_result;
            271 : set_arctan_271_result;
            275 : set_arctan_275_result;
            276 : set_arctan_276_result;
            274 : set_arctan_274_result;
            277 : set_arctan_277_result;
            278 : set_arctan_278_result;
            279 : set_arctan_279_result;
            280 : set_arctan_280_result;
            281 : set_arctan_281_result;
            283 : set_arctan_283_result;
            284 : set_arctan_284_result;
            282 : set_arctan_282_result;
            285 : set_arctan_285_result;
            286 : set_arctan_286_result;
            287 : set_arctan_287_result;
            289 : set_arctan_289_result;
            290 : set_arctan_290_result;
            288 : set_arctan_288_result;
            292 : set_arctan_292_result;
            293 : set_arctan_293_result;
            291 : set_arctan_291_result;
            295 : set_arctan_295_result;
            296 : set_arctan_296_result;
            294 : set_arctan_294_result;
            297 : set_arctan_297_result;
            299 : set_arctan_299_result;
            298 : set_arctan_298_result;
            300 : set_arctan_300_result;
            301 : set_arctan_301_result;

          }
      }

      apply{
          tan_base_degree.apply();
      }
}

/*************************************************************************
**************  1/real division   P R O C E S S I N G   *******************
*************************************************************************/

control division_val(in bit<32> divisor, out bit<32> result){

      action set_division_res(){
          result = 28;
      }

      action set_one_div_94000(){result = 106;}
      action set_one_div_95000(){result = 105;}
      action set_one_div_96000(){result = 104;}
      action set_one_div_97000(){result = 103;}
      action set_one_div_91905(){result = 108;}
      action set_one_div_92904(){result = 107;}
      action set_one_div_93903(){result = 106;}
      action set_one_div_94902(){result = 105;}
      action set_one_div_95901(){result = 104;}
      action set_one_div_96900(){result = 103;}
      action set_one_div_91810(){result = 108;}
      action set_one_div_92808(){result = 107;}
      action set_one_div_93806(){result = 106;}
      action set_one_div_94804(){result = 105;}
      action set_one_div_95802(){result = 104;}
      action set_one_div_96800(){result = 103;}
      action set_one_div_91715(){result = 109;}
      action set_one_div_92712(){result = 107;}
      action set_one_div_93709(){result = 106;}
      action set_one_div_94706(){result = 105;}
      action set_one_div_95703(){result = 104;}
      action set_one_div_96700(){result = 103;}
      action set_one_div_91620(){result = 109;}
      action set_one_div_92616(){result = 107;}
      action set_one_div_93612(){result = 106;}
      action set_one_div_94608(){result = 105;}
      action set_one_div_95604(){result = 104;}
      action set_one_div_96600(){result = 103;}
      action set_one_div_91430(){result = 109;}
      action set_one_div_92424(){result = 108;}
      action set_one_div_93418(){result = 107;}
      action set_one_div_94412(){result = 105;}
      action set_one_div_95406(){result = 104;}
      action set_one_div_96400(){result = 103;}
      action set_one_div_91240(){result = 109;}
      action set_one_div_92232(){result = 108;}
      action set_one_div_93224(){result = 107;}
      action set_one_div_94216(){result = 106;}
      action set_one_div_95208(){result = 105;}
      action set_one_div_96200(){result = 103;}
      action set_one_div_91050(){result = 109;}
      action set_one_div_92040(){result = 108;}
      action set_one_div_93030(){result = 107;}
      action set_one_div_94020(){result = 106;}
      action set_one_div_95010(){result = 105;}
      action set_one_div_90765(){result = 110;}
      action set_one_div_91752(){result = 108;}
      action set_one_div_92739(){result = 107;}
      action set_one_div_93726(){result = 106;}
      action set_one_div_94713(){result = 105;}
      action set_one_div_95700(){result = 104;}
      action set_one_div_90480(){result = 110;}
      action set_one_div_91464(){result = 109;}
      action set_one_div_92448(){result = 108;}
      action set_one_div_93432(){result = 107;}
      action set_one_div_94416(){result = 105;}
      action set_one_div_95400(){result = 104;}
      action set_one_div_90195(){result = 110;}
      action set_one_div_91176(){result = 109;}
      action set_one_div_92157(){result = 108;}
      action set_one_div_93138(){result = 107;}
      action set_one_div_94119(){result = 106;}
      action set_one_div_95100(){result = 105;}
      action set_one_div_89910(){result = 111;}
      action set_one_div_90888(){result = 110;}
      action set_one_div_91866(){result = 108;}
      action set_one_div_92844(){result = 107;}
      action set_one_div_93822(){result = 106;}
      action set_one_div_94800(){result = 105;}
      action set_one_div_89530(){result = 111;}
      action set_one_div_90504(){result = 110;}
      action set_one_div_91478(){result = 109;}
      action set_one_div_92452(){result = 108;}
      action set_one_div_93426(){result = 107;}
      action set_one_div_94400(){result = 105;}
      action set_one_div_89150(){result = 112;}
      action set_one_div_90120(){result = 110;}
      action set_one_div_91090(){result = 109;}
      action set_one_div_92060(){result = 108;}
      action set_one_div_88675(){result = 112;}
      action set_one_div_89640(){result = 111;}
      action set_one_div_90605(){result = 110;}
      action set_one_div_91570(){result = 109;}
      action set_one_div_92535(){result = 108;}
      action set_one_div_93500(){result = 106;}
      action set_one_div_88295(){result = 113;}
      action set_one_div_89256(){result = 112;}
      action set_one_div_90217(){result = 110;}
      action set_one_div_91178(){result = 109;}
      action set_one_div_92139(){result = 108;}
      action set_one_div_93100(){result = 107;}
      action set_one_div_87820(){result = 113;}
      action set_one_div_88776(){result = 112;}
      action set_one_div_89732(){result = 111;}
      action set_one_div_90688(){result = 110;}
      action set_one_div_91644(){result = 109;}
      action set_one_div_92600(){result = 107;}
      action set_one_div_87345(){result = 114;}
      action set_one_div_88296(){result = 113;}
      action set_one_div_89247(){result = 112;}
      action set_one_div_90198(){result = 110;}
      action set_one_div_91149(){result = 109;}
      action set_one_div_92100(){result = 108;}
      action set_one_div_86775(){result = 115;}
      action set_one_div_87720(){result = 113;}
      action set_one_div_88665(){result = 112;}
      action set_one_div_89610(){result = 111;}
      action set_one_div_90555(){result = 110;}
      action set_one_div_91500(){result = 109;}
      action set_one_div_86205(){result = 116;}
      action set_one_div_87144(){result = 114;}
      action set_one_div_88083(){result = 113;}
      action set_one_div_89022(){result = 112;}
      action set_one_div_89961(){result = 111;}
      action set_one_div_90900(){result = 110;}
      action set_one_div_85635(){result = 116;}
      action set_one_div_86568(){result = 115;}
      action set_one_div_87501(){result = 114;}
      action set_one_div_88434(){result = 113;}
      action set_one_div_89367(){result = 111;}
      action set_one_div_90300(){result = 110;}
      action set_one_div_85065(){result = 117;}
      action set_one_div_85992(){result = 116;}
      action set_one_div_86919(){result = 115;}
      action set_one_div_87846(){result = 113;}
      action set_one_div_88773(){result = 112;}
      action set_one_div_89700(){result = 111;}
      action set_one_div_84400(){result = 118;}
      action set_one_div_85320(){result = 117;}
      action set_one_div_86240(){result = 115;}
      action set_one_div_87160(){result = 114;}
      action set_one_div_88080(){result = 113;}
      action set_one_div_89000(){result = 112;}
      action set_one_div_83735(){result = 119;}
      action set_one_div_84648(){result = 118;}
      action set_one_div_85561(){result = 116;}
      action set_one_div_86474(){result = 115;}
      action set_one_div_87387(){result = 114;}
      action set_one_div_88300(){result = 113;}
      action set_one_div_83070(){result = 120;}
      action set_one_div_83976(){result = 119;}
      action set_one_div_84882(){result = 117;}
      action set_one_div_85788(){result = 116;}
      action set_one_div_86694(){result = 115;}
      action set_one_div_87600(){result = 114;}
      action set_one_div_82310(){result = 121;}
      action set_one_div_83208(){result = 120;}
      action set_one_div_84106(){result = 118;}
      action set_one_div_85004(){result = 117;}
      action set_one_div_85902(){result = 116;}
      action set_one_div_86800(){result = 115;}
      action set_one_div_81645(){result = 122;}
      action set_one_div_82536(){result = 121;}
      action set_one_div_83427(){result = 119;}
      action set_one_div_84318(){result = 118;}
      action set_one_div_85209(){result = 117;}
      action set_one_div_86100(){result = 116;}
      action set_one_div_80790(){result = 123;}
      action set_one_div_81672(){result = 122;}
      action set_one_div_82554(){result = 121;}
      action set_one_div_83436(){result = 119;}
      action set_one_div_85200(){result = 117;}
      action set_one_div_80030(){result = 124;}
      action set_one_div_80904(){result = 123;}
      action set_one_div_81778(){result = 122;}
      action set_one_div_82652(){result = 120;}
      action set_one_div_83526(){result = 119;}
      action set_one_div_92000(){result = 108;}
      action set_one_div_93000(){result = 107;}
      action set_one_div_88905(){result = 112;}
      action set_one_div_89904(){result = 111;}
      action set_one_div_90903(){result = 110;}
      action set_one_div_91902(){result = 108;}
      action set_one_div_92901(){result = 107;}
      action set_one_div_93900(){result = 106;}
      action set_one_div_88810(){result = 112;}
      action set_one_div_89808(){result = 111;}
      action set_one_div_90806(){result = 110;}
      action set_one_div_91804(){result = 108;}
      action set_one_div_92802(){result = 107;}
      action set_one_div_93800(){result = 106;}
      action set_one_div_88715(){result = 112;}
      action set_one_div_89712(){result = 111;}
      action set_one_div_90709(){result = 110;}
      action set_one_div_91706(){result = 109;}
      action set_one_div_92703(){result = 107;}
      action set_one_div_93700(){result = 106;}
      action set_one_div_88620(){result = 112;}
      action set_one_div_89616(){result = 111;}
      action set_one_div_90612(){result = 110;}
      action set_one_div_91608(){result = 109;}
      action set_one_div_92604(){result = 107;}
      action set_one_div_93600(){result = 106;}
      action set_one_div_88430(){result = 113;}
      action set_one_div_89424(){result = 111;}
      action set_one_div_90418(){result = 110;}
      action set_one_div_91412(){result = 109;}
      action set_one_div_92406(){result = 108;}
      action set_one_div_93400(){result = 107;}
      action set_one_div_88240(){result = 113;}
      action set_one_div_89232(){result = 112;}
      action set_one_div_90224(){result = 110;}
      action set_one_div_91216(){result = 109;}
      action set_one_div_92208(){result = 108;}
      action set_one_div_93200(){result = 107;}
      action set_one_div_88050(){result = 113;}
      action set_one_div_89040(){result = 112;}
      action set_one_div_90030(){result = 111;}
      action set_one_div_91020(){result = 109;}
      action set_one_div_92010(){result = 108;}
      action set_one_div_87765(){result = 113;}
      action set_one_div_88752(){result = 112;}
      action set_one_div_89739(){result = 111;}
      action set_one_div_90726(){result = 110;}
      action set_one_div_91713(){result = 109;}
      action set_one_div_92700(){result = 107;}
      action set_one_div_87480(){result = 114;}
      action set_one_div_88464(){result = 113;}
      action set_one_div_89448(){result = 111;}
      action set_one_div_90432(){result = 110;}
      action set_one_div_91416(){result = 109;}
      action set_one_div_92400(){result = 108;}
      action set_one_div_87195(){result = 114;}
      action set_one_div_88176(){result = 113;}
      action set_one_div_89157(){result = 112;}
      action set_one_div_90138(){result = 110;}
      action set_one_div_91119(){result = 109;}
      action set_one_div_86910(){result = 115;}
      action set_one_div_87888(){result = 113;}
      action set_one_div_88866(){result = 112;}
      action set_one_div_89844(){result = 111;}
      action set_one_div_90822(){result = 110;}
      action set_one_div_91800(){result = 108;}
      action set_one_div_86530(){result = 115;}
      action set_one_div_87504(){result = 114;}
      action set_one_div_88478(){result = 113;}
      action set_one_div_89452(){result = 111;}
      action set_one_div_90426(){result = 110;}
      action set_one_div_91400(){result = 109;}
      action set_one_div_86150(){result = 116;}
      action set_one_div_87120(){result = 114;}
      action set_one_div_88090(){result = 113;}
      action set_one_div_89060(){result = 112;}
      action set_one_div_91000(){result = 109;}
      action set_one_div_85675(){result = 116;}
      action set_one_div_86640(){result = 115;}
      action set_one_div_87605(){result = 114;}
      action set_one_div_88570(){result = 112;}
      action set_one_div_89535(){result = 111;}
      action set_one_div_90500(){result = 110;}
      action set_one_div_85295(){result = 117;}
      action set_one_div_86256(){result = 115;}
      action set_one_div_87217(){result = 114;}
      action set_one_div_88178(){result = 113;}
      action set_one_div_89139(){result = 112;}
      action set_one_div_90100(){result = 110;}
      action set_one_div_84820(){result = 117;}
      action set_one_div_85776(){result = 116;}
      action set_one_div_86732(){result = 115;}
      action set_one_div_87688(){result = 114;}
      action set_one_div_88644(){result = 112;}
      action set_one_div_89600(){result = 111;}
      action set_one_div_84345(){result = 118;}
      action set_one_div_85296(){result = 117;}
      action set_one_div_86247(){result = 115;}
      action set_one_div_87198(){result = 114;}
      action set_one_div_88149(){result = 113;}
      action set_one_div_89100(){result = 112;}
      action set_one_div_83775(){result = 119;}
      action set_one_div_84720(){result = 118;}
      action set_one_div_85665(){result = 116;}
      action set_one_div_86610(){result = 115;}
      action set_one_div_87555(){result = 114;}
      action set_one_div_88500(){result = 112;}
      action set_one_div_83205(){result = 120;}
      action set_one_div_84144(){result = 118;}
      action set_one_div_85083(){result = 117;}
      action set_one_div_86022(){result = 116;}
      action set_one_div_86961(){result = 114;}
      action set_one_div_87900(){result = 113;}
      action set_one_div_82635(){result = 121;}
      action set_one_div_83568(){result = 119;}
      action set_one_div_84501(){result = 118;}
      action set_one_div_85434(){result = 117;}
      action set_one_div_86367(){result = 115;}
      action set_one_div_87300(){result = 114;}
      action set_one_div_82065(){result = 121;}
      action set_one_div_82992(){result = 120;}
      action set_one_div_83919(){result = 119;}
      action set_one_div_84846(){result = 117;}
      action set_one_div_85773(){result = 116;}
      action set_one_div_86700(){result = 115;}
      action set_one_div_81400(){result = 122;}
      action set_one_div_82320(){result = 121;}
      action set_one_div_83240(){result = 120;}
      action set_one_div_84160(){result = 118;}
      action set_one_div_85080(){result = 117;}
      action set_one_div_86000(){result = 116;}
      action set_one_div_80735(){result = 123;}
      action set_one_div_81648(){result = 122;}
      action set_one_div_82561(){result = 121;}
      action set_one_div_83474(){result = 119;}
      action set_one_div_84387(){result = 118;}
      action set_one_div_85300(){result = 117;}
      action set_one_div_80070(){result = 124;}
      action set_one_div_80976(){result = 123;}
      action set_one_div_81882(){result = 122;}
      action set_one_div_82788(){result = 120;}
      action set_one_div_83694(){result = 119;}
      action set_one_div_84600(){result = 118;}
      action set_one_div_79310(){result = 126;}
      action set_one_div_80208(){result = 124;}
      action set_one_div_81106(){result = 123;}
      action set_one_div_82004(){result = 121;}
      action set_one_div_82902(){result = 120;}
      action set_one_div_83800(){result = 119;}
      action set_one_div_78645(){result = 127;}
      action set_one_div_79536(){result = 125;}
      action set_one_div_80427(){result = 124;}
      action set_one_div_81318(){result = 122;}
      action set_one_div_82209(){result = 121;}
      action set_one_div_83100(){result = 120;}
      action set_one_div_77790(){result = 128;}
      action set_one_div_78672(){result = 127;}
      action set_one_div_79554(){result = 125;}
      action set_one_div_80436(){result = 124;}
      action set_one_div_82200(){result = 121;}
      action set_one_div_77030(){result = 129;}
      action set_one_div_77904(){result = 128;}
      action set_one_div_78778(){result = 126;}
      action set_one_div_79652(){result = 125;}
      action set_one_div_80526(){result = 124;}
      action set_one_div_90000(){result = 111;}
      action set_one_div_85905(){result = 116;}
      action set_one_div_86904(){result = 115;}
      action set_one_div_87903(){result = 113;}
      action set_one_div_88902(){result = 112;}
      action set_one_div_89901(){result = 111;}
      action set_one_div_85810(){result = 116;}
      action set_one_div_86808(){result = 115;}
      action set_one_div_87806(){result = 113;}
      action set_one_div_88804(){result = 112;}
      action set_one_div_89802(){result = 111;}
      action set_one_div_90800(){result = 110;}
      action set_one_div_85715(){result = 116;}
      action set_one_div_86712(){result = 115;}
      action set_one_div_87709(){result = 114;}
      action set_one_div_88706(){result = 112;}
      action set_one_div_89703(){result = 111;}
      action set_one_div_90700(){result = 110;}
      action set_one_div_85620(){result = 116;}
      action set_one_div_86616(){result = 115;}
      action set_one_div_87612(){result = 114;}
      action set_one_div_88608(){result = 112;}
      action set_one_div_89604(){result = 111;}
      action set_one_div_90600(){result = 110;}
      action set_one_div_85430(){result = 117;}
      action set_one_div_86424(){result = 115;}
      action set_one_div_87418(){result = 114;}
      action set_one_div_88412(){result = 113;}
      action set_one_div_89406(){result = 111;}
      action set_one_div_90400(){result = 110;}
      action set_one_div_85240(){result = 117;}
      action set_one_div_86232(){result = 115;}
      action set_one_div_87224(){result = 114;}
      action set_one_div_88216(){result = 113;}
      action set_one_div_89208(){result = 112;}
      action set_one_div_90200(){result = 110;}
      action set_one_div_85050(){result = 117;}
      action set_one_div_86040(){result = 116;}
      action set_one_div_87030(){result = 114;}
      action set_one_div_88020(){result = 113;}
      action set_one_div_89010(){result = 112;}
      action set_one_div_84765(){result = 117;}
      action set_one_div_85752(){result = 116;}
      action set_one_div_86739(){result = 115;}
      action set_one_div_87726(){result = 113;}
      action set_one_div_88713(){result = 112;}
      action set_one_div_84480(){result = 118;}
      action set_one_div_85464(){result = 117;}
      action set_one_div_86448(){result = 115;}
      action set_one_div_87432(){result = 114;}
      action set_one_div_88416(){result = 113;}
      action set_one_div_89400(){result = 111;}
      action set_one_div_84195(){result = 118;}
      action set_one_div_85176(){result = 117;}
      action set_one_div_86157(){result = 116;}
      action set_one_div_87138(){result = 114;}
      action set_one_div_88119(){result = 113;}
      action set_one_div_83910(){result = 119;}
      action set_one_div_84888(){result = 117;}
      action set_one_div_85866(){result = 116;}
      action set_one_div_86844(){result = 115;}
      action set_one_div_87822(){result = 113;}
      action set_one_div_88800(){result = 112;}
      action set_one_div_83530(){result = 119;}
      action set_one_div_84504(){result = 118;}
      action set_one_div_85478(){result = 116;}
      action set_one_div_86452(){result = 115;}
      action set_one_div_87426(){result = 114;}
      action set_one_div_88400(){result = 113;}
      action set_one_div_83150(){result = 120;}
      action set_one_div_84120(){result = 118;}
      action set_one_div_85090(){result = 117;}
      action set_one_div_86060(){result = 116;}
      action set_one_div_88000(){result = 113;}
      action set_one_div_82675(){result = 120;}
      action set_one_div_83640(){result = 119;}
      action set_one_div_84605(){result = 118;}
      action set_one_div_85570(){result = 116;}
      action set_one_div_86535(){result = 115;}
      action set_one_div_87500(){result = 114;}
      action set_one_div_82295(){result = 121;}
      action set_one_div_83256(){result = 120;}
      action set_one_div_84217(){result = 118;}
      action set_one_div_85178(){result = 117;}
      action set_one_div_86139(){result = 116;}
      action set_one_div_87100(){result = 114;}
      action set_one_div_81820(){result = 122;}
      action set_one_div_82776(){result = 120;}
      action set_one_div_83732(){result = 119;}
      action set_one_div_84688(){result = 118;}
      action set_one_div_85644(){result = 116;}
      action set_one_div_86600(){result = 115;}
      action set_one_div_81345(){result = 122;}
      action set_one_div_82296(){result = 121;}
      action set_one_div_83247(){result = 120;}
      action set_one_div_84198(){result = 118;}
      action set_one_div_85149(){result = 117;}
      action set_one_div_80775(){result = 123;}
      action set_one_div_81720(){result = 122;}
      action set_one_div_82665(){result = 120;}
      action set_one_div_83610(){result = 119;}
      action set_one_div_84555(){result = 118;}
      action set_one_div_85500(){result = 116;}
      action set_one_div_80205(){result = 124;}
      action set_one_div_81144(){result = 123;}
      action set_one_div_82083(){result = 121;}
      action set_one_div_83022(){result = 120;}
      action set_one_div_83961(){result = 119;}
      action set_one_div_84900(){result = 117;}
      action set_one_div_79635(){result = 125;}
      action set_one_div_80568(){result = 124;}
      action set_one_div_81501(){result = 122;}
      action set_one_div_82434(){result = 121;}
      action set_one_div_83367(){result = 119;}
      action set_one_div_84300(){result = 118;}
      action set_one_div_79065(){result = 126;}
      action set_one_div_79992(){result = 125;}
      action set_one_div_80919(){result = 123;}
      action set_one_div_81846(){result = 122;}
      action set_one_div_82773(){result = 120;}
      action set_one_div_83700(){result = 119;}
      action set_one_div_78400(){result = 127;}
      action set_one_div_79320(){result = 126;}
      action set_one_div_80240(){result = 124;}
      action set_one_div_81160(){result = 123;}
      action set_one_div_82080(){result = 121;}
      action set_one_div_83000(){result = 120;}
      action set_one_div_77735(){result = 128;}
      action set_one_div_78648(){result = 127;}
      action set_one_div_79561(){result = 125;}
      action set_one_div_80474(){result = 124;}
      action set_one_div_81387(){result = 122;}
      action set_one_div_82300(){result = 121;}
      action set_one_div_77070(){result = 129;}
      action set_one_div_77976(){result = 128;}
      action set_one_div_78882(){result = 126;}
      action set_one_div_79788(){result = 125;}
      action set_one_div_80694(){result = 123;}
      action set_one_div_81600(){result = 122;}
      action set_one_div_76310(){result = 131;}
      action set_one_div_77208(){result = 129;}
      action set_one_div_78106(){result = 128;}
      action set_one_div_79004(){result = 126;}
      action set_one_div_79902(){result = 125;}
      action set_one_div_80800(){result = 123;}
      action set_one_div_75645(){result = 132;}
      action set_one_div_76536(){result = 130;}
      action set_one_div_77427(){result = 129;}
      action set_one_div_78318(){result = 127;}
      action set_one_div_79209(){result = 126;}
      action set_one_div_80100(){result = 124;}
      action set_one_div_74790(){result = 133;}
      action set_one_div_75672(){result = 132;}
      action set_one_div_76554(){result = 130;}
      action set_one_div_77436(){result = 129;}
      action set_one_div_79200(){result = 126;}
      action set_one_div_74030(){result = 135;}
      action set_one_div_74904(){result = 133;}
      action set_one_div_75778(){result = 131;}
      action set_one_div_76652(){result = 130;}
      action set_one_div_77526(){result = 128;}
      action set_one_div_82905(){result = 120;}
      action set_one_div_83904(){result = 119;}
      action set_one_div_84903(){result = 117;}
      action set_one_div_86901(){result = 115;}
      action set_one_div_82810(){result = 120;}
      action set_one_div_83808(){result = 119;}
      action set_one_div_84806(){result = 117;}
      action set_one_div_85804(){result = 116;}
      action set_one_div_86802(){result = 115;}
      action set_one_div_87800(){result = 113;}
      action set_one_div_82715(){result = 120;}
      action set_one_div_83712(){result = 119;}
      action set_one_div_84709(){result = 118;}
      action set_one_div_85706(){result = 116;}
      action set_one_div_86703(){result = 115;}
      action set_one_div_87700(){result = 114;}
      action set_one_div_82620(){result = 121;}
      action set_one_div_83616(){result = 119;}
      action set_one_div_84612(){result = 118;}
      action set_one_div_85608(){result = 116;}
      action set_one_div_86604(){result = 115;}
      action set_one_div_82430(){result = 121;}
      action set_one_div_83424(){result = 119;}
      action set_one_div_84418(){result = 118;}
      action set_one_div_85412(){result = 117;}
      action set_one_div_86406(){result = 115;}
      action set_one_div_87400(){result = 114;}
      action set_one_div_82240(){result = 121;}
      action set_one_div_83232(){result = 120;}
      action set_one_div_84224(){result = 118;}
      action set_one_div_85216(){result = 117;}
      action set_one_div_86208(){result = 115;}
      action set_one_div_87200(){result = 114;}
      action set_one_div_82050(){result = 121;}
      action set_one_div_83040(){result = 120;}
      action set_one_div_84030(){result = 119;}
      action set_one_div_85020(){result = 117;}
      action set_one_div_86010(){result = 116;}
      action set_one_div_87000(){result = 114;}
      action set_one_div_81765(){result = 122;}
      action set_one_div_82752(){result = 120;}
      action set_one_div_83739(){result = 119;}
      action set_one_div_84726(){result = 118;}
      action set_one_div_85713(){result = 116;}
      action set_one_div_81480(){result = 122;}
      action set_one_div_82464(){result = 121;}
      action set_one_div_83448(){result = 119;}
      action set_one_div_84432(){result = 118;}
      action set_one_div_85416(){result = 117;}
      action set_one_div_86400(){result = 115;}
      action set_one_div_81195(){result = 123;}
      action set_one_div_82176(){result = 121;}
      action set_one_div_83157(){result = 120;}
      action set_one_div_84138(){result = 118;}
      action set_one_div_85119(){result = 117;}
      action set_one_div_80910(){result = 123;}
      action set_one_div_81888(){result = 122;}


      table division_base{
          key = {
              divisor: exact;
          }
          actions = {
              set_division_res;
              set_one_div_94000;
              set_one_div_95000;
              set_one_div_96000;
              set_one_div_97000;
              set_one_div_91905;
              set_one_div_92904;
              set_one_div_93903;
              set_one_div_94902;
              set_one_div_95901;
              set_one_div_96900;
              set_one_div_91810;
              set_one_div_92808;
              set_one_div_93806;
              set_one_div_94804;
              set_one_div_95802;
              set_one_div_96800;
              set_one_div_91715;
              set_one_div_92712;
              set_one_div_93709;
              set_one_div_94706;
              set_one_div_95703;
              set_one_div_96700;
              set_one_div_91620;
              set_one_div_92616;
              set_one_div_93612;
              set_one_div_94608;
              set_one_div_95604;
              set_one_div_96600;
              set_one_div_91430;
              set_one_div_92424;
              set_one_div_93418;
              set_one_div_94412;
              set_one_div_95406;
              set_one_div_96400;
              set_one_div_91240;
              set_one_div_92232;
              set_one_div_93224;
              set_one_div_94216;
              set_one_div_95208;
              set_one_div_96200;
              set_one_div_91050;
              set_one_div_92040;
              set_one_div_93030;
              set_one_div_94020;
              set_one_div_95010;
              set_one_div_90765;
              set_one_div_91752;
              set_one_div_92739;
              set_one_div_93726;
              set_one_div_94713;
              set_one_div_95700;
              set_one_div_90480;
              set_one_div_91464;
              set_one_div_92448;
              set_one_div_93432;
              set_one_div_94416;
              set_one_div_95400;
              set_one_div_90195;
              set_one_div_91176;
              set_one_div_92157;
              set_one_div_93138;
              set_one_div_94119;
              set_one_div_95100;
              set_one_div_89910;
              set_one_div_90888;
              set_one_div_91866;
              set_one_div_92844;
              set_one_div_93822;
              set_one_div_94800;
              set_one_div_89530;
              set_one_div_90504;
              set_one_div_91478;
              set_one_div_92452;
              set_one_div_93426;
              set_one_div_94400;
              set_one_div_89150;
              set_one_div_90120;
              set_one_div_91090;
              set_one_div_92060;
              set_one_div_88675;
              set_one_div_89640;
              set_one_div_90605;
              set_one_div_91570;
              set_one_div_92535;
              set_one_div_93500;
              set_one_div_88295;
              set_one_div_89256;
              set_one_div_90217;
              set_one_div_91178;
              set_one_div_92139;
              set_one_div_93100;
              set_one_div_87820;
              set_one_div_88776;
              set_one_div_89732;
              set_one_div_90688;
              set_one_div_91644;
              set_one_div_92600;
              set_one_div_87345;
              set_one_div_88296;
              set_one_div_89247;
              set_one_div_90198;
              set_one_div_91149;
              set_one_div_92100;
              set_one_div_86775;
              set_one_div_87720;
              set_one_div_88665;
              set_one_div_89610;
              set_one_div_90555;
              set_one_div_91500;
              set_one_div_86205;
              set_one_div_87144;
              set_one_div_88083;
              set_one_div_89022;
              set_one_div_89961;
              set_one_div_90900;
              set_one_div_85635;
              set_one_div_86568;
              set_one_div_87501;
              set_one_div_88434;
              set_one_div_89367;
              set_one_div_90300;
              set_one_div_85065;
              set_one_div_85992;
              set_one_div_86919;
              set_one_div_87846;
              set_one_div_88773;
              set_one_div_89700;
              set_one_div_84400;
              set_one_div_85320;
              set_one_div_86240;
              set_one_div_87160;
              set_one_div_88080;
              set_one_div_89000;
              set_one_div_83735;
              set_one_div_84648;
              set_one_div_85561;
              set_one_div_86474;
              set_one_div_87387;
              set_one_div_88300;
              set_one_div_83070;
              set_one_div_83976;
              set_one_div_84882;
              set_one_div_85788;
              set_one_div_86694;
              set_one_div_87600;
              set_one_div_82310;
              set_one_div_83208;
              set_one_div_84106;
              set_one_div_85004;
              set_one_div_85902;
              set_one_div_86800;
              set_one_div_81645;
              set_one_div_82536;
              set_one_div_83427;
              set_one_div_84318;
              set_one_div_85209;
              set_one_div_86100;
              set_one_div_80790;
              set_one_div_81672;
              set_one_div_82554;
              set_one_div_83436;
              set_one_div_85200;
              set_one_div_80030;
              set_one_div_80904;
              set_one_div_81778;
              set_one_div_82652;
              set_one_div_83526;
              set_one_div_92000;
              set_one_div_93000;
              set_one_div_88905;
              set_one_div_89904;
              set_one_div_90903;
              set_one_div_91902;
              set_one_div_92901;
              set_one_div_93900;
              set_one_div_88810;
              set_one_div_89808;
              set_one_div_90806;
              set_one_div_91804;
              set_one_div_92802;
              set_one_div_93800;
              set_one_div_88715;
              set_one_div_89712;
              set_one_div_90709;
              set_one_div_91706;
              set_one_div_92703;
              set_one_div_93700;
              set_one_div_88620;
              set_one_div_89616;
              set_one_div_90612;
              set_one_div_91608;
              set_one_div_92604;
              set_one_div_93600;
              set_one_div_88430;
              set_one_div_89424;
              set_one_div_90418;
              set_one_div_91412;
              set_one_div_92406;
              set_one_div_93400;
              set_one_div_88240;
              set_one_div_89232;
              set_one_div_90224;
              set_one_div_91216;
              set_one_div_92208;
              set_one_div_93200;
              set_one_div_88050;
              set_one_div_89040;
              set_one_div_90030;
              set_one_div_91020;
              set_one_div_92010;
              set_one_div_87765;
              set_one_div_88752;
              set_one_div_89739;
              set_one_div_90726;
              set_one_div_91713;
              set_one_div_92700;
              set_one_div_87480;
              set_one_div_88464;
              set_one_div_89448;
              set_one_div_90432;
              set_one_div_91416;
              set_one_div_92400;
              set_one_div_87195;
              set_one_div_88176;
              set_one_div_89157;
              set_one_div_90138;
              set_one_div_91119;
              set_one_div_86910;
              set_one_div_87888;
              set_one_div_88866;
              set_one_div_89844;
              set_one_div_90822;
              set_one_div_91800;
              set_one_div_86530;
              set_one_div_87504;
              set_one_div_88478;
              set_one_div_89452;
              set_one_div_90426;
              set_one_div_91400;
              set_one_div_86150;
              set_one_div_87120;
              set_one_div_88090;
              set_one_div_89060;
              set_one_div_91000;
              set_one_div_85675;
              set_one_div_86640;
              set_one_div_87605;
              set_one_div_88570;
              set_one_div_89535;
              set_one_div_90500;
              set_one_div_85295;
              set_one_div_86256;
              set_one_div_87217;
              set_one_div_88178;
              set_one_div_89139;
              set_one_div_90100;
              set_one_div_84820;
              set_one_div_85776;
              set_one_div_86732;
              set_one_div_87688;
              set_one_div_88644;
              set_one_div_89600;
              set_one_div_84345;
              set_one_div_85296;
              set_one_div_86247;
              set_one_div_87198;
              set_one_div_88149;
              set_one_div_89100;
              set_one_div_83775;
              set_one_div_84720;
              set_one_div_85665;
              set_one_div_86610;
              set_one_div_87555;
              set_one_div_88500;
              set_one_div_83205;
              set_one_div_84144;
              set_one_div_85083;
              set_one_div_86022;
              set_one_div_86961;
              set_one_div_87900;
              set_one_div_82635;
              set_one_div_83568;
              set_one_div_84501;
              set_one_div_85434;
              set_one_div_86367;
              set_one_div_87300;
              set_one_div_82065;
              set_one_div_82992;
              set_one_div_83919;
              set_one_div_84846;
              set_one_div_85773;
              set_one_div_86700;
              set_one_div_81400;
              set_one_div_82320;
              set_one_div_83240;
              set_one_div_84160;
              set_one_div_85080;
              set_one_div_86000;
              set_one_div_80735;
              set_one_div_81648;
              set_one_div_82561;
              set_one_div_83474;
              set_one_div_84387;
              set_one_div_85300;
              set_one_div_80070;
              set_one_div_80976;
              set_one_div_81882;
              set_one_div_82788;
              set_one_div_83694;
              set_one_div_84600;
              set_one_div_79310;
              set_one_div_80208;
              set_one_div_81106;
              set_one_div_82004;
              set_one_div_82902;
              set_one_div_83800;
              set_one_div_78645;
              set_one_div_79536;
              set_one_div_80427;
              set_one_div_81318;
              set_one_div_82209;
              set_one_div_83100;
              set_one_div_77790;
              set_one_div_78672;
              set_one_div_79554;
              set_one_div_80436;
              set_one_div_82200;
              set_one_div_77030;
              set_one_div_77904;
              set_one_div_78778;
              set_one_div_79652;
              set_one_div_80526;
              set_one_div_90000;
              set_one_div_85905;
              set_one_div_86904;
              set_one_div_87903;
              set_one_div_88902;
              set_one_div_89901;
              set_one_div_85810;
              set_one_div_86808;
              set_one_div_87806;
              set_one_div_88804;
              set_one_div_89802;
              set_one_div_90800;
              set_one_div_85715;
              set_one_div_86712;
              set_one_div_87709;
              set_one_div_88706;
              set_one_div_89703;
              set_one_div_90700;
              set_one_div_85620;
              set_one_div_86616;
              set_one_div_87612;
              set_one_div_88608;
              set_one_div_89604;
              set_one_div_90600;
              set_one_div_85430;
              set_one_div_86424;
              set_one_div_87418;
              set_one_div_88412;
              set_one_div_89406;
              set_one_div_90400;
              set_one_div_85240;
              set_one_div_86232;
              set_one_div_87224;
              set_one_div_88216;
              set_one_div_89208;
              set_one_div_90200;
              set_one_div_85050;
              set_one_div_86040;
              set_one_div_87030;
              set_one_div_88020;
              set_one_div_89010;
              set_one_div_84765;
              set_one_div_85752;
              set_one_div_86739;
              set_one_div_87726;
              set_one_div_88713;
              set_one_div_84480;
              set_one_div_85464;
              set_one_div_86448;
              set_one_div_87432;
              set_one_div_88416;
              set_one_div_89400;
              set_one_div_84195;
              set_one_div_85176;
              set_one_div_86157;
              set_one_div_87138;
              set_one_div_88119;
              set_one_div_83910;
              set_one_div_84888;
              set_one_div_85866;
              set_one_div_86844;
              set_one_div_87822;
              set_one_div_88800;
              set_one_div_83530;
              set_one_div_84504;
              set_one_div_85478;
              set_one_div_86452;
              set_one_div_87426;
              set_one_div_88400;
              set_one_div_83150;
              set_one_div_84120;
              set_one_div_85090;
              set_one_div_86060;
              set_one_div_88000;
              set_one_div_82675;
              set_one_div_83640;
              set_one_div_84605;
              set_one_div_85570;
              set_one_div_86535;
              set_one_div_87500;
              set_one_div_82295;
              set_one_div_83256;
              set_one_div_84217;
              set_one_div_85178;
              set_one_div_86139;
              set_one_div_87100;
              set_one_div_81820;
              set_one_div_82776;
              set_one_div_83732;
              set_one_div_84688;
              set_one_div_85644;
              set_one_div_86600;
              set_one_div_81345;
              set_one_div_82296;
              set_one_div_83247;
              set_one_div_84198;
              set_one_div_85149;
              set_one_div_80775;
              set_one_div_81720;
              set_one_div_82665;
              set_one_div_83610;
              set_one_div_84555;
              set_one_div_85500;
              set_one_div_80205;
              set_one_div_81144;
              set_one_div_82083;
              set_one_div_83022;
              set_one_div_83961;
              set_one_div_84900;
              set_one_div_79635;
              set_one_div_80568;
              set_one_div_81501;
              set_one_div_82434;
              set_one_div_83367;
              set_one_div_84300;
              set_one_div_79065;
              set_one_div_79992;
              set_one_div_80919;
              set_one_div_81846;
              set_one_div_82773;
              set_one_div_83700;
              set_one_div_78400;
              set_one_div_79320;
              set_one_div_80240;
              set_one_div_81160;
              set_one_div_82080;
              set_one_div_83000;
              set_one_div_77735;
              set_one_div_78648;
              set_one_div_79561;
              set_one_div_80474;
              set_one_div_81387;
              set_one_div_82300;
              set_one_div_77070;
              set_one_div_77976;
              set_one_div_78882;
              set_one_div_79788;
              set_one_div_80694;
              set_one_div_81600;
              set_one_div_76310;
              set_one_div_77208;
              set_one_div_78106;
              set_one_div_79004;
              set_one_div_79902;
              set_one_div_80800;
              set_one_div_75645;
              set_one_div_76536;
              set_one_div_77427;
              set_one_div_78318;
              set_one_div_79209;
              set_one_div_80100;
              set_one_div_74790;
              set_one_div_75672;
              set_one_div_76554;
              set_one_div_77436;
              set_one_div_79200;
              set_one_div_74030;
              set_one_div_74904;
              set_one_div_75778;
              set_one_div_76652;
              set_one_div_77526;
              set_one_div_82905;
              set_one_div_83904;
              set_one_div_84903;
              set_one_div_86901;
              set_one_div_82810;
              set_one_div_83808;
              set_one_div_84806;
              set_one_div_85804;
              set_one_div_86802;
              set_one_div_87800;
              set_one_div_82715;
              set_one_div_83712;
              set_one_div_84709;
              set_one_div_85706;
              set_one_div_86703;
              set_one_div_87700;
              set_one_div_82620;
              set_one_div_83616;
              set_one_div_84612;
              set_one_div_85608;
              set_one_div_86604;
              set_one_div_82430;
              set_one_div_83424;
              set_one_div_84418;
              set_one_div_85412;
              set_one_div_86406;
              set_one_div_87400;
              set_one_div_82240;
              set_one_div_83232;
              set_one_div_84224;
              set_one_div_85216;
              set_one_div_86208;
              set_one_div_87200;
              set_one_div_82050;
              set_one_div_83040;
              set_one_div_84030;
              set_one_div_85020;
              set_one_div_86010;
              set_one_div_87000;
              set_one_div_81765;
              set_one_div_82752;
              set_one_div_83739;
              set_one_div_84726;
              set_one_div_85713;
              set_one_div_81480;
              set_one_div_82464;
              set_one_div_83448;
              set_one_div_84432;
              set_one_div_85416;
              set_one_div_86400;
              set_one_div_81195;
              set_one_div_82176;
              set_one_div_83157;
              set_one_div_84138;
              set_one_div_85119;
              set_one_div_80910;
              set_one_div_81888;

          }

          const entries = {
              348902 : set_division_res;
              94000 : set_one_div_94000;
              95000 : set_one_div_95000;
              96000 : set_one_div_96000;
              97000 : set_one_div_97000;
              91905 : set_one_div_91905;
              92904 : set_one_div_92904;
              93903 : set_one_div_93903;
              94902 : set_one_div_94902;
              95901 : set_one_div_95901;
              96900 : set_one_div_96900;
              91810 : set_one_div_91810;
              92808 : set_one_div_92808;
              93806 : set_one_div_93806;
              94804 : set_one_div_94804;
              95802 : set_one_div_95802;
              96800 : set_one_div_96800;
              91715 : set_one_div_91715;
              92712 : set_one_div_92712;
              93709 : set_one_div_93709;
              94706 : set_one_div_94706;
              95703 : set_one_div_95703;
              96700 : set_one_div_96700;
              91620 : set_one_div_91620;
              92616 : set_one_div_92616;
              93612 : set_one_div_93612;
              94608 : set_one_div_94608;
              95604 : set_one_div_95604;
              96600 : set_one_div_96600;
              91430 : set_one_div_91430;
              92424 : set_one_div_92424;
              93418 : set_one_div_93418;
              94412 : set_one_div_94412;
              95406 : set_one_div_95406;
              96400 : set_one_div_96400;
              91240 : set_one_div_91240;
              92232 : set_one_div_92232;
              93224 : set_one_div_93224;
              94216 : set_one_div_94216;
              95208 : set_one_div_95208;
              96200 : set_one_div_96200;
              91050 : set_one_div_91050;
              92040 : set_one_div_92040;
              93030 : set_one_div_93030;
              94020 : set_one_div_94020;
              95010 : set_one_div_95010;
              90765 : set_one_div_90765;
              91752 : set_one_div_91752;
              92739 : set_one_div_92739;
              93726 : set_one_div_93726;
              94713 : set_one_div_94713;
              95700 : set_one_div_95700;
              90480 : set_one_div_90480;
              91464 : set_one_div_91464;
              92448 : set_one_div_92448;
              93432 : set_one_div_93432;
              94416 : set_one_div_94416;
              95400 : set_one_div_95400;
              90195 : set_one_div_90195;
              91176 : set_one_div_91176;
              92157 : set_one_div_92157;
              93138 : set_one_div_93138;
              94119 : set_one_div_94119;
              95100 : set_one_div_95100;
              89910 : set_one_div_89910;
              90888 : set_one_div_90888;
              91866 : set_one_div_91866;
              92844 : set_one_div_92844;
              93822 : set_one_div_93822;
              94800 : set_one_div_94800;
              89530 : set_one_div_89530;
              90504 : set_one_div_90504;
              91478 : set_one_div_91478;
              92452 : set_one_div_92452;
              93426 : set_one_div_93426;
              94400 : set_one_div_94400;
              89150 : set_one_div_89150;
              90120 : set_one_div_90120;
              91090 : set_one_div_91090;
              92060 : set_one_div_92060;
              88675 : set_one_div_88675;
              89640 : set_one_div_89640;
              90605 : set_one_div_90605;
              91570 : set_one_div_91570;
              92535 : set_one_div_92535;
              93500 : set_one_div_93500;
              88295 : set_one_div_88295;
              89256 : set_one_div_89256;
              90217 : set_one_div_90217;
              91178 : set_one_div_91178;
              92139 : set_one_div_92139;
              93100 : set_one_div_93100;
              87820 : set_one_div_87820;
              88776 : set_one_div_88776;
              89732 : set_one_div_89732;
              90688 : set_one_div_90688;
              91644 : set_one_div_91644;
              92600 : set_one_div_92600;
              87345 : set_one_div_87345;
              88296 : set_one_div_88296;
              89247 : set_one_div_89247;
              90198 : set_one_div_90198;
              91149 : set_one_div_91149;
              92100 : set_one_div_92100;
              86775 : set_one_div_86775;
              87720 : set_one_div_87720;
              88665 : set_one_div_88665;
              89610 : set_one_div_89610;
              90555 : set_one_div_90555;
              91500 : set_one_div_91500;
              86205 : set_one_div_86205;
              87144 : set_one_div_87144;
              88083 : set_one_div_88083;
              89022 : set_one_div_89022;
              89961 : set_one_div_89961;
              90900 : set_one_div_90900;
              85635 : set_one_div_85635;
              86568 : set_one_div_86568;
              87501 : set_one_div_87501;
              88434 : set_one_div_88434;
              89367 : set_one_div_89367;
              90300 : set_one_div_90300;
              85065 : set_one_div_85065;
              85992 : set_one_div_85992;
              86919 : set_one_div_86919;
              87846 : set_one_div_87846;
              88773 : set_one_div_88773;
              89700 : set_one_div_89700;
              84400 : set_one_div_84400;
              85320 : set_one_div_85320;
              86240 : set_one_div_86240;
              87160 : set_one_div_87160;
              88080 : set_one_div_88080;
              89000 : set_one_div_89000;
              83735 : set_one_div_83735;
              84648 : set_one_div_84648;
              85561 : set_one_div_85561;
              86474 : set_one_div_86474;
              87387 : set_one_div_87387;
              88300 : set_one_div_88300;
              83070 : set_one_div_83070;
              83976 : set_one_div_83976;
              84882 : set_one_div_84882;
              85788 : set_one_div_85788;
              86694 : set_one_div_86694;
              87600 : set_one_div_87600;
              82310 : set_one_div_82310;
              83208 : set_one_div_83208;
              84106 : set_one_div_84106;
              85004 : set_one_div_85004;
              85902 : set_one_div_85902;
              86800 : set_one_div_86800;
              81645 : set_one_div_81645;
              82536 : set_one_div_82536;
              83427 : set_one_div_83427;
              84318 : set_one_div_84318;
              85209 : set_one_div_85209;
              86100 : set_one_div_86100;
              80790 : set_one_div_80790;
              81672 : set_one_div_81672;
              82554 : set_one_div_82554;
              83436 : set_one_div_83436;
              85200 : set_one_div_85200;
              80030 : set_one_div_80030;
              80904 : set_one_div_80904;
              81778 : set_one_div_81778;
              82652 : set_one_div_82652;
              83526 : set_one_div_83526;
              92000 : set_one_div_92000;
              93000 : set_one_div_93000;
              88905 : set_one_div_88905;
              89904 : set_one_div_89904;
              90903 : set_one_div_90903;
              91902 : set_one_div_91902;
              92901 : set_one_div_92901;
              93900 : set_one_div_93900;
              88810 : set_one_div_88810;
              89808 : set_one_div_89808;
              90806 : set_one_div_90806;
              91804 : set_one_div_91804;
              92802 : set_one_div_92802;
              93800 : set_one_div_93800;
              88715 : set_one_div_88715;
              89712 : set_one_div_89712;
              90709 : set_one_div_90709;
              91706 : set_one_div_91706;
              92703 : set_one_div_92703;
              93700 : set_one_div_93700;
              88620 : set_one_div_88620;
              89616 : set_one_div_89616;
              90612 : set_one_div_90612;
              91608 : set_one_div_91608;
              92604 : set_one_div_92604;
              93600 : set_one_div_93600;
              88430 : set_one_div_88430;
              89424 : set_one_div_89424;
              90418 : set_one_div_90418;
              91412 : set_one_div_91412;
              92406 : set_one_div_92406;
              93400 : set_one_div_93400;
              88240 : set_one_div_88240;
              89232 : set_one_div_89232;
              90224 : set_one_div_90224;
              91216 : set_one_div_91216;
              92208 : set_one_div_92208;
              93200 : set_one_div_93200;
              88050 : set_one_div_88050;
              89040 : set_one_div_89040;
              90030 : set_one_div_90030;
              91020 : set_one_div_91020;
              92010 : set_one_div_92010;
              87765 : set_one_div_87765;
              88752 : set_one_div_88752;
              89739 : set_one_div_89739;
              90726 : set_one_div_90726;
              91713 : set_one_div_91713;
              92700 : set_one_div_92700;
              87480 : set_one_div_87480;
              88464 : set_one_div_88464;
              89448 : set_one_div_89448;
              90432 : set_one_div_90432;
              91416 : set_one_div_91416;
              92400 : set_one_div_92400;
              87195 : set_one_div_87195;
              88176 : set_one_div_88176;
              89157 : set_one_div_89157;
              90138 : set_one_div_90138;
              91119 : set_one_div_91119;
              86910 : set_one_div_86910;
              87888 : set_one_div_87888;
              88866 : set_one_div_88866;
              89844 : set_one_div_89844;
              90822 : set_one_div_90822;
              91800 : set_one_div_91800;
              86530 : set_one_div_86530;
              87504 : set_one_div_87504;
              88478 : set_one_div_88478;
              89452 : set_one_div_89452;
              90426 : set_one_div_90426;
              91400 : set_one_div_91400;
              86150 : set_one_div_86150;
              87120 : set_one_div_87120;
              88090 : set_one_div_88090;
              89060 : set_one_div_89060;
              91000 : set_one_div_91000;
              85675 : set_one_div_85675;
              86640 : set_one_div_86640;
              87605 : set_one_div_87605;
              88570 : set_one_div_88570;
              89535 : set_one_div_89535;
              90500 : set_one_div_90500;
              85295 : set_one_div_85295;
              86256 : set_one_div_86256;
              87217 : set_one_div_87217;
              88178 : set_one_div_88178;
              89139 : set_one_div_89139;
              90100 : set_one_div_90100;
              84820 : set_one_div_84820;
              85776 : set_one_div_85776;
              86732 : set_one_div_86732;
              87688 : set_one_div_87688;
              88644 : set_one_div_88644;
              89600 : set_one_div_89600;
              84345 : set_one_div_84345;
              85296 : set_one_div_85296;
              86247 : set_one_div_86247;
              87198 : set_one_div_87198;
              88149 : set_one_div_88149;
              89100 : set_one_div_89100;
              83775 : set_one_div_83775;
              84720 : set_one_div_84720;
              85665 : set_one_div_85665;
              86610 : set_one_div_86610;
              87555 : set_one_div_87555;
              88500 : set_one_div_88500;
              83205 : set_one_div_83205;
              84144 : set_one_div_84144;
              85083 : set_one_div_85083;
              86022 : set_one_div_86022;
              86961 : set_one_div_86961;
              87900 : set_one_div_87900;
              82635 : set_one_div_82635;
              83568 : set_one_div_83568;
              84501 : set_one_div_84501;
              85434 : set_one_div_85434;
              86367 : set_one_div_86367;
              87300 : set_one_div_87300;
              82065 : set_one_div_82065;
              82992 : set_one_div_82992;
              83919 : set_one_div_83919;
              84846 : set_one_div_84846;
              85773 : set_one_div_85773;
              86700 : set_one_div_86700;
              81400 : set_one_div_81400;
              82320 : set_one_div_82320;
              83240 : set_one_div_83240;
              84160 : set_one_div_84160;
              85080 : set_one_div_85080;
              86000 : set_one_div_86000;
              80735 : set_one_div_80735;
              81648 : set_one_div_81648;
              82561 : set_one_div_82561;
              83474 : set_one_div_83474;
              84387 : set_one_div_84387;
              85300 : set_one_div_85300;
              80070 : set_one_div_80070;
              80976 : set_one_div_80976;
              81882 : set_one_div_81882;
              82788 : set_one_div_82788;
              83694 : set_one_div_83694;
              84600 : set_one_div_84600;
              79310 : set_one_div_79310;
              80208 : set_one_div_80208;
              81106 : set_one_div_81106;
              82004 : set_one_div_82004;
              82902 : set_one_div_82902;
              83800 : set_one_div_83800;
              78645 : set_one_div_78645;
              79536 : set_one_div_79536;
              80427 : set_one_div_80427;
              81318 : set_one_div_81318;
              82209 : set_one_div_82209;
              83100 : set_one_div_83100;
              77790 : set_one_div_77790;
              78672 : set_one_div_78672;
              79554 : set_one_div_79554;
              80436 : set_one_div_80436;
              82200 : set_one_div_82200;
              77030 : set_one_div_77030;
              77904 : set_one_div_77904;
              78778 : set_one_div_78778;
              79652 : set_one_div_79652;
              80526 : set_one_div_80526;
              90000 : set_one_div_90000;
              85905 : set_one_div_85905;
              86904 : set_one_div_86904;
              87903 : set_one_div_87903;
              88902 : set_one_div_88902;
              89901 : set_one_div_89901;
              85810 : set_one_div_85810;
              86808 : set_one_div_86808;
              87806 : set_one_div_87806;
              88804 : set_one_div_88804;
              89802 : set_one_div_89802;
              90800 : set_one_div_90800;
              85715 : set_one_div_85715;
              86712 : set_one_div_86712;
              87709 : set_one_div_87709;
              88706 : set_one_div_88706;
              89703 : set_one_div_89703;
              90700 : set_one_div_90700;
              85620 : set_one_div_85620;
              86616 : set_one_div_86616;
              87612 : set_one_div_87612;
              88608 : set_one_div_88608;
              89604 : set_one_div_89604;
              90600 : set_one_div_90600;
              85430 : set_one_div_85430;
              86424 : set_one_div_86424;
              87418 : set_one_div_87418;
              88412 : set_one_div_88412;
              89406 : set_one_div_89406;
              90400 : set_one_div_90400;
              85240 : set_one_div_85240;
              86232 : set_one_div_86232;
              87224 : set_one_div_87224;
              88216 : set_one_div_88216;
              89208 : set_one_div_89208;
              90200 : set_one_div_90200;
              85050 : set_one_div_85050;
              86040 : set_one_div_86040;
              87030 : set_one_div_87030;
              88020 : set_one_div_88020;
              89010 : set_one_div_89010;
              84765 : set_one_div_84765;
              85752 : set_one_div_85752;
              86739 : set_one_div_86739;
              87726 : set_one_div_87726;
              88713 : set_one_div_88713;
              84480 : set_one_div_84480;
              85464 : set_one_div_85464;
              86448 : set_one_div_86448;
              87432 : set_one_div_87432;
              88416 : set_one_div_88416;
              89400 : set_one_div_89400;
              84195 : set_one_div_84195;
              85176 : set_one_div_85176;
              86157 : set_one_div_86157;
              87138 : set_one_div_87138;
              88119 : set_one_div_88119;
              83910 : set_one_div_83910;
              84888 : set_one_div_84888;
              85866 : set_one_div_85866;
              86844 : set_one_div_86844;
              87822 : set_one_div_87822;
              88800 : set_one_div_88800;
              83530 : set_one_div_83530;
              84504 : set_one_div_84504;
              85478 : set_one_div_85478;
              86452 : set_one_div_86452;
              87426 : set_one_div_87426;
              88400 : set_one_div_88400;
              83150 : set_one_div_83150;
              84120 : set_one_div_84120;
              85090 : set_one_div_85090;
              86060 : set_one_div_86060;
              88000 : set_one_div_88000;
              82675 : set_one_div_82675;
              83640 : set_one_div_83640;
              84605 : set_one_div_84605;
              85570 : set_one_div_85570;
              86535 : set_one_div_86535;
              87500 : set_one_div_87500;
              82295 : set_one_div_82295;
              83256 : set_one_div_83256;
              84217 : set_one_div_84217;
              85178 : set_one_div_85178;
              86139 : set_one_div_86139;
              87100 : set_one_div_87100;
              81820 : set_one_div_81820;
              82776 : set_one_div_82776;
              83732 : set_one_div_83732;
              84688 : set_one_div_84688;
              85644 : set_one_div_85644;
              86600 : set_one_div_86600;
              81345 : set_one_div_81345;
              82296 : set_one_div_82296;
              83247 : set_one_div_83247;
              84198 : set_one_div_84198;
              85149 : set_one_div_85149;
              80775 : set_one_div_80775;
              81720 : set_one_div_81720;
              82665 : set_one_div_82665;
              83610 : set_one_div_83610;
              84555 : set_one_div_84555;
              85500 : set_one_div_85500;
              80205 : set_one_div_80205;
              81144 : set_one_div_81144;
              82083 : set_one_div_82083;
              83022 : set_one_div_83022;
              83961 : set_one_div_83961;
              84900 : set_one_div_84900;
              79635 : set_one_div_79635;
              80568 : set_one_div_80568;
              81501 : set_one_div_81501;
              82434 : set_one_div_82434;
              83367 : set_one_div_83367;
              84300 : set_one_div_84300;
              79065 : set_one_div_79065;
              79992 : set_one_div_79992;
              80919 : set_one_div_80919;
              81846 : set_one_div_81846;
              82773 : set_one_div_82773;
              83700 : set_one_div_83700;
              78400 : set_one_div_78400;
              79320 : set_one_div_79320;
              80240 : set_one_div_80240;
              81160 : set_one_div_81160;
              82080 : set_one_div_82080;
              83000 : set_one_div_83000;
              77735 : set_one_div_77735;
              78648 : set_one_div_78648;
              79561 : set_one_div_79561;
              80474 : set_one_div_80474;
              81387 : set_one_div_81387;
              82300 : set_one_div_82300;
              77070 : set_one_div_77070;
              77976 : set_one_div_77976;
              78882 : set_one_div_78882;
              79788 : set_one_div_79788;
              80694 : set_one_div_80694;
              81600 : set_one_div_81600;
              76310 : set_one_div_76310;
              77208 : set_one_div_77208;
              78106 : set_one_div_78106;
              79004 : set_one_div_79004;
              79902 : set_one_div_79902;
              80800 : set_one_div_80800;
              75645 : set_one_div_75645;
              76536 : set_one_div_76536;
              77427 : set_one_div_77427;
              78318 : set_one_div_78318;
              79209 : set_one_div_79209;
              80100 : set_one_div_80100;
              74790 : set_one_div_74790;
              75672 : set_one_div_75672;
              76554 : set_one_div_76554;
              77436 : set_one_div_77436;
              79200 : set_one_div_79200;
              74030 : set_one_div_74030;
              74904 : set_one_div_74904;
              75778 : set_one_div_75778;
              76652 : set_one_div_76652;
              77526 : set_one_div_77526;
              82905 : set_one_div_82905;
              83904 : set_one_div_83904;
              84903 : set_one_div_84903;
              86901 : set_one_div_86901;
              82810 : set_one_div_82810;
              83808 : set_one_div_83808;
              84806 : set_one_div_84806;
              85804 : set_one_div_85804;
              86802 : set_one_div_86802;
              87800 : set_one_div_87800;
              82715 : set_one_div_82715;
              83712 : set_one_div_83712;
              84709 : set_one_div_84709;
              85706 : set_one_div_85706;
              86703 : set_one_div_86703;
              87700 : set_one_div_87700;
              82620 : set_one_div_82620;
              83616 : set_one_div_83616;
              84612 : set_one_div_84612;
              85608 : set_one_div_85608;
              86604 : set_one_div_86604;
              82430 : set_one_div_82430;
              83424 : set_one_div_83424;
              84418 : set_one_div_84418;
              85412 : set_one_div_85412;
              86406 : set_one_div_86406;
              87400 : set_one_div_87400;
              82240 : set_one_div_82240;
              83232 : set_one_div_83232;
              84224 : set_one_div_84224;
              85216 : set_one_div_85216;
              86208 : set_one_div_86208;
              87200 : set_one_div_87200;
              82050 : set_one_div_82050;
              83040 : set_one_div_83040;
              84030 : set_one_div_84030;
              85020 : set_one_div_85020;
              86010 : set_one_div_86010;
              87000 : set_one_div_87000;
              81765 : set_one_div_81765;
              82752 : set_one_div_82752;
              83739 : set_one_div_83739;
              84726 : set_one_div_84726;
              85713 : set_one_div_85713;
              81480 : set_one_div_81480;
              82464 : set_one_div_82464;
              83448 : set_one_div_83448;
              84432 : set_one_div_84432;
              85416 : set_one_div_85416;
              86400 : set_one_div_86400;
              81195 : set_one_div_81195;
              82176 : set_one_div_82176;
              83157 : set_one_div_83157;
              84138 : set_one_div_84138;
              85119 : set_one_div_85119;
              80910 : set_one_div_80910;
              81888 : set_one_div_81888;

          }
      }

      apply{
          division_base.apply();
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
    register<bit<32>>(20) a;
    register<bit<32>>(10) b;
    register<bit<32>>(10) c;
    register<bit<32>>(10) k;

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

    bit<32> one_div_real;
    bit<32> one_div_imag;


    bit<32> jpt_real_res;
    bit<32> jpt_img_res;

    bit<32> pred_ang;
    bit<32> pred_mag;

    //init function variables
    cos_value_va() cos_value_va;
    cos_value_vb() cos_value_vb;
    cos_value_vc() cos_value_vc;
    sin_value_va() sin_value_va;
    sin_value_vb() sin_value_vb;
    sin_value_vc() sin_value_vc;
    division_val() division;
    tan_value() tan_val;

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

    action divu10_test(in bit<32> n, out bit<32> res){
        bit<32> q;
        bit<32> r;
        bit<32> j;
        j = n + (n >>31 & 9);
        q = (n >> 1) + (n >> 2);
        q = q + (q >> 4);
        q = q + (q >> 8);
        q = q + (q >> 16);
        q= q >>3;
        r = n - q * 10;
        res = q + ((r+6) >>4);
    }

    action divu1000(in bit<32> n, out bit<32> res){
        bit<32> q;
        bit<32> r;
        bit<32> t;
        t = (n >> 7) + (n >>8) + (n>>12);
        q = (n >> 1) + t + (n >> 15) + (t >> 11) + (t >> 14);
        q = q >> 9;
        r = n - q * 1000;
        res = q + ((r + 24) >> 10);

    }

    action test_div(/**in bit<32> aa, in bit<32> ba, **/ out bit<32> res){
        //int x = 3;
        //int y = 6;
        //int z = 1;
        //z = y/x;
        //bit<32> x = hdr.pmu.phasorVA_Vol
        bit<32> w = 100;
        bit<32> x = w;
        bit<32> y = 201200 * 100;  // try times 100 first. it seems getting double digit as return
        bit<32> z = y/x ;
        bit<32> j = x % y;
        res = z;
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
              bit<32> div_tes_res;
              bit<32> div_test_res2;
              test_div(/**in bit<32> aa, in bit<32> ba, **/ div_test_res2);
              k.write(1,div_test_res2);
              divu1000(0, div_test_res2);
              k.write(2, div_test_res2);
              divu10_test(0,div_tes_res);
              k.write(3,div_tes_res);

              //calculate cos and sin value
              cos_value_va.apply(hdr.pmu.phasorVA_Ang,va_cos_res);//89
              sin_value_va.apply(hdr.pmu.phasorVA_Ang,va_sin_res);
              a.write(0, va_cos_res); //17
              cos_value_vb.apply(hdr.pmu.phasorVB_Ang,vb_cos_res);//150
              sin_value_vb.apply(hdr.pmu.phasorVB_Ang,vb_sin_res);
              b.write(0,vb_sin_res);//500
              cos_value_vc.apply(hdr.pmu.phasorVC_Ang,vc_cos_res);//30
              sin_value_vc.apply(hdr.pmu.phasorVC_Ang,vc_sin_res);
              c.write(0,vc_cos_res);//866



              //get real and img value
              calculate_complex_voltage(hdr.pmu.phasorVA_Vol, va_cos_res,va_sin_res, va_real,
              va_img);
              a.write(1, va_real);//17 * 100
              a.write(2,va_img); //999 * 100
              calculate_complex_voltage(hdr.pmu.phasorVB_Vol, vb_cos_res,vb_sin_res, vb_real,
              vb_img);
              b.write(1,vb_real);//-866 * 99
              b.write(2,vb_img);//500 * 99
              calculate_complex_voltage(hdr.pmu.phasorVC_Vol, vc_cos_res,vc_sin_res, vc_real,
              vc_img);
              c.write(1,vc_real);//866 * 100
              c.write(2,vc_img);//500* 100

              //jpt algo
              jpt_algo(va_real, vb_real,vc_real,jpt_real_res);
              jpt_algo(va_img,vb_img,vc_img,jpt_img_res);
              bit<32> imag_div_real = (jpt_img_res * 1000);
              bit<32> abc = imag_div_real / jpt_real_res;
              //test_div(jpt_real_res, jpt_img_res, real_div_imag);
              //bit<32> ccc = real_div_imag -1;
              //a.write(15,ccc);
              a.write(3,jpt_real_res);
              a.write(4,jpt_img_res);



              //get 1/real result
              division.apply(jpt_real_res,one_div_real);
              //division.apply(jpt_img_res,one_div_imag);
              a.write(5,one_div_real);

              // imag * (1/real)
              divu10_test(jpt_img_res,jpt_img_res);
              divu1000(jpt_img_res,jpt_img_res);
              bit<32> pre_tan = jpt_img_res * one_div_real;
              a.write(6,pre_tan);

              //tan result
              tan_val.apply(imag_div_real,pred_ang);
              a.write(7,pred_ang);

              //square resutl
              bit<32> pre_sqrt = (jpt_real_res * jpt_real_res) + (jpt_img_res * jpt_img_res);
              a.write(8,pre_sqrt);

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
