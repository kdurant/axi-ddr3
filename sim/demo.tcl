quit -sim
set env(XILINX)        C:/Xilinx/14.7/ISE_DS/ISE
set env(SIM_LIB)       F:/crack/ise14.7_lib

#vmap secureip           $env(SIM_LIB)/secureip
#vmap unisims_ver        $env(SIM_LIB)/unisims_ver
#vmap unimacro_ver       $env(SIM_LIB)/unimacro_ver
#vmap xilinxcorelib_ver  $env(SIM_LIB)/xilinxcorelib_ver

vlog -incr $env(XILINX)/verilog/src/glbl.v

vsim -t ps -novopt +notimingchecks -L unisims_ver -L unimacro_ver -L secureip -L XilinxCoreLib_ver work.tb glbl

log -r /*
radix 16

do wave.do
run 30us

