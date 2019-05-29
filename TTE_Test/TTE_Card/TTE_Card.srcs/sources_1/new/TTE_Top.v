`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 11:05:05
// Design Name: 
// Module Name: TTE_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TTE_Top
(
    //------------------- Clock_Block ----------------------
    // 外部晶振输入
    input                   Crystal_p,
    input                   Crystal_n,
    input                   PLL_Clk_in,
    // 复位
    input                   Sys_rst,

    //----------------- PCIe_DDR3_Block --------------------
    // DDR3
    output      [14:0]              DDR3_addr,
    output      [2:0]               DDR3_ba,
    output                          DDR3_cas_n,
    output      [0:0]               DDR3_ck_n,
    output      [0:0]               DDR3_ck_p,
    output      [0:0]               DDR3_cke,
    output      [0:0]               DDR3_cs_n,
    output      [3:0]               DDR3_dm,
    inout       [31:0]              DDR3_dq,
    inout       [3:0]               DDR3_dqs_n,
    inout       [3:0]               DDR3_dqs_p,
    output      [0:0]               DDR3_odt,
    output                          DDR3_ras_n,
    output                          DDR3_reset_n,
    output                          DDR3_we_n,
    output                          DDR_Init,
    // PCIe
    input       [0:0]               pcie_rxn,
    input       [0:0]               pcie_rxp,
    output      [0:0]               pcie_txn,
    output      [0:0]               pcie_txp,
    // 复位
    input                           MIG_rst,
    input                           PCIe_rst,
    // MSI使能
    output                          MSI_en,
    // User_Link
    output                          User_Lnk_up
);

/////////////////////Wire And Register Definition//////////////////////
    //------------------- Clock_Block ----------------------
    wire                            Sys_Clk;        // 200M buffer, from Crystal_p(R4) and Crystal_n(T4)
    wire                            Sys_Clk_100M;   // MMCM/PLL, from PLL_Clk_in(F10)
    wire                            Sys_Clk_150M;   // MMCM/PLL, from PLL_Clk_in(F10)
    wire                            Sys_Clk_200M;   // MMCM/PLL, from PLL_Clk_in(F10)
    wire                            Sys_Clk_Locked;

////////////////////////////////Modules////////////////////////////////
    Clock_Block_wrapper Clk_Gen
    (
        .Crystal_Clk_in_clk_n       (Crystal_n      ),
        .Crystal_Clk_in_clk_p       (Crystal_p      ),
        .PLL_Clk_in                 (PLL_Clk_in     ),
        .Sys_Clk                    (Sys_Clk        ),
        .Sys_Clk_100M               (Sys_Clk_100M   ),
        .Sys_Clk_150M               (Sys_Clk_150M   ),
        .Sys_Clk_200M               (Sys_Clk_200M   ),
        .Sys_Clk_Locked             (Sys_Clk_Locked ),
        .Sys_rst                    (Sys_rst        )
    );

    PCIe_DDR3_Block_wrapper PCIe_DDR3
    (
        .AXI_Slv1_buffer_araddr     (),
        .AXI_Slv1_buffer_arburst    (),
        .AXI_Slv1_buffer_arcache    (),
        .AXI_Slv1_buffer_arlen      (),
        .AXI_Slv1_buffer_arlock     (),
        .AXI_Slv1_buffer_arprot     (),
        .AXI_Slv1_buffer_arqos      (),
        .AXI_Slv1_buffer_arready    (),
        .AXI_Slv1_buffer_arsize     (),
        .AXI_Slv1_buffer_arvalid    (),
        .AXI_Slv1_buffer_awaddr     (),
        .AXI_Slv1_buffer_awburst    (),
        .AXI_Slv1_buffer_awcache    (),
        .AXI_Slv1_buffer_awlen      (),
        .AXI_Slv1_buffer_awlock     (),
        .AXI_Slv1_buffer_awprot     (),
        .AXI_Slv1_buffer_awqos      (),
        .AXI_Slv1_buffer_awready    (),
        .AXI_Slv1_buffer_awsize     (),
        .AXI_Slv1_buffer_awvalid    (),
        .AXI_Slv1_buffer_bready     (),
        .AXI_Slv1_buffer_bresp      (),
        .AXI_Slv1_buffer_bvalid     (),
        .AXI_Slv1_buffer_rdata      (),
        .AXI_Slv1_buffer_rlast      (),
        .AXI_Slv1_buffer_rready     (),
        .AXI_Slv1_buffer_rresp      (),
        .AXI_Slv1_buffer_rvalid     (),
        .AXI_Slv1_buffer_wdata      (),
        .AXI_Slv1_buffer_wlast      (),
        .AXI_Slv1_buffer_wready     (),
        .AXI_Slv1_buffer_wstrb      (),
        .AXI_Slv1_buffer_wvalid     (),
        .AXI_Slv2_buffer_araddr     (),
        .AXI_Slv2_buffer_arburst    (),
        .AXI_Slv2_buffer_arcache    (),
        .AXI_Slv2_buffer_arlen      (),
        .AXI_Slv2_buffer_arlock     (),
        .AXI_Slv2_buffer_arprot     (),
        .AXI_Slv2_buffer_arqos      (),
        .AXI_Slv2_buffer_arready    (),
        .AXI_Slv2_buffer_arsize     (),
        .AXI_Slv2_buffer_arvalid    (),
        .AXI_Slv2_buffer_awaddr     (),
        .AXI_Slv2_buffer_awburst    (),
        .AXI_Slv2_buffer_awcache    (),
        .AXI_Slv2_buffer_awlen      (),
        .AXI_Slv2_buffer_awlock     (),
        .AXI_Slv2_buffer_awprot     (),
        .AXI_Slv2_buffer_awqos      (),
        .AXI_Slv2_buffer_awready    (),
        .AXI_Slv2_buffer_awsize     (),
        .AXI_Slv2_buffer_awvalid    (),
        .AXI_Slv2_buffer_bready     (),
        .AXI_Slv2_buffer_bresp      (),
        .AXI_Slv2_buffer_bvalid     (),
        .AXI_Slv2_buffer_rdata      (),
        .AXI_Slv2_buffer_rlast      (),
        .AXI_Slv2_buffer_rready     (),
        .AXI_Slv2_buffer_rresp      (),
        .AXI_Slv2_buffer_rvalid     (),
        .AXI_Slv2_buffer_wdata      (),
        .AXI_Slv2_buffer_wlast      (),
        .AXI_Slv2_buffer_wready     (),
        .AXI_Slv2_buffer_wstrb      (),
        .AXI_Slv2_buffer_wvalid     (),
        .DDR3_0_addr                (DDR3_addr),
        .DDR3_0_ba                  (DDR3_ba),
        .DDR3_0_cas_n               (DDR3_cas_n),
        .DDR3_0_ck_n                (DDR3_ck_n),
        .DDR3_0_ck_p                (DDR3_ck_p),
        .DDR3_0_cke                 (DDR3_cke),
        .DDR3_0_cs_n                (DDR3_cs_n),
        .DDR3_0_dm                  (DDR3_dm),
        .DDR3_0_dq                  (DDR3_dq),
        .DDR3_0_dqs_n               (DDR3_dqs_n),
        .DDR3_0_dqs_p               (DDR3_dqs_p),
        .DDR3_0_odt                 (DDR3_odt),
        .DDR3_0_ras_n               (DDR3_ras_n),
        .DDR3_0_reset_n             (DDR3_reset_n),
        .DDR3_0_we_n                (DDR3_we_n),
        .DDR_Init                   (DDR_Init),
        .MIG_rst                    (MIG_rst),
        .MSI_en                     (MSI_en),
        .PCIe_data_rxn              (pcie_rxn),
        .PCIe_data_rxp              (pcie_rxp),
        .PCIe_data_txn              (pcie_txn),
        .PCIe_data_txp              (pcie_txp),
        .Sys_Clk                    (Sys_Clk),
        .Sys_Clk_150M               (Sys_Clk_150M),
        .Sys_Clk_200M               (Sys_Clk_200M),
        .Sys_rst                    (Sys_rst),
        .User_Lnk_up                (User_Lnk_up),
        .Usr_IRQ                    (),
        .pcie_rst                   (PCIe_rst)
    );

endmodule
