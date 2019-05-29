-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Vivavdo2018/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/Clock_Block/ip/Clock_Block_util_ds_buf_0_0/util_ds_buf.vhd" \
  "../../../bd/Clock_Block/ip/Clock_Block_util_ds_buf_0_0/sim/Clock_Block_util_ds_buf_0_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/Clock_Block/ip/Clock_Block_clk_wiz_0_0/Clock_Block_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/Clock_Block/ip/Clock_Block_clk_wiz_0_0/Clock_Block_clk_wiz_0_0.v" \
  "../../../bd/Clock_Block/sim/Clock_Block.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

