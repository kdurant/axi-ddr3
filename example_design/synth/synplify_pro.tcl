project -new
#project files
add_file -verilog "../rtl/traffic_gen/mig_7series_v1_9_axi4_tg.v"
add_file -verilog "../rtl/traffic_gen/mig_7series_v1_9_axi4_wrapper.v"
add_file -verilog "../rtl/traffic_gen/mig_7series_v1_9_cmd_prbs_gen_axi.v"
add_file -verilog "../rtl/traffic_gen/mig_7series_v1_9_data_gen_chk.v"
add_file -verilog "../rtl/traffic_gen/mig_7series_v1_9_tg.v"
add_file -verilog "../rtl/example_top.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_ctrl_addr_decode.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_ctrl_read.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_ctrl_reg.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_ctrl_reg_bank.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_ctrl_top.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_ctrl_write.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_ar_channel.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_aw_channel.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_b_channel.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_cmd_arbiter.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_cmd_fsm.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_cmd_translator.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_incr_cmd.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_r_channel.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_simple_fifo.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_w_channel.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_wr_cmd_fsm.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_axi_mc_wrap_cmd.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_a_upsizer.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_axi_register_slice.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_axi_upsizer.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_axic_register_slice.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_carry_and.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_carry_latch_and.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_carry_latch_or.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_carry_or.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_command_fifo.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_comparator.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_comparator_sel.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_comparator_sel_static.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_r_upsizer.v"
add_file -verilog "../../user_design/rtl/axi/mig_7series_v1_9_ddr_w_upsizer.v"
add_file -verilog "../../user_design/rtl/clocking/mig_7series_v1_9_clk_ibuf.v"
add_file -verilog "../../user_design/rtl/clocking/mig_7series_v1_9_infrastructure.v"
add_file -verilog "../../user_design/rtl/clocking/mig_7series_v1_9_iodelay_ctrl.v"
add_file -verilog "../../user_design/rtl/clocking/mig_7series_v1_9_tempmon.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_arb_mux.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_arb_row_col.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_arb_select.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_bank_cntrl.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_bank_common.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_bank_compare.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_bank_mach.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_bank_queue.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_bank_state.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_col_mach.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_mc.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_rank_cntrl.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_rank_common.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_rank_mach.v"
add_file -verilog "../../user_design/rtl/controller/mig_7series_v1_9_round_robin_arb.v"
add_file -verilog "../../user_design/rtl/ecc/mig_7series_v1_9_ecc_buf.v"
add_file -verilog "../../user_design/rtl/ecc/mig_7series_v1_9_ecc_dec_fix.v"
add_file -verilog "../../user_design/rtl/ecc/mig_7series_v1_9_ecc_gen.v"
add_file -verilog "../../user_design/rtl/ecc/mig_7series_v1_9_ecc_merge_enc.v"
add_file -verilog "../../user_design/rtl/ip_top/mig_7series_v1_9_mem_intfc.v"
add_file -verilog "../../user_design/rtl/ip_top/mig_7series_v1_9_memc_ui_top_axi.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_byte_group_io.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_byte_lane.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_calib_top.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_if_post_fifo.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_mc_phy.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_mc_phy_wrapper.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_of_pre_fifo.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_4lanes.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_ck_addr_cmd_delay.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_dqs_found_cal.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_dqs_found_cal_hr.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_init.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_oclkdelay_cal.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_prbs_rdlvl.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_rdlvl.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_tempmon.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_top.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_wrcal.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_wrlvl.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_phy_wrlvl_off_delay.v"
add_file -verilog "../../user_design/rtl/phy/mig_7series_v1_9_ddr_prbs_gen.v"
add_file -verilog "../../user_design/rtl/ui/mig_7series_v1_9_ui_cmd.v"
add_file -verilog "../../user_design/rtl/ui/mig_7series_v1_9_ui_rd_data.v"
add_file -verilog "../../user_design/rtl/ui/mig_7series_v1_9_ui_top.v"
add_file -verilog "../../user_design/rtl/ui/mig_7series_v1_9_ui_wr_data.v"
add_file -verilog "../../user_design/rtl/DDR3.v"

#implementation: "rev_1"
impl -add rev_1 -type fpga

#device options
set_option -technology kintex7
set_option -part xc7k325t
set_option -package ffg900
set_option -speed_grade -2
set_option -part_companion ""

#compilation/mapping options
set_option -top_module "example_top"

# mapper_options
set_option -frequency 400
set_option -write_verilog 0
set_option -write_vhdl 0

#set result format/file last
project -result_file "../synth/rev_1/example_top.edf"

#implementation attributes
set_option -vlog_std v2001
set_option -project_relative_includes 1
impl -active "../synth/rev_1"
project -run
project -save
