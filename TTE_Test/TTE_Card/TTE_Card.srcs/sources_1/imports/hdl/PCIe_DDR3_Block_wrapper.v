//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Wed May 29 17:35:45 2019
//Host        : LKAYA-DESKTOP running 64-bit major release  (build 9200)
//Command     : generate_target PCIe_DDR3_Block_wrapper.bd
//Design      : PCIe_DDR3_Block_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module PCIe_DDR3_Block_wrapper
   (AXI_Slv1_buffer_araddr,
    AXI_Slv1_buffer_arburst,
    AXI_Slv1_buffer_arcache,
    AXI_Slv1_buffer_arlen,
    AXI_Slv1_buffer_arlock,
    AXI_Slv1_buffer_arprot,
    AXI_Slv1_buffer_arqos,
    AXI_Slv1_buffer_arready,
    AXI_Slv1_buffer_arsize,
    AXI_Slv1_buffer_arvalid,
    AXI_Slv1_buffer_awaddr,
    AXI_Slv1_buffer_awburst,
    AXI_Slv1_buffer_awcache,
    AXI_Slv1_buffer_awlen,
    AXI_Slv1_buffer_awlock,
    AXI_Slv1_buffer_awprot,
    AXI_Slv1_buffer_awqos,
    AXI_Slv1_buffer_awready,
    AXI_Slv1_buffer_awsize,
    AXI_Slv1_buffer_awvalid,
    AXI_Slv1_buffer_bready,
    AXI_Slv1_buffer_bresp,
    AXI_Slv1_buffer_bvalid,
    AXI_Slv1_buffer_rdata,
    AXI_Slv1_buffer_rlast,
    AXI_Slv1_buffer_rready,
    AXI_Slv1_buffer_rresp,
    AXI_Slv1_buffer_rvalid,
    AXI_Slv1_buffer_wdata,
    AXI_Slv1_buffer_wlast,
    AXI_Slv1_buffer_wready,
    AXI_Slv1_buffer_wstrb,
    AXI_Slv1_buffer_wvalid,
    AXI_Slv2_buffer_araddr,
    AXI_Slv2_buffer_arburst,
    AXI_Slv2_buffer_arcache,
    AXI_Slv2_buffer_arlen,
    AXI_Slv2_buffer_arlock,
    AXI_Slv2_buffer_arprot,
    AXI_Slv2_buffer_arqos,
    AXI_Slv2_buffer_arready,
    AXI_Slv2_buffer_arsize,
    AXI_Slv2_buffer_arvalid,
    AXI_Slv2_buffer_awaddr,
    AXI_Slv2_buffer_awburst,
    AXI_Slv2_buffer_awcache,
    AXI_Slv2_buffer_awlen,
    AXI_Slv2_buffer_awlock,
    AXI_Slv2_buffer_awprot,
    AXI_Slv2_buffer_awqos,
    AXI_Slv2_buffer_awready,
    AXI_Slv2_buffer_awsize,
    AXI_Slv2_buffer_awvalid,
    AXI_Slv2_buffer_bready,
    AXI_Slv2_buffer_bresp,
    AXI_Slv2_buffer_bvalid,
    AXI_Slv2_buffer_rdata,
    AXI_Slv2_buffer_rlast,
    AXI_Slv2_buffer_rready,
    AXI_Slv2_buffer_rresp,
    AXI_Slv2_buffer_rvalid,
    AXI_Slv2_buffer_wdata,
    AXI_Slv2_buffer_wlast,
    AXI_Slv2_buffer_wready,
    AXI_Slv2_buffer_wstrb,
    AXI_Slv2_buffer_wvalid,
    DDR3_0_addr,
    DDR3_0_ba,
    DDR3_0_cas_n,
    DDR3_0_ck_n,
    DDR3_0_ck_p,
    DDR3_0_cke,
    DDR3_0_cs_n,
    DDR3_0_dm,
    DDR3_0_dq,
    DDR3_0_dqs_n,
    DDR3_0_dqs_p,
    DDR3_0_odt,
    DDR3_0_ras_n,
    DDR3_0_reset_n,
    DDR3_0_we_n,
    DDR_Init,
    MIG_rst,
    MSI_en,
    PCIe_data_rxn,
    PCIe_data_rxp,
    PCIe_data_txn,
    PCIe_data_txp,
    Sys_Clk,
    Sys_Clk_150M,
    Sys_Clk_200M,
    Sys_rst,
    User_Lnk_up,
    Usr_IRQ,
    pcie_rst);
  input [31:0]AXI_Slv1_buffer_araddr;
  input [1:0]AXI_Slv1_buffer_arburst;
  input [3:0]AXI_Slv1_buffer_arcache;
  input [7:0]AXI_Slv1_buffer_arlen;
  input [0:0]AXI_Slv1_buffer_arlock;
  input [2:0]AXI_Slv1_buffer_arprot;
  input [3:0]AXI_Slv1_buffer_arqos;
  output AXI_Slv1_buffer_arready;
  input [2:0]AXI_Slv1_buffer_arsize;
  input AXI_Slv1_buffer_arvalid;
  input [31:0]AXI_Slv1_buffer_awaddr;
  input [1:0]AXI_Slv1_buffer_awburst;
  input [3:0]AXI_Slv1_buffer_awcache;
  input [7:0]AXI_Slv1_buffer_awlen;
  input [0:0]AXI_Slv1_buffer_awlock;
  input [2:0]AXI_Slv1_buffer_awprot;
  input [3:0]AXI_Slv1_buffer_awqos;
  output AXI_Slv1_buffer_awready;
  input [2:0]AXI_Slv1_buffer_awsize;
  input AXI_Slv1_buffer_awvalid;
  input AXI_Slv1_buffer_bready;
  output [1:0]AXI_Slv1_buffer_bresp;
  output AXI_Slv1_buffer_bvalid;
  output [31:0]AXI_Slv1_buffer_rdata;
  output AXI_Slv1_buffer_rlast;
  input AXI_Slv1_buffer_rready;
  output [1:0]AXI_Slv1_buffer_rresp;
  output AXI_Slv1_buffer_rvalid;
  input [31:0]AXI_Slv1_buffer_wdata;
  input AXI_Slv1_buffer_wlast;
  output AXI_Slv1_buffer_wready;
  input [3:0]AXI_Slv1_buffer_wstrb;
  input AXI_Slv1_buffer_wvalid;
  
  input [31:0]AXI_Slv2_buffer_araddr;
  input [1:0]AXI_Slv2_buffer_arburst;
  input [3:0]AXI_Slv2_buffer_arcache;
  input [7:0]AXI_Slv2_buffer_arlen;
  input [0:0]AXI_Slv2_buffer_arlock;
  input [2:0]AXI_Slv2_buffer_arprot;
  input [3:0]AXI_Slv2_buffer_arqos;
  output AXI_Slv2_buffer_arready;
  input [2:0]AXI_Slv2_buffer_arsize;
  input AXI_Slv2_buffer_arvalid;
  input [31:0]AXI_Slv2_buffer_awaddr;
  input [1:0]AXI_Slv2_buffer_awburst;
  input [3:0]AXI_Slv2_buffer_awcache;
  input [7:0]AXI_Slv2_buffer_awlen;
  input [0:0]AXI_Slv2_buffer_awlock;
  input [2:0]AXI_Slv2_buffer_awprot;
  input [3:0]AXI_Slv2_buffer_awqos;
  output AXI_Slv2_buffer_awready;
  input [2:0]AXI_Slv2_buffer_awsize;
  input AXI_Slv2_buffer_awvalid;
  input AXI_Slv2_buffer_bready;
  output [1:0]AXI_Slv2_buffer_bresp;
  output AXI_Slv2_buffer_bvalid;
  output [31:0]AXI_Slv2_buffer_rdata;
  output AXI_Slv2_buffer_rlast;
  input AXI_Slv2_buffer_rready;
  output [1:0]AXI_Slv2_buffer_rresp;
  output AXI_Slv2_buffer_rvalid;
  input [31:0]AXI_Slv2_buffer_wdata;
  input AXI_Slv2_buffer_wlast;
  output AXI_Slv2_buffer_wready;
  input [3:0]AXI_Slv2_buffer_wstrb;
  input AXI_Slv2_buffer_wvalid;
  output [14:0]DDR3_0_addr;
  output [2:0]DDR3_0_ba;
  output DDR3_0_cas_n;
  output [0:0]DDR3_0_ck_n;
  output [0:0]DDR3_0_ck_p;
  output [0:0]DDR3_0_cke;
  output [0:0]DDR3_0_cs_n;
  output [3:0]DDR3_0_dm;
  inout [31:0]DDR3_0_dq;
  inout [3:0]DDR3_0_dqs_n;
  inout [3:0]DDR3_0_dqs_p;
  output [0:0]DDR3_0_odt;
  output DDR3_0_ras_n;
  output DDR3_0_reset_n;
  output DDR3_0_we_n;
  output DDR_Init;
  input MIG_rst;
  output MSI_en;
  input [0:0]PCIe_data_rxn;
  input [0:0]PCIe_data_rxp;
  output [0:0]PCIe_data_txn;
  output [0:0]PCIe_data_txp;
  input Sys_Clk;
  input Sys_Clk_150M;
  input Sys_Clk_200M;
  input Sys_rst;
  output User_Lnk_up;
  input [1:0]Usr_IRQ;
  input pcie_rst;

  wire [31:0]AXI_Slv1_buffer_araddr;
  wire [1:0]AXI_Slv1_buffer_arburst;
  wire [3:0]AXI_Slv1_buffer_arcache;
  wire [7:0]AXI_Slv1_buffer_arlen;
  wire [0:0]AXI_Slv1_buffer_arlock;
  wire [2:0]AXI_Slv1_buffer_arprot;
  wire [3:0]AXI_Slv1_buffer_arqos;
  wire AXI_Slv1_buffer_arready;
  wire [2:0]AXI_Slv1_buffer_arsize;
  wire AXI_Slv1_buffer_arvalid;
  wire [31:0]AXI_Slv1_buffer_awaddr;
  wire [1:0]AXI_Slv1_buffer_awburst;
  wire [3:0]AXI_Slv1_buffer_awcache;
  wire [7:0]AXI_Slv1_buffer_awlen;
  wire [0:0]AXI_Slv1_buffer_awlock;
  wire [2:0]AXI_Slv1_buffer_awprot;
  wire [3:0]AXI_Slv1_buffer_awqos;
  wire AXI_Slv1_buffer_awready;
  wire [2:0]AXI_Slv1_buffer_awsize;
  wire AXI_Slv1_buffer_awvalid;
  wire AXI_Slv1_buffer_bready;
  wire [1:0]AXI_Slv1_buffer_bresp;
  wire AXI_Slv1_buffer_bvalid;
  wire [31:0]AXI_Slv1_buffer_rdata;
  wire AXI_Slv1_buffer_rlast;
  wire AXI_Slv1_buffer_rready;
  wire [1:0]AXI_Slv1_buffer_rresp;
  wire AXI_Slv1_buffer_rvalid;
  wire [31:0]AXI_Slv1_buffer_wdata;
  wire AXI_Slv1_buffer_wlast;
  wire AXI_Slv1_buffer_wready;
  wire [3:0]AXI_Slv1_buffer_wstrb;
  wire AXI_Slv1_buffer_wvalid;
  wire [31:0]AXI_Slv2_buffer_araddr;
  wire [1:0]AXI_Slv2_buffer_arburst;
  wire [3:0]AXI_Slv2_buffer_arcache;
  wire [7:0]AXI_Slv2_buffer_arlen;
  wire [0:0]AXI_Slv2_buffer_arlock;
  wire [2:0]AXI_Slv2_buffer_arprot;
  wire [3:0]AXI_Slv2_buffer_arqos;
  wire AXI_Slv2_buffer_arready;
  wire [2:0]AXI_Slv2_buffer_arsize;
  wire AXI_Slv2_buffer_arvalid;
  wire [31:0]AXI_Slv2_buffer_awaddr;
  wire [1:0]AXI_Slv2_buffer_awburst;
  wire [3:0]AXI_Slv2_buffer_awcache;
  wire [7:0]AXI_Slv2_buffer_awlen;
  wire [0:0]AXI_Slv2_buffer_awlock;
  wire [2:0]AXI_Slv2_buffer_awprot;
  wire [3:0]AXI_Slv2_buffer_awqos;
  wire AXI_Slv2_buffer_awready;
  wire [2:0]AXI_Slv2_buffer_awsize;
  wire AXI_Slv2_buffer_awvalid;
  wire AXI_Slv2_buffer_bready;
  wire [1:0]AXI_Slv2_buffer_bresp;
  wire AXI_Slv2_buffer_bvalid;
  wire [31:0]AXI_Slv2_buffer_rdata;
  wire AXI_Slv2_buffer_rlast;
  wire AXI_Slv2_buffer_rready;
  wire [1:0]AXI_Slv2_buffer_rresp;
  wire AXI_Slv2_buffer_rvalid;
  wire [31:0]AXI_Slv2_buffer_wdata;
  wire AXI_Slv2_buffer_wlast;
  wire AXI_Slv2_buffer_wready;
  wire [3:0]AXI_Slv2_buffer_wstrb;
  wire AXI_Slv2_buffer_wvalid;
  wire [14:0]DDR3_0_addr;
  wire [2:0]DDR3_0_ba;
  wire DDR3_0_cas_n;
  wire [0:0]DDR3_0_ck_n;
  wire [0:0]DDR3_0_ck_p;
  wire [0:0]DDR3_0_cke;
  wire [0:0]DDR3_0_cs_n;
  wire [3:0]DDR3_0_dm;
  wire [31:0]DDR3_0_dq;
  wire [3:0]DDR3_0_dqs_n;
  wire [3:0]DDR3_0_dqs_p;
  wire [0:0]DDR3_0_odt;
  wire DDR3_0_ras_n;
  wire DDR3_0_reset_n;
  wire DDR3_0_we_n;
  wire DDR_Init;
  wire MIG_rst;
  wire MSI_en;
  wire [0:0]PCIe_data_rxn;
  wire [0:0]PCIe_data_rxp;
  wire [0:0]PCIe_data_txn;
  wire [0:0]PCIe_data_txp;
  wire Sys_Clk;
  wire Sys_Clk_150M;
  wire Sys_Clk_200M;
  wire Sys_rst;
  wire User_Lnk_up;
  wire [1:0]Usr_IRQ;
  wire pcie_rst;

  PCIe_DDR3_Block PCIe_DDR3_Block_i
       (.AXI_Slv1_buffer_araddr(AXI_Slv1_buffer_araddr),
        .AXI_Slv1_buffer_arburst(AXI_Slv1_buffer_arburst),
        .AXI_Slv1_buffer_arcache(AXI_Slv1_buffer_arcache),
        .AXI_Slv1_buffer_arlen(AXI_Slv1_buffer_arlen),
        .AXI_Slv1_buffer_arlock(AXI_Slv1_buffer_arlock),
        .AXI_Slv1_buffer_arprot(AXI_Slv1_buffer_arprot),
        .AXI_Slv1_buffer_arqos(AXI_Slv1_buffer_arqos),
        .AXI_Slv1_buffer_arready(AXI_Slv1_buffer_arready),
        .AXI_Slv1_buffer_arsize(AXI_Slv1_buffer_arsize),
        .AXI_Slv1_buffer_arvalid(AXI_Slv1_buffer_arvalid),
        .AXI_Slv1_buffer_awaddr(AXI_Slv1_buffer_awaddr),
        .AXI_Slv1_buffer_awburst(AXI_Slv1_buffer_awburst),
        .AXI_Slv1_buffer_awcache(AXI_Slv1_buffer_awcache),
        .AXI_Slv1_buffer_awlen(AXI_Slv1_buffer_awlen),
        .AXI_Slv1_buffer_awlock(AXI_Slv1_buffer_awlock),
        .AXI_Slv1_buffer_awprot(AXI_Slv1_buffer_awprot),
        .AXI_Slv1_buffer_awqos(AXI_Slv1_buffer_awqos),
        .AXI_Slv1_buffer_awready(AXI_Slv1_buffer_awready),
        .AXI_Slv1_buffer_awsize(AXI_Slv1_buffer_awsize),
        .AXI_Slv1_buffer_awvalid(AXI_Slv1_buffer_awvalid),
        .AXI_Slv1_buffer_bready(AXI_Slv1_buffer_bready),
        .AXI_Slv1_buffer_bresp(AXI_Slv1_buffer_bresp),
        .AXI_Slv1_buffer_bvalid(AXI_Slv1_buffer_bvalid),
        .AXI_Slv1_buffer_rdata(AXI_Slv1_buffer_rdata),
        .AXI_Slv1_buffer_rlast(AXI_Slv1_buffer_rlast),
        .AXI_Slv1_buffer_rready(AXI_Slv1_buffer_rready),
        .AXI_Slv1_buffer_rresp(AXI_Slv1_buffer_rresp),
        .AXI_Slv1_buffer_rvalid(AXI_Slv1_buffer_rvalid),
        .AXI_Slv1_buffer_wdata(AXI_Slv1_buffer_wdata),
        .AXI_Slv1_buffer_wlast(AXI_Slv1_buffer_wlast),
        .AXI_Slv1_buffer_wready(AXI_Slv1_buffer_wready),
        .AXI_Slv1_buffer_wstrb(AXI_Slv1_buffer_wstrb),
        .AXI_Slv1_buffer_wvalid(AXI_Slv1_buffer_wvalid),
        .AXI_Slv2_buffer_araddr(AXI_Slv2_buffer_araddr),
        .AXI_Slv2_buffer_arburst(AXI_Slv2_buffer_arburst),
        .AXI_Slv2_buffer_arcache(AXI_Slv2_buffer_arcache),
        .AXI_Slv2_buffer_arlen(AXI_Slv2_buffer_arlen),
        .AXI_Slv2_buffer_arlock(AXI_Slv2_buffer_arlock),
        .AXI_Slv2_buffer_arprot(AXI_Slv2_buffer_arprot),
        .AXI_Slv2_buffer_arqos(AXI_Slv2_buffer_arqos),
        .AXI_Slv2_buffer_arready(AXI_Slv2_buffer_arready),
        .AXI_Slv2_buffer_arsize(AXI_Slv2_buffer_arsize),
        .AXI_Slv2_buffer_arvalid(AXI_Slv2_buffer_arvalid),
        .AXI_Slv2_buffer_awaddr(AXI_Slv2_buffer_awaddr),
        .AXI_Slv2_buffer_awburst(AXI_Slv2_buffer_awburst),
        .AXI_Slv2_buffer_awcache(AXI_Slv2_buffer_awcache),
        .AXI_Slv2_buffer_awlen(AXI_Slv2_buffer_awlen),
        .AXI_Slv2_buffer_awlock(AXI_Slv2_buffer_awlock),
        .AXI_Slv2_buffer_awprot(AXI_Slv2_buffer_awprot),
        .AXI_Slv2_buffer_awqos(AXI_Slv2_buffer_awqos),
        .AXI_Slv2_buffer_awready(AXI_Slv2_buffer_awready),
        .AXI_Slv2_buffer_awsize(AXI_Slv2_buffer_awsize),
        .AXI_Slv2_buffer_awvalid(AXI_Slv2_buffer_awvalid),
        .AXI_Slv2_buffer_bready(AXI_Slv2_buffer_bready),
        .AXI_Slv2_buffer_bresp(AXI_Slv2_buffer_bresp),
        .AXI_Slv2_buffer_bvalid(AXI_Slv2_buffer_bvalid),
        .AXI_Slv2_buffer_rdata(AXI_Slv2_buffer_rdata),
        .AXI_Slv2_buffer_rlast(AXI_Slv2_buffer_rlast),
        .AXI_Slv2_buffer_rready(AXI_Slv2_buffer_rready),
        .AXI_Slv2_buffer_rresp(AXI_Slv2_buffer_rresp),
        .AXI_Slv2_buffer_rvalid(AXI_Slv2_buffer_rvalid),
        .AXI_Slv2_buffer_wdata(AXI_Slv2_buffer_wdata),
        .AXI_Slv2_buffer_wlast(AXI_Slv2_buffer_wlast),
        .AXI_Slv2_buffer_wready(AXI_Slv2_buffer_wready),
        .AXI_Slv2_buffer_wstrb(AXI_Slv2_buffer_wstrb),
        .AXI_Slv2_buffer_wvalid(AXI_Slv2_buffer_wvalid),
        .DDR3_0_addr(DDR3_0_addr),
        .DDR3_0_ba(DDR3_0_ba),
        .DDR3_0_cas_n(DDR3_0_cas_n),
        .DDR3_0_ck_n(DDR3_0_ck_n),
        .DDR3_0_ck_p(DDR3_0_ck_p),
        .DDR3_0_cke(DDR3_0_cke),
        .DDR3_0_cs_n(DDR3_0_cs_n),
        .DDR3_0_dm(DDR3_0_dm),
        .DDR3_0_dq(DDR3_0_dq),
        .DDR3_0_dqs_n(DDR3_0_dqs_n),
        .DDR3_0_dqs_p(DDR3_0_dqs_p),
        .DDR3_0_odt(DDR3_0_odt),
        .DDR3_0_ras_n(DDR3_0_ras_n),
        .DDR3_0_reset_n(DDR3_0_reset_n),
        .DDR3_0_we_n(DDR3_0_we_n),
        .DDR_Init(DDR_Init),
        .MIG_rst(MIG_rst),
        .MSI_en(MSI_en),
        .PCIe_data_rxn(PCIe_data_rxn),
        .PCIe_data_rxp(PCIe_data_rxp),
        .PCIe_data_txn(PCIe_data_txn),
        .PCIe_data_txp(PCIe_data_txp),
        .Sys_Clk(Sys_Clk),
        .Sys_Clk_150M(Sys_Clk_150M),
        .Sys_Clk_200M(Sys_Clk_200M),
        .Sys_rst(Sys_rst),
        .User_Lnk_up(User_Lnk_up),
        .Usr_IRQ(Usr_IRQ),
        .pcie_rst(pcie_rst));
endmodule
