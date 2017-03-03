onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_tb_top/u_ip_top/u_axi4_tg_inst/aclk
add wave -noupdate -divider {write config}
add wave -noupdate -radix unsigned /sim_tb_top/u_ip_top/u_DDR3/s_axi_awlen
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awsize
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awburst
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awlock
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awcache
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awprot
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awqos
add wave -noupdate -divider {write addr channal}
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awaddr
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awvalid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_awready
add wave -noupdate -divider {write data channal}
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_wdata
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_wstrb
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_wlast
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_wvalid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_wready
add wave -noupdate -divider {write resp channal}
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_bready
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_bid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_bresp
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_bvalid
add wave -noupdate -divider {read config}
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arlen
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arsize
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arburst
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arlock
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arcache
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arprot
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arqos
add wave -noupdate -divider {read addr channal}
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_araddr
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arvalid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_arready
add wave -noupdate -divider {read data channal}
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_rid
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_rdata
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_rresp
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_rlast
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_rready
add wave -noupdate /sim_tb_top/u_ip_top/u_DDR3/s_axi_rvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110436250000 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {110172307357 fs} {110700192643 fs}
