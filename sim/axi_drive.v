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

module axi_drive #
(
    parameter               C_S_AXI_ID_WIDTH = 4,
    parameter               C_S_AXI_ADDR_WIDTH = 32,
    parameter               C_S_AXI_DATA_WIDTH = 512
)
(
    input   wire                            clk,
    input   wire                            rst,
    input   wire                            init_calib_complete,

    // Slave Interface Write Address Ports
    output  reg  [C_S_AXI_ID_WIDTH-1:00]    s_axi_awid,
    output  reg  [C_S_AXI_ADDR_WIDTH-1:00]  s_axi_awaddr,
    output  reg  [07:00]                    s_axi_awlen = 0,
    output  reg  [02:00]                    s_axi_awsize = 0,
    output  reg  [01:00]                    s_axi_awburst = 0,
    output  reg  [00:00]                    s_axi_awlock = 0,
    output  reg  [C_S_AXI_ID_WIDTH-1:00]    s_axi_awcache = 0,
    output  reg  [02:00]                    s_axi_awprot = 0,
    output  reg                             s_axi_awvalid,
    input   wire                            s_axi_awready,

    // Slave Interface Write Data Ports
    output  reg  [C_S_AXI_DATA_WIDTH-1:0]   s_axi_wdata = 0,
    output  reg  [C_S_AXI_DATA_WIDTH/8-1:00]s_axi_wstrb = {64{1'b1}},
    output  reg                             s_axi_wlast = 0,
    output  reg                             s_axi_wvalid = 0,
    input   wire                            s_axi_wready,

    // Slave Interface Write Response Ports
    output  reg                             s_axi_bready = 0,
    input   wire [C_S_AXI_ID_WIDTH-1:00]    s_axi_bid,
    input   wire [10:00]                    s_axi_bresp,
    input   wire                            s_axi_bvalid,

    // Slave Interface Read Address Ports
    output  reg  [C_S_AXI_ID_WIDTH-1:00]    s_axi_arid = 0,
    output  reg  [C_S_AXI_ADDR_WIDTH-1:00]  s_axi_araddr = 0,
    output  reg  [07:00]                    s_axi_arlen = 0,
    output  reg  [02:00]                    s_axi_arsize = 0,
    output  reg  [01:00]                    s_axi_arburst = 0,
    output  reg  [00:00]                    s_axi_arlock = 0,
    output  reg  [03:00]                    s_axi_arcache = 0,
    output  reg  [02:00]                    s_axi_arprot = 0,
    output  reg                             s_axi_arvalid = 0,
    input   wire                            s_axi_arready,

    // Slave Interface Read Data Ports
    output  reg                             s_axi_rready = 0,
    input   wire [C_S_AXI_ID_WIDTH-1:0]     s_axi_rid,
    input   wire [C_S_AXI_DATA_WIDTH-1:0]   s_axi_rdata,
    input   wire [1:0]                      s_axi_rresp,
    input   wire                            s_axi_rlast,
    input   wire                            s_axi_rvalid
);

localparam              OFFSET = 512/8;
task axi_write;
    input    [07:00]        awlen;
    input    [02:00]        awsize;
    input    [01:00]        awburst;
    input    [31:00]        addr;
    input    [03:00]        wid;

    begin
        wait(init_calib_complete);
        begin
            repeat(10) @(posedge clk);

            /*
             * 写地址
             */
            s_axi_awid = wid;
            //repeat(10) @(posedge clk);
            s_axi_awlen = awlen;
            s_axi_awsize = awsize;
            s_axi_awburst = awburst;
            s_axi_awaddr = addr;
            //repeat(2) @(posedge clk);
            s_axi_awvalid = 1;
            wait (s_axi_awready);
            @(posedge clk);
            s_axi_awvalid = 0;

            /*
             * 写数据
             */
            //repeat(5) @(posedge clk);
            s_axi_wvalid = 1;
            wait(s_axi_wready);
            begin
                repeat(awlen)
                begin
                    //s_axi_wd_data = ({$random} % 2**32);
                    s_axi_wdata = $random;
                    @(posedge clk);
                end
                s_axi_wlast = 1;
                //s_axi_wd_data = ({$random} % 2**32);
                s_axi_wdata = $random;
                @(posedge clk);
                s_axi_wlast = 0;
            end
            s_axi_wvalid = 0;

            //repeat(5) @(posedge clk);
            s_axi_bready = 1;
            wait(s_axi_bvalid);
            @(posedge clk);
            s_axi_bready = 0;
        end
    end
endtask

task axi_read;
    input    [07:00]        rlen;
    input    [02:00]        rsize;
    input    [01:00]        rburst;
    input    [31:00]        addr;
    input    [03:00]        rid;
    begin
        s_axi_arlen = rlen;
        s_axi_arsize = rsize;
        s_axi_arburst = rburst;
        repeat(5) @(posedge clk);
        s_axi_arid = rid;
        s_axi_araddr = addr;
        repeat(5) @(posedge clk);
        s_axi_arvalid = 1;
        wait(s_axi_arready);
        @(posedge clk);
        s_axi_arvalid = 0;

        repeat(5) @(posedge clk);
        s_axi_rready = 1;
        wait(s_axi_rlast & s_axi_rvalid);
        @(posedge clk);
        s_axi_rready = 0;
    end
endtask

initial
begin
    //axi_write(2, 6, 1, 0, 0);
    axi_write(0, 6, 1, OFFSET*0, 0);
    axi_write(0, 6, 1, OFFSET*1, 0);
    axi_write(0, 6, 1, OFFSET*2, 0);
    //repeat(5) @(posedge aclk);
    //axi_write(2, 6, 1, OFFSET*1, 2);

    repeat(5) @(posedge aclk);
    axi_read(2, 6, 1, 'h20, 1);

    repeat(5) @(posedge aclk);
    axi_read(2, 6, 1, 'h40, 1);

    repeat(5) @(posedge aclk);
    axi_read(2, 6, 1, 'h60, 2);

    repeat(5) @(posedge aclk);
    axi_read(2, 6, 1, 'h80, 1);

    repeat(5) @(posedge aclk);
    axi_read(2, 6, 1, 'ha0, 2);

    repeat(5) @(posedge aclk);
    axi_read(2, 6, 1, 'hc0, 1);

    //repeat(5) @(posedge aclk);
    //axi_read(2, 6, 1, OFFSET*1, 2);
end
endmodule
