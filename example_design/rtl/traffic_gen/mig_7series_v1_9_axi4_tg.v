//*****************************************************************************
// (c) Copyright 2009 - 2010 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 3.6
//  \   \         Application: MIG
//  /   /         Filename: axi4_wrapper.v
// /___/   /\     Date Last Modified: $Date: 2011/06/02 08:37:18 $
// \   \  /  \    Date Created: Sept 16, 2009
//  \___\/\___\
//
//Device: Virtex-6, Spartan-6 and 7series
//Design Name: DDR3 SDRAM
//Purpose:
//   This module is wrapper for converting the reads and writes to transactions
//   that follow the AXI protocol.
//
//Reference:
//Revision History:
//*****************************************************************************

module mig_7series_v1_9_axi4_tg #(
    
     parameter C_AXI_ID_WIDTH           = 4, // The AXI id width used for read and write
                                             // This is an integer between 1-16
     parameter C_AXI_ADDR_WIDTH         = 32, // This is AXI address width for all 
                                              // SI and MI slots
     parameter C_AXI_DATA_WIDTH         = 32, // Width of the AXI write and read data
  
     parameter C_AXI_NBURST_SUPPORT     = 0, // Support for narrow burst transfers
                                             // 1-supported, 0-not supported 
     parameter C_EN_WRAP_TRANS          = 0, // Set 1 to enable wrap transactions

     parameter C_BEGIN_ADDRESS          = 0, // Start address of the address map
  
     parameter C_END_ADDRESS            = 32'hFFFF_FFFF, // End address of the address map
     
     parameter PRBS_EADDR_MASK_POS      = 32'hFFFFD000,

     parameter PRBS_SADDR_MASK_POS      = 32'h00002000,

     parameter DBG_WR_STS_WIDTH         = 32,

     parameter DBG_RD_STS_WIDTH         = 32,
  
     parameter ENFORCE_RD_WR            = 0,

     parameter ENFORCE_RD_WR_CMD        = 8'h11,

     parameter EN_UPSIZER               = 0,

     parameter ENFORCE_RD_WR_PATTERN    = 3'b000
  
)
(
   input                               aclk,    // AXI input clock
   input                               aresetn, // Active low AXI reset signal

// Input control signals
   input                               init_cmptd, // Initialization completed
   input                               init_test,  // Initialize the test
   input                               wdog_mask,  // Mask the watchdog timeouts
   input                               wrap_en,    // Enable wrap transactions

// AXI write address channel signals
   input                               axi_wready, // Indicates slave is ready to accept a 
   output reg [C_AXI_ID_WIDTH-1:0]         axi_wid = 0,    // Write ID
   output reg [C_AXI_ADDR_WIDTH-1:0]       axi_waddr = 0,  // Write address
   output reg [7:0]                        axi_wlen = 0,   // Write Burst Length
   output reg [2:0]                        axi_wsize = 0,  // Write Burst size
   output reg [1:0]                        axi_wburst = 0, // Write Burst type
   output reg [1:0]                        axi_wlock = 0,  // Write lock type
   output reg [3:0]                        axi_wcache = 0, // Write Cache type
   output reg [2:0]                        axi_wprot = 0,  // Write Protection type
   output reg                              axi_wvalid = 0, // Write address valid
  
// AXI write data channel signals
   input                               axi_wd_wready,  // Write data ready
   output reg [C_AXI_ID_WIDTH-1:0]         axi_wd_wid = 0,     // Write ID tag
   output reg [C_AXI_DATA_WIDTH-1:0]       axi_wd_data = 0,    // Write data
   output reg [C_AXI_DATA_WIDTH/8-1:0]     axi_wd_strb = {64{1'b1}},    // Write strobes
   output reg                              axi_wd_last = 0,    // Last write transaction   
   output reg                              axi_wd_valid = 0,   // Write valid
  
// AXI write response channel signals
   input  [C_AXI_ID_WIDTH-1:0]         axi_wd_bid,     // Response ID
   input  [1:0]                        axi_wd_bresp,   // Write response
   input                               axi_wd_bvalid,  // Write reponse valid
   output reg                             axi_wd_bready = 0,  // Response ready
  
// AXI read address channel signals
   input                               axi_rready,     // Read address ready
   output [C_AXI_ID_WIDTH-1:0]         axi_rid = 0,        // Read ID
   output [C_AXI_ADDR_WIDTH-1:0]       axi_raddr = 0,      // Read address
   output [7:0]                        axi_rlen = 0,       // Read Burst Length
   output [2:0]                        axi_rsize = 0,      // Read Burst size
   output [1:0]                        axi_rburst = 0,     // Read Burst type
   output [1:0]                        axi_rlock = 0,      // Read lock type
   output [3:0]                        axi_rcache = 0,     // Read Cache type
   output [2:0]                        axi_rprot = 0,      // Read Protection type
   output                              axi_rvalid = 0,     // Read address valid
  
// AXI read data channel signals   
   input  [C_AXI_ID_WIDTH-1:0]         axi_rd_bid,     // Response ID
   input  [1:0]                        axi_rd_rresp,   // Read response
   input                               axi_rd_rvalid,  // Read reponse valid
   input  [C_AXI_DATA_WIDTH-1:0]       axi_rd_data,    // Read data
   input                               axi_rd_last,    // Read last
   output                              axi_rd_rready = 0,  // Read Response ready

// Error status signals
   output                              cmd_err,      // Error during command phase
   output                              data_msmatch_err, // Data mismatch
   output                              write_err,    // Write error occured
   output                              read_err,     // Read error occured
   output                              test_cmptd,   // Data pattern test completed
   output                              write_cmptd,  // Write test completed
   output                              read_cmptd,   // Read test completed
   output reg                          cmptd_one_wr_rd, // Completed atleast one write
                                                        // and read

// Debug status signals
   output                              cmp_data_en,
   output [C_AXI_DATA_WIDTH-1:0]       cmp_data_o,     // Compare data 
   output [C_AXI_DATA_WIDTH-1:0]       rdata_cmp,      // Read data 
   output                              dbg_wr_sts_vld, // Write debug status valid,
   output [DBG_WR_STS_WIDTH-1:0]       dbg_wr_sts,     // Write status
   output                              dbg_rd_sts_vld, // Read debug status valid
   output [DBG_RD_STS_WIDTH-1:0]       dbg_rd_sts      // Read status
);

task axi_write;
    input    [07:00]        awlen;
    input    [02:00]        awsize;
    input    [01:00]        awburst;
    input    [C_AXI_ADDR_WIDTH-1:00]        addr;
    input    [C_AXI_ID_WIDTH-1:00]        wid;

    begin
        wait(init_cmptd);
        begin
            repeat(10) @(posedge aclk);

            /*
             * 写地址
             */
            axi_wid = wid;
            repeat(10) @(posedge aclk);
            axi_wlen = awlen;
            axi_wsize = awsize;
            axi_wburst = awburst;
            repeat(2) @(posedge aclk);
            axi_wvalid = 1;
            wait (axi_wready);
            @(posedge aclk);
            axi_wvalid = 0;

            /*
             * 写数据
             */
            repeat(5) @(posedge aclk);
            axi_wd_valid = 1;
            wait(axi_wd_wready);
            begin
                repeat(awlen)
                begin
                    axi_wd_data = ({$random} % 65536);
                    @(posedge aclk);
                end
                axi_wd_last = 1;
                axi_wd_data = ({$random} % 2);
                @(posedge aclk);
                axi_wd_last = 0;
            end
            axi_wd_valid = 0;

            repeat(5) @(posedge aclk);
            axi_wd_bready = 1;
            wait(axi_wd_bvalid);
            @(posedge aclk);
            axi_wd_bready = 0;
        end
    end
endtask

// AXI read address channel signals
   input                               axi_rready,     // Read address ready
   output [C_AXI_ID_WIDTH-1:0]         axi_rid,        // Read ID
   output [C_AXI_ADDR_WIDTH-1:0]       axi_raddr,      // Read address
   output [7:0]                        axi_rlen,       // Read Burst Length
   output [2:0]                        axi_rsize,      // Read Burst size
   output [1:0]                        axi_rburst,     // Read Burst type
   output [1:0]                        axi_rlock,      // Read lock type
   output [3:0]                        axi_rcache,     // Read Cache type
   output [2:0]                        axi_rprot,      // Read Protection type
   output                              axi_rvalid,     // Read address valid
  
// AXI read data channel signals   
   input  [C_AXI_ID_WIDTH-1:0]         axi_rd_bid,     // Response ID
   input  [1:0]                        axi_rd_rresp,   // Read response
   input                               axi_rd_rvalid,  // Read reponse valid
   input  [C_AXI_DATA_WIDTH-1:0]       axi_rd_data,    // Read data
   input                               axi_rd_last,    // Read last
   output                              axi_rd_rready,  // Read Response ready
task axi_read;
    input    [07:00]        rlen;
    input    [02:00]        rsize;
    input    [01:00]        rburst;
    input    [C_AXI_ADDR_WIDTH-1:00]        addr;
    input    [C_AXI_ID_WIDTH-1:00]        wid;
    begin
        axi_rlen = rwlen;
        axi_rsize = rsize;
        axi_rburst = rburst;
        repeat(5) @(posedge aclk);
        axi_rid = 0;
        axi_raddr = 0;
        repeat(5) @(posedge aclk);
        axi_rvalid = 1;
        wait(axi_rready);
        @(posedge aclk);
        axi_rvalid = 0;
    end
endtask


initial
begin
    //axi_write(2, 6, 1, 0, 0);
    axi_write(2, 6, 1, 0, 0);
end

endmodule
