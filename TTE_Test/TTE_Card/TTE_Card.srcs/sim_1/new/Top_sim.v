`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/14 10:07:40
// Design Name: 
// Module Name: Top_sim
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


module Top_sim;
    /*-----------------Clock Generator---------------*/
    reg sys_clk_p = 1;
    wire sys_clk_n;
    reg rst_n = 1;
    reg pll_clk = 1;
    wire sysclk_100;
    wire sysclk;
    wire clk_lock;

    assign sys_clk_n = ~sys_clk_p;

    initial
    begin
        #5  rst_n <= 0;
        #15 rst_n <= 1;
    end

    always
        #10  sys_clk_p <= ~sys_clk_p;

    always
        #5  pll_clk <= ~pll_clk;

    // TTE_Top interface
    reg     [14:0]      DDR3_addr   ;
    reg     [2:0]       DDR3_ba     ;
    reg                 DDR3_cas_n  ;
    reg     [0:0]       DDR3_ck_n   ;
    reg     [0:0]       DDR3_ck_p   ;
    reg     [0:0]       DDR3_cke    ;
    reg     [0:0]       DDR3_cs_n   ;
    reg     [3:0]       DDR3_dm     ;
    reg     [31:0]      DDR3_dq     ;
    reg     [3:0]       DDR3_dqs_n  ;
    reg     [3:0]       DDR3_dqs_p  ;
    reg     [31:0]      DDR3_odt    ;
    reg                 DDR3_ras_n  ;
    reg                 DDR3_reset_n;
    reg                 DDR3_we_n   ;
    reg                 DDR_Init    ;

    reg     [0:0]       pcie_rxn    ;
    reg     [0:0]       pcie_rxp    ;
    reg     [0:0]       pcie_txn    ;
    reg     [0:0]       pcie_txp    ;

    wire                WR_start    ;
    reg     [31:0]      WR_addr     = 32'h0;
    reg     [31:0]      WR_len      = 32'd32;
    reg     [31:0]      WR_data     = 32'h12345678;
    wire                WR_done     ;

    wire                RD_start    ;
    reg     [31:0]      RD_addr     = 32'h0;
    reg     [31:0]      RD_len      = 32'd32;
    reg     [31:0]      RD_data     ;
    wire                RD_done     ;

    wire                MIG_rst     ;

    wire                PCIe_rst    ;

    wire                MSI_en      ;

    wire                User_Lnk_up ;

    assign  MIG_rst     = rst_n;
    assign  PCIe_rst    = rst_n;
    assign  MSI_en      = 1'b1;

    TTE_Top top
    (
        .Crystal_p      (sys_clk_p      ),
        .Crystal_n      (sys_clk_n      ),
        .PLL_Clk_in     (pll_clk        ),
        .Sys_rst        (rst_n          ),

        .DDR3_addr      (DDR3_addr      ),
        .DDR3_ba        (DDR3_ba        ),
        .DDR3_cas_n     (DDR3_cas_n     ),
        .DDR3_ck_n      (DDR3_ck_n      ),
        .DDR3_ck_p      (DDR3_ck_p      ),
        .DDR3_cke       (DDR3_cke       ),
        .DDR3_cs_n      (DDR3_cs_n      ),
        .DDR3_dm        (DDR3_dm        ),
        .DDR3_dq        (DDR3_dq        ),
        .DDR3_dqs_n     (DDR3_dqs_n     ),
        .DDR3_dqs_p     (DDR3_dqs_p     ),
        .DDR3_odt       (DDR3_odt       ),
        .DDR3_ras_n     (DDR3_ras_n     ),
        .DDR3_reset_n   (DDR3_reset_n   ),
        .DDR3_we_n      (DDR3_we_n      ),
        .DDR_Init       (DDR_Init       ),
    // PCIe
        .pcie_rxn       (pcie_rxn       ),
        .pcie_rxp       (pcie_rxp       ),
        .pcie_txn       (pcie_txn       ),
        .pcie_txp       (pcie_txp       ),
    // 数据接口
        .WR_start       (WR_start       ),
        .WR_addr        (WR_addr        ),
        .WR_len         (WR_len         ),
        .WR_data        (WR_data        ),
        .WR_done        (WR_done        ),

        .RD_start       (RD_start       ),
        .RD_addr        (RD_addr        ),
        .RD_len         (RD_len         ), 
        .RD_data        (RD_data        ),
        .RD_done        (RD_done        ),
    // 复位
        .MIG_rst        (MIG_rst        ),
        .PCIe_rst       (PCIe_rst       ),
    // MSI使能
        .MSI_en         (MSI_en         ),
    // User_Link
        .User_Lnk_up    (User_Lnk_up    )
    );


endmodule
