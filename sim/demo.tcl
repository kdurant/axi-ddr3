quit -sim
set env(XILINX)        C:/Xilinx/14.7/ISE_DS/ISE
set env(SIM_LIB)       F:/crack/ise14.7_lib

vmap secureip           $env(SIM_LIB)/secureip
vmap unisims_ver        $env(SIM_LIB)/unisims_ver
vmap unimacro_ver       $env(SIM_LIB)/unimacro_ver
vmap xilinxcorelib_ver  $env(SIM_LIB)/xilinxcorelib_ver

vlog -incr      $env(XILINX)/verilog/src/glbl.v
vlog -incr      ../example_design/rtl/*.v
vlog -incr      ../example_design/rtl/traffic_gen/*.v
vlog -incr      ../user_design/rtl/*.v
vlog -incr      ../user_design/rtl/clocking/*.v
vlog -incr      ../user_design/rtl/controller/*.v
vlog -incr      ../user_design/rtl/ecc/*.v
vlog -incr      ../user_design/rtl/ip_top/*.v
vlog -incr      ../user_design/rtl/phy/*.v
vlog -incr      ../user_design/rtl/ui/*.v
vlog -incr      ../user_design/rtl/axi/*.v

vlog -incr      ../example_design/sim/wiredly.v
vlog -incr      ../example_design/sim/sim_tb_top.v

vlog -incr +incdir+../example_design/sim +define+x2Gb +define+sg187E +define+x8 ../example_design/sim/ddr3_model.v

#Pass the parameters for memory model parameter file#
#vlog -incr +incdir+. +define+x2Gb +define+sg187E +define+x8 ddr3_model.v

#Load the design. Use required libraries.#
vsim -t fs -novopt +notimingchecks -L unisims_ver -L secureip work.sim_tb_top glbl

log -r /*
radix 16

do wave.do
run 120us

