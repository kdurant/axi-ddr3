/*=============================================================================
# FileName    :	axi_drive.v
# Author      :	author
# Email       :	email@email.com
# Description :	
# Version     :	1.0
# LastChange  :	2017-03-05 21:40:37
# ChangeLog   :	
=============================================================================*/

`timescale  1 ns/1 ps

module axi_drive
(
    input   wire                clk,
    input   wire                rst,

    // Slave Interface Write Address Ports
    output  [03:0]      s_axi_awid;
    output  [31:0]    s_axi_awaddr;
    output  [7:0]                       s_axi_awlen;
    output  [2:0]                       s_axi_awsize;
    output  [1:0]                       s_axi_awburst;
    output  [0:0]                       s_axi_awlock;
    output  [3:0]                       s_axi_awcache;
    output  [2:0]                       s_axi_awprot;
    output                              s_axi_awvalid;
    input                               s_axi_awready;
    // Slave Interface Write Data Ports
    output [511:0]     s_axi_wdata;
    output [63:0]   s_axi_wstrb;
    output                              s_axi_wlast;
    output                              s_axi_wvalid;
    input                               s_axi_wready;

    // Slave Interface Write Response Ports
    output                             s_axi_bready;
    input [03:0]       s_axi_bid;
    input [1:0]                        s_axi_bresp;
    input                              s_axi_bvalid;
    // Slave Interface Read Address Ports
    output [03:0]       s_axi_arid;
    output [31:0]     s_axi_araddr;
    output [7:0]                        s_axi_arlen;
    output [2:0]                        s_axi_arsize;
    output [1:0]                        s_axi_arburst;
    output [0:0]                        s_axi_arlock;
    output [3:0]                        s_axi_arcache;
    output [2:0]                        s_axi_arprot;
    output                              s_axi_arvalid;
    input                             s_axi_arready;
    // Slave Interface Read Data Ports
    output                              s_axi_rready;
    input [03:0]       s_axi_rid;
    input [511:0]     s_axi_rdata;
    input [1:0]                        s_axi_rresp;
    input                              s_axi_rlast;
    input                              s_axi_rvalid;
);

endmodule
