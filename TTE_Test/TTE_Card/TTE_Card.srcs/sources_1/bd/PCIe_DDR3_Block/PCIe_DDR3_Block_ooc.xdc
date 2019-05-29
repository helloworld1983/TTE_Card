################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name Sys_Clk -period 10 [get_ports Sys_Clk]
create_clock -name Sys_Clk_200M -period 5 [get_ports Sys_Clk_200M]
create_clock -name Sys_Clk_150M -period 10 [get_ports Sys_Clk_150M]

################################################################################