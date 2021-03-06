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
    // 数据接口
    input                           WR_start,
    input       [31:0]              WR_addr,
    input       [31:0]              WR_len,
    input       [31:0]              WR_data,
    output                          WR_done,

    input                           RD_start,
    input       [31:0]              RD_addr,
    input       [31:0]              RD_len, 
    output      [31:0]              RD_data,
    output                          RD_done,
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

    //----------------- PCIe_DDR3_Block --------------------
    // Slave1-For Ethernet1
    wire      [31:0]                AXI_Slv1_awaddr;
    wire      [7:0]                 AXI_Slv1_awlen;
    wire      [2:0]                 AXI_Slv1_awsize;
    wire      [1:0]                 AXI_Slv1_awburst;
    wire      [0:0]                 AXI_Slv1_awlock;
    wire      [3:0]                 AXI_Slv1_awcache;
    wire      [2:0]                 AXI_Slv1_awprot;
    wire      [3:0]                 AXI_Slv1_awqos;
    wire                            AXI_Slv1_awvalid;
    wire                            AXI_Slv1_awready;

    wire      [63:0]                AXI_Slv1_wdata;
    wire      [7:0]                 AXI_Slv1_wstrb;
    wire                            AXI_Slv1_wlast;
    wire                            AXI_Slv1_wvalid;
    wire                            AXI_Slv1_wready;

    wire      [1:0]                 AXI_Slv1_bresp;
    wire                            AXI_Slv1_bvalid;
    wire                            AXI_Slv1_bready;

    wire      [31:0]                AXI_Slv1_araddr;
    wire      [7:0]                 AXI_Slv1_arlen;
    wire      [2:0]                 AXI_Slv1_arsize;
    wire      [1:0]                 AXI_Slv1_arburst;
    wire      [0:0]                 AXI_Slv1_arlock;
    wire      [3:0]                 AXI_Slv1_arcache;
    wire      [2:0]                 AXI_Slv1_arprot;
    wire      [3:0]                 AXI_Slv1_arqos;
    wire                            AXI_Slv1_arvalid;
    wire                            AXI_Slv1_arready;

    wire      [63:0]                AXI_Slv1_rdata;
    wire      [1:0]                 AXI_Slv1_rresp;
    wire                            AXI_Slv1_rlast;
    wire                            AXI_Slv1_rvalid;
    wire                            AXI_Slv1_rready;
    // Slave2-For Ethernet2
    wire      [31:0]                AXI_Slv2_awaddr;
    wire      [7:0]                 AXI_Slv2_awlen;
    wire      [2:0]                 AXI_Slv2_awsize;
    wire      [1:0]                 AXI_Slv2_awburst;
    wire      [0:0]                 AXI_Slv2_awlock;
    wire      [3:0]                 AXI_Slv2_awcache;
    wire      [2:0]                 AXI_Slv2_awprot;
    wire      [3:0]                 AXI_Slv2_awqos;
    wire                            AXI_Slv2_awvalid;
    wire                            AXI_Slv2_awready;

    wire      [63:0]                AXI_Slv2_wdata;
    wire      [7:0]                 AXI_Slv2_wstrb;
    wire                            AXI_Slv2_wlast;
    wire                            AXI_Slv2_wvalid;
    wire                            AXI_Slv2_wready;

    wire      [1:0]                 AXI_Slv2_bresp;
    wire                            AXI_Slv2_bvalid;
    wire                            AXI_Slv2_bready;

    wire      [31:0]                AXI_Slv2_araddr;
    wire      [7:0]                 AXI_Slv2_arlen;
    wire      [2:0]                 AXI_Slv2_arsize;
    wire      [1:0]                 AXI_Slv2_arburst;
    wire      [0:0]                 AXI_Slv2_arlock;
    wire      [3:0]                 AXI_Slv2_arcache;
    wire      [2:0]                 AXI_Slv2_arprot;
    wire      [3:0]                 AXI_Slv2_arqos;
    wire                            AXI_Slv2_arvalid;
    wire                            AXI_Slv2_arready;

    wire      [63:0]                AXI_Slv2_rdata;
    wire      [1:0]                 AXI_Slv2_rresp;
    wire                            AXI_Slv2_rlast;
    wire                            AXI_Slv2_rvalid;
    wire                            AXI_Slv2_rready;

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
        .AXI_Slv1_buffer_araddr     (AXI_Slv1_araddr),
        .AXI_Slv1_buffer_arburst    (AXI_Slv1_arburst),
        .AXI_Slv1_buffer_arcache    (AXI_Slv1_arcache),
        .AXI_Slv1_buffer_arlen      (AXI_Slv1_arlen),
        .AXI_Slv1_buffer_arlock     (AXI_Slv1_arlock),
        .AXI_Slv1_buffer_arprot     (AXI_Slv1_arprot),
        .AXI_Slv1_buffer_arqos      (AXI_Slv1_arqos),
        .AXI_Slv1_buffer_arready    (AXI_Slv1_arready),
        .AXI_Slv1_buffer_arsize     (AXI_Slv1_arsize),
        .AXI_Slv1_buffer_arvalid    (AXI_Slv1_arvalid),
        .AXI_Slv1_buffer_awaddr     (AXI_Slv1_awaddr),
        .AXI_Slv1_buffer_awburst    (AXI_Slv1_awburst),
        .AXI_Slv1_buffer_awcache    (AXI_Slv1_awcache),
        .AXI_Slv1_buffer_awlen      (AXI_Slv1_awlen),
        .AXI_Slv1_buffer_awlock     (AXI_Slv1_awlock),
        .AXI_Slv1_buffer_awprot     (AXI_Slv1_awprot),
        .AXI_Slv1_buffer_awqos      (AXI_Slv1_awqos),
        .AXI_Slv1_buffer_awready    (AXI_Slv1_awready),
        .AXI_Slv1_buffer_awsize     (AXI_Slv1_awsize),
        .AXI_Slv1_buffer_awvalid    (AXI_Slv1_awvalid),
        .AXI_Slv1_buffer_bready     (AXI_Slv1_bready),
        .AXI_Slv1_buffer_bresp      (AXI_Slv1_bresp),
        .AXI_Slv1_buffer_bvalid     (AXI_Slv1_bvalid),
        .AXI_Slv1_buffer_rdata      (AXI_Slv1_rdata),
        .AXI_Slv1_buffer_rlast      (AXI_Slv1_rlast),
        .AXI_Slv1_buffer_rready     (AXI_Slv1_rready),
        .AXI_Slv1_buffer_rresp      (AXI_Slv1_rresp),
        .AXI_Slv1_buffer_rvalid     (AXI_Slv1_rvalid),
        .AXI_Slv1_buffer_wdata      (AXI_Slv1_wdata),
        .AXI_Slv1_buffer_wlast      (AXI_Slv1_wlast),
        .AXI_Slv1_buffer_wready     (AXI_Slv1_wready),
        .AXI_Slv1_buffer_wstrb      (AXI_Slv1_wstrb),
        .AXI_Slv1_buffer_wvalid     (AXI_Slv1_wvalid),
        .AXI_Slv2_buffer_araddr     (AXI_Slv2_araddr),
        .AXI_Slv2_buffer_arburst    (AXI_Slv2_arburst),
        .AXI_Slv2_buffer_arcache    (AXI_Slv2_arcache),
        .AXI_Slv2_buffer_arlen      (AXI_Slv2_arlen),
        .AXI_Slv2_buffer_arlock     (AXI_Slv2_arlock),
        .AXI_Slv2_buffer_arprot     (AXI_Slv2_arprot),
        .AXI_Slv2_buffer_arqos      (AXI_Slv2_arqos),
        .AXI_Slv2_buffer_arready    (AXI_Slv2_arready),
        .AXI_Slv2_buffer_arsize     (AXI_Slv2_arsize),
        .AXI_Slv2_buffer_arvalid    (AXI_Slv2_arvalid),
        .AXI_Slv2_buffer_awaddr     (AXI_Slv2_awaddr),
        .AXI_Slv2_buffer_awburst    (AXI_Slv2_awburst),
        .AXI_Slv2_buffer_awcache    (AXI_Slv2_awcache),
        .AXI_Slv2_buffer_awlen      (AXI_Slv2_awlen),
        .AXI_Slv2_buffer_awlock     (AXI_Slv2_awlock),
        .AXI_Slv2_buffer_awprot     (AXI_Slv2_awprot),
        .AXI_Slv2_buffer_awqos      (AXI_Slv2_awqos),
        .AXI_Slv2_buffer_awready    (AXI_Slv2_awready),
        .AXI_Slv2_buffer_awsize     (AXI_Slv2_awsize),
        .AXI_Slv2_buffer_awvalid    (AXI_Slv2_awvalid),
        .AXI_Slv2_buffer_bready     (AXI_Slv2_bready),
        .AXI_Slv2_buffer_bresp      (AXI_Slv2_bresp),
        .AXI_Slv2_buffer_bvalid     (AXI_Slv2_bvalid),
        .AXI_Slv2_buffer_rdata      (AXI_Slv2_rdata),
        .AXI_Slv2_buffer_rlast      (AXI_Slv2_rlast),
        .AXI_Slv2_buffer_rready     (AXI_Slv2_rready),
        .AXI_Slv2_buffer_rresp      (AXI_Slv2_rresp),
        .AXI_Slv2_buffer_rvalid     (AXI_Slv2_rvalid),
        .AXI_Slv2_buffer_wdata      (AXI_Slv2_wdata),
        .AXI_Slv2_buffer_wlast      (AXI_Slv2_wlast),
        .AXI_Slv2_buffer_wready     (AXI_Slv2_wready),
        .AXI_Slv2_buffer_wstrb      (AXI_Slv2_wstrb),
        .AXI_Slv2_buffer_wvalid     (AXI_Slv2_wvalid),
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

    axi_interface   axi_itf
    (

    .ARESETn_in         (PCIe_rst           ),
    .ACLK_in            (Sys_Clk_200M       ),
    // AXI读地址
    .AXI_araddr_o32     (AXI_Slv1_araddr    ),
    .AXI_arburst_o2     (AXI_Slv1_arburst   ),
    .AXI_arcache_o4     (AXI_Slv1_arcache   ),
    .AXI_arlen_o8       (AXI_Slv1_arlen     ),
    .AXI_arlock_o1      (AXI_Slv1_arlock    ),
    .AXI_arprot_o3      (AXI_Slv1_arprot    ),
    .AXI_arqos_o4       (AXI_Slv1_arqos     ),
    .AXI_arready_i      (AXI_Slv1_arready   ),
    .AXI_arsize_o3      (AXI_Slv1_arsize    ),
    .AXI_arvalid_o      (AXI_Slv1_arvalid   ),
    // AXI写地址
    .AXI_awaddr_o32     (AXI_Slv1_awaddr    ),
    .AXI_awburst_o2     (AXI_Slv1_awburst   ),
    .AXI_awcache_o4     (AXI_Slv1_awcache   ),
    .AXI_awlen_o8       (AXI_Slv1_awlen     ),
    .AXI_awlock_o1      (AXI_Slv1_awlock    ),
    .AXI_awprot_o3      (AXI_Slv1_awprot    ),
    .AXI_awqos_o4       (AXI_Slv1_awqos     ),
    .AXI_awready_i      (AXI_Slv1_awready   ),
    .AXI_awsize_o3      (AXI_Slv1_awsize    ),
    .AXI_awvalid_o      (AXI_Slv1_awvalid   ),
    // AXI写响应
    .AXI_bready_o       (AXI_Slv1_bready    ),
    .AXI_bresp_i2       (AXI_Slv1_bresp     ),
    .AXI_bvalid_i       (AXI_Slv1_bvalid    ),
    // AXI读数据
    .AXI_rdata_i32      (AXI_Slv1_rdata     ),
    .AXI_rlast_i        (AXI_Slv1_rlast     ),
    .AXI_rready_o       (AXI_Slv1_rready    ),
    .AXI_rresp_i2       (AXI_Slv1_rresp     ),
    .AXI_rvalid_i       (AXI_Slv1_rvalid    ),
    // AXI写数据
    .AXI_wdata_o32      (AXI_Slv2_wdata     ),
    .AXI_wlast_o        (AXI_Slv2_wlast     ),
    .AXI_wready_i       (AXI_Slv2_wvalid    ),
    .AXI_wstrb_o4       (AXI_Slv2_wstrb     ),
    .AXI_wvalid_o       (AXI_Slv2_wvalid    ),

    .EXT_WR_start_i     (WR_start           ),
    .EXT_WR_addr_i32    (WR_addr            ),
    .EXT_WR_len_i32     (WR_len             ), 
    .EXT_WR_data_i32    (WR_data            ),
    .EXT_WR_done_o      (WR_done            ),

    .EXT_RD_start_i     (RD_start           ),
    .EXT_RD_addr_i32    (RD_addr            ),
    .EXT_RD_len_i32     (RD_len             ), 
    .EXT_RD_data_o32    (RD_data            ),
    .EXT_RD_done_o      (RD_done            )
    );
endmodule
