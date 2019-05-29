vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../TTE_Card.srcs/sources_1/bd/Clock_Block/ipshared/85a3" \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/Clock_Block/ip/Clock_Block_util_ds_buf_0_0/util_ds_buf.vhd" \
"../../../bd/Clock_Block/ip/Clock_Block_util_ds_buf_0_0/sim/Clock_Block_util_ds_buf_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TTE_Card.srcs/sources_1/bd/Clock_Block/ipshared/85a3" \
"../../../bd/Clock_Block/ip/Clock_Block_clk_wiz_0_0/Clock_Block_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/Clock_Block/ip/Clock_Block_clk_wiz_0_0/Clock_Block_clk_wiz_0_0.v" \
"../../../bd/Clock_Block/sim/Clock_Block.v" \

vlog -work xil_defaultlib \
"glbl.v"

