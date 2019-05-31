`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 15:30:47
// Design Name: 
// Module Name: ETH_Top
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


module ETH_Top(
    //---------------------aq_axi_master----------------------
    // Reset, Clock
    input           RST_n,
    input           UI_clk,
    // Master Write Address
    output  [0:0]   M_AXI_AWID,
    output  [31:0]  M_AXI_AWADDR,
    output  [7:0]   M_AXI_AWLEN,    // Burst Length: 0-255
    output  [2:0]   M_AXI_AWSIZE,   // Burst Size: Fixed 2'b011
    output  [1:0]   M_AXI_AWBURST,  // Burst Type: Fixed 2'b01(Incremental Burst)
    output          M_AXI_AWLOCK,   // Lock: Fixed 2'b00
    output  [3:0]   M_AXI_AWCACHE,  // Cache: Fiex 2'b0011
    output  [2:0]   M_AXI_AWPROT,   // Protect: Fixed 2'b000
    output  [3:0]   M_AXI_AWQOS,    // QoS: Fixed 2'b0000
    output  [0:0]   M_AXI_AWUSER,   // User: Fixed 32'd0
    output          M_AXI_AWVALID,
    input           M_AXI_AWREADY,
    // Master Write Data
    output  [63:0]  M_AXI_WDATA,
    output  [7:0]   M_AXI_WSTRB,
    output          M_AXI_WLAST,
    output  [0:0]   M_AXI_WUSER,
    output          M_AXI_WVALID,
    input           M_AXI_WREADY,
    // Master Write Response
    input   [0:0]   M_AXI_BID,
    input   [1:0]   M_AXI_BRESP,
    input   [0:0]   M_AXI_BUSER,
    input           M_AXI_BVALID,
    output          M_AXI_BREADY,
    // Master Read Address
    output [0:0]  M_AXI_ARID,
    output [31:0] M_AXI_ARADDR,
    output [7:0]  M_AXI_ARLEN,
    output [2:0]  M_AXI_ARSIZE,
    output [1:0]  M_AXI_ARBURST,
    output [1:0]  M_AXI_ARLOCK,
    output [3:0]  M_AXI_ARCACHE,
    output [2:0]  M_AXI_ARPROT,
    output [3:0]  M_AXI_ARQOS,
    output [0:0]  M_AXI_ARUSER,
    output        M_AXI_ARVALID,
    input         M_AXI_ARREADY,
    // Master Read Data 
    input [0:0]   M_AXI_RID,
    input [63:0]  M_AXI_RDATA,
    input [1:0]   M_AXI_RRESP,
    input         M_AXI_RLAST,
    input [0:0]   M_AXI_RUSER,
    input         M_AXI_RVALID,
    output        M_AXI_RREADY,
    
    //gmii to rgmii
    input           rgmii_rxc,//add
    output  [ 3:0]  rgmii_td,
    output          rgmii_tx_ctl,
    output          rgmii_txc,
    input   [ 3:0]  rgmii_rd,
    input           rgmii_rx_ctl,
    
    // miim
    output        ETH_MDC_o,
    inout         ETH_MDIO_io
    
    
    );

    ///////////////////////wire and reg//////////////////////
    //--------------------flash read write------------------
    parameter MEM_DATA_BITS            = 64;
	parameter READ_DATA_BITS           = 32;
	parameter WRITE_DATA_BITS          = 32;
	parameter ADDR_BITS                = 24;
	parameter BUSRT_BITS               = 10;
	parameter BURST_SIZE               = 256;
	
    wire                                rd_burst_req;
    wire    [BUSRT_BITS - 1:0]          rd_burst_len;
    wire    [ADDR_BITS - 1:0]           rd_burst_addr;
    wire                                rd_burst_data_valid;
    wire    [MEM_DATA_BITS - 1:0]       rd_burst_data;
    wire                                rd_burst_finish;
    wire                                wr_burst_req;
    wire    [ADDR_BITS - 1:0]           wr_burst_addr;
    wire    [BUSRT_BITS - 1:0]          wr_burst_len;
    wire                                wr_burst_data_req;
    wire    [MEM_DATA_BITS - 1:0]       wr_burst_data;
    wire                                wr_burst_finish;
    
    wire    [READ_DATA_BITS  - 1:0]     read_data;
    wire                                read_en;
    wire    [15:0]                      read_usedw;
    wire                                read_req_ack;
    wire                                read_req;
    wire                                write_req;
    wire                                write_req_ack;
    wire                                write_en;
    wire    [WRITE_DATA_BITS - 1:0]     write_data;

    wire    [31:0]                      sample_len;
    wire                                gmii_tx_clk;
    wire                                gmii_rx_clk;
    wire    [7:0]                       gmii_rxd;
    wire                                gmii_tx_en;
    wire    [7:0]                       gmii_txd;

    wire                                gmii_crs;
    wire                                gmii_col;
    wire                                gmii_rx_dv;
    wire                                gmii_rx_er;
    wire    [1:0]                       speed_selection;
    wire                                duplex_mode;

    aq_axi_master eth_axi_master
	(
	  .ARESETN                     (RST_n               ),
	  .ACLK                        (UI_clk              ),
	  
      .M_AXI_AWID                  (M_AXI_AWID          ),
	  .M_AXI_AWADDR                (M_AXI_AWADDR        ),
	  .M_AXI_AWLEN                 (M_AXI_AWLEN         ),
	  .M_AXI_AWSIZE                (M_AXI_AWSIZE        ),
	  .M_AXI_AWBURST               (M_AXI_AWBURST       ),
	  .M_AXI_AWLOCK                (M_AXI_AWLOCK        ),
	  .M_AXI_AWCACHE               (M_AXI_AWCACHE       ),
	  .M_AXI_AWPROT                (M_AXI_AWPROT        ),
	  .M_AXI_AWQOS                 (M_AXI_AWQOS         ),
	  .M_AXI_AWUSER                (M_AXI_AWUSER        ),
	  .M_AXI_AWVALID               (M_AXI_AWVALID       ),
	  .M_AXI_AWREADY               (M_AXI_AWREADY       ),
	  
      .M_AXI_WDATA                 (M_AXI_WDATA         ),
	  .M_AXI_WSTRB                 (M_AXI_WSTRB         ),
	  .M_AXI_WLAST                 (M_AXI_WLAST         ),
	  .M_AXI_WUSER                 (M_AXI_WUSER         ),
	  .M_AXI_WVALID                (M_AXI_WVALID        ),
	  .M_AXI_WREADY                (M_AXI_WREADY        ),
	  
      .M_AXI_BID                   (M_AXI_BID           ),
	  .M_AXI_BRESP                 (M_AXI_BRESP         ),
	  .M_AXI_BUSER                 (M_AXI_BUSER         ),
	  .M_AXI_BVALID                (M_AXI_BVALID        ),
	  .M_AXI_BREADY                (M_AXI_BREADY        ),
	  
      .M_AXI_ARID                  (M_AXI_ARID          ),
	  .M_AXI_ARADDR                (M_AXI_ARADDR        ),
	  .M_AXI_ARLEN                 (M_AXI_ARLEN         ),
	  .M_AXI_ARSIZE                (M_AXI_ARSIZE        ),
	  .M_AXI_ARBURST               (M_AXI_ARBURST       ),
	  .M_AXI_ARLOCK                (M_AXI_ARLOCK        ),
	  .M_AXI_ARCACHE               (M_AXI_ARCACHE       ),
	  .M_AXI_ARPROT                (M_AXI_ARPROT        ),
	  .M_AXI_ARQOS                 (M_AXI_ARQOS         ),
	  .M_AXI_ARUSER                (M_AXI_ARUSER        ),
	  .M_AXI_ARVALID               (M_AXI_ARVALID       ),
	  .M_AXI_ARREADY               (M_AXI_ARREADY       ),
	  
      .M_AXI_RID                   (M_AXI_RID           ),
	  .M_AXI_RDATA                 (M_AXI_RDATA         ),
	  .M_AXI_RRESP                 (M_AXI_RRESP         ),
	  .M_AXI_RLAST                 (M_AXI_RLAST         ),
	  .M_AXI_RUSER                 (M_AXI_RUSER         ),
	  .M_AXI_RVALID                (M_AXI_RVALID        ),
	  .M_AXI_RREADY                (M_AXI_RREADY        ),
	  
	  .MASTER_RST                  (1'b0                ),
	  
      .WR_START                    (wr_burst_req        ),
	  .WR_ADRS                     ({wr_burst_addr,3'd0}),
	  .WR_LEN                      ({wr_burst_len,3'd0} ),
	  .WR_READY                    (                    ),
	  .WR_FIFO_RE                  (wr_burst_data_req   ),
	  .WR_FIFO_EMPTY               (1'b0                ),
	  .WR_FIFO_AEMPTY              (1'b0                ),
	  .WR_FIFO_DATA                (wr_burst_data       ),
	  .WR_DONE                     (wr_burst_finish     ),
	  .RD_START                    (rd_burst_req        ),
	  .RD_ADRS                     ({rd_burst_addr,3'd0}),
	  .RD_LEN                      ({rd_burst_len,3'd0} ),
	  .RD_READY                    (                    ),
	  .RD_FIFO_WE                  (rd_burst_data_valid ),
	  .RD_FIFO_FULL                (1'b0                ),
	  .RD_FIFO_AFULL               (1'b0                ),
	  .RD_FIFO_DATA                (rd_burst_data       ),
	  .RD_DONE                     (rd_burst_finish     ),
	  .DEBUG                       (                    )
    );
    
    frame_read_write 
    #
    (
       .MEM_DATA_BITS              (MEM_DATA_BITS       ),
	   .READ_DATA_BITS             (READ_DATA_BITS      ),
	   .WRITE_DATA_BITS            (WRITE_DATA_BITS     ),
	   .ADDR_BITS                  (ADDR_BITS           ),
	   .BUSRT_BITS                 (BUSRT_BITS          ),
	   .BURST_SIZE                 (BURST_SIZE          )
    )
    frame_read_write_m0
    (
        .rst                        (RST_n              ),
        .mem_clk                    (UI_clk             ),
        
        .rd_burst_req               (rd_burst_req       ),
        .rd_burst_len               (rd_burst_len       ),
        .rd_burst_addr              (rd_burst_addr      ),
        .rd_burst_data_valid        (rd_burst_data_valid),
        .rd_burst_data              (rd_burst_data      ),
        .rd_burst_finish            (rd_burst_finish    ),
        .read_clk                   (gmii_tx_clk        ),
        .read_req                   (read_req           ),
        .read_req_ack               (read_req_ack       ),
        .read_finish                (                   ),
        .read_addr_0                (24'd0              ), //The first frame address is 0
        .read_addr_1                (24'd2073600        ), //The second frame address is 24'd2073600 ,large enough address space for one frame of video
        .read_addr_2                (24'd4147200        ),
        .read_addr_3                (24'd6220800        ),
        .read_addr_index            (2'd0               ),
        .read_len                   (sample_len/4       ),//frame size 
        .read_en                    (read_en            ),
        .read_data                  (read_data          ),
        .read_usedw                 (read_usedw         ),
        
        .wr_burst_req               (wr_burst_req       ),
        .wr_burst_len               (wr_burst_len       ),
        .wr_burst_addr              (wr_burst_addr      ),
        .wr_burst_data_req          (wr_burst_data_req  ),
        .wr_burst_data              (wr_burst_data      ),
        .wr_burst_finish            (wr_burst_finish    ),
        .write_clk                  (            ),
        .write_req                  (write_req          ),
        .write_req_ack              (write_req_ack      ),
        .write_finish               (                   ),
        .write_addr_0               (24'd0              ),
        .write_addr_1               (24'd2073600        ),
        .write_addr_2               (24'd4147200        ),
        .write_addr_3               (24'd6220800        ),
        .write_addr_index           (2'd0               ),
        .write_len                  (sample_len/4       ), //frame size  
        .write_en                   (write_en           ),
        .write_data                 (write_data         )
    );
    eth_top eth_top_inst
    (
        .rst_n                   (RST_n           ),    
        
        .fifo_data               (read_data       ),           //FIFO读出�??8bit数据/
        .fifo_data_count         (read_usedw      ),          //FIFO中的数据数量
        .fifo_rd_en              (read_en         ),             //FIFO读使�??
        
        .read_req_ack            (read_req_ack    ),
        .read_req                (read_req        ),
        .ad_sample_req           (   ),
        .ad_sample_ack           (   ),
        .sample_len              (sample_len      ),
        .gmii_tx_clk             (gmii_tx_clk     ),
        .gmii_rx_clk             (gmii_rx_clk     ) ,
        .gmii_rx_dv              (gmii_rx_dv      ),
        .gmii_rxd                (gmii_rxd        ),
        .gmii_tx_en              (gmii_tx_en      ),
        .gmii_txd                (gmii_txd        )
    
    );

    util_gmii_to_rgmii util_gmii_to_rgmii_m
    (
        .reset                    (1'b0),
        .rgmii_td                 (rgmii_td),
        .rgmii_tx_ctl             (rgmii_tx_ctl),
        .rgmii_txc                (rgmii_txc),
        .rgmii_rd                 (rgmii_rd),
        .rgmii_rx_ctl             (rgmii_rx_ctl),
        .gmii_rx_clk              (gmii_rx_clk),
        .gmii_txd                 (gmii_txd),
        .gmii_tx_en               (gmii_tx_en),
        .gmii_tx_er               (1'b0),
        .gmii_tx_clk              (gmii_tx_clk),
        .gmii_crs                 (gmii_crs),
        .gmii_col                 (gmii_col),
        .gmii_rxd                 (gmii_rxd),
        .rgmii_rxc                (rgmii_rxc),//add
        .gmii_rx_dv               (gmii_rx_dv),
        .gmii_rx_er               (gmii_rx_er),
        .speed_selection          (speed_selection),
        .duplex_mode              (duplex_mode)
    );

    miim_top miim_top_m0
    (
        .reset_i                  (1'b0),
        .miim_clock_i             (gmii_tx_clk),
        .mdc_o                    (ETH_MDC_o),
        .mdio_io                  (ETH_MDIO_io),
        .link_up_o                (),                  //link status
        .speed_o                  (),                  //link speed
        .speed_override_i         (2'b11)              //11: autonegoation
    ); 
endmodule
