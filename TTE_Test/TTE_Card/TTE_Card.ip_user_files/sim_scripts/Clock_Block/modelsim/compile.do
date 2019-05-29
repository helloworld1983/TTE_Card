vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../TTE_Card.srcs/sources_1/bd/Clock_Block/ipshared/85a3" \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/Clock_Block/ip/Clock_Block_util_ds_buf_0_0/util_ds_buf.vhd" \
"../../../bd/Clock_Block/ip/Clock_Block_util_ds_buf_0_0/sim/Clock_Block_util_ds_buf_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../TTE_Card.srcs/sources_1/bd/Clock_Block/ipshared/85a3" \
"../../../bd/Clock_Block/ip/Clock_Block_clk_wiz_0_0/Clock_Block_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/Clock_Block/ip/Clock_Block_clk_wiz_0_0/Clock_Block_clk_wiz_0_0.v" \
"../../../bd/Clock_Block/sim/Clock_Block.v" \

vlog -work xil_defaultlib \
"glbl.v"

