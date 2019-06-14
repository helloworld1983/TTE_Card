`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// Engineer: LKAYA
// 
// Create Date: 2019/06/13 11:03:17
// Design Name: 
// Module Name: axi_interface
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


module axi_interface(
/*-------------------AXI接口-----------------------*/
    input               ARESETn_in,
    input               ACLK_in,
    // AXI读地址
    output  [31:0]      AXI_araddr_o32,
    output  [1:0]       AXI_arburst_o2,
    output  [3:0]       AXI_arcache_o4,
    output  [7:0]       AXI_arlen_o8,
    output  [0:0]       AXI_arlock_o1,
    output  [2:0]       AXI_arprot_o3,
    output  [3:0]       AXI_arqos_o4,
    input               AXI_arready_i,
    output  [2:0]       AXI_arsize_o3,
    output              AXI_arvalid_o,
    // AXI写地址
    output  [31:0]      AXI_awaddr_o32,
    output  [1:0]       AXI_awburst_o2,
    output  [3:0]       AXI_awcache_o4,
    output  [7:0]       AXI_awlen_o8,
    output  [0:0]       AXI_awlock_o1,
    output  [2:0]       AXI_awprot_o3,
    output  [3:0]       AXI_awqos_o4,
    input               AXI_awready_i,
    output  [2:0]       AXI_awsize_o3,
    output              AXI_awvalid_o,
    // AXI写响应
    output              AXI_bready_o,
    input   [1:0]       AXI_bresp_i2,
    input               AXI_bvalid_i,
    // AXI读数据
    input   [31:0]      AXI_rdata_i32,
    input               AXI_rlast_i,
    output              AXI_rready_o,
    input   [1:0]       AXI_rresp_i2,
    input               AXI_rvalid_i,
    // AXI写数据
    output  [31:0]      AXI_wdata_o32,
    output              AXI_wlast_o,
    input               AXI_wready_i,
    output  [3:0]       AXI_wstrb_o4,
    output              AXI_wvalid_o,
/*-------------------外部接口-----------------------*/
    input               EXT_WR_start_i,
    input   [31:0]      EXT_WR_addr_i32,
    input   [31:0]      EXT_WR_len_i32, 
    input   [31:0]      EXT_WR_data_i32,
	output				EXT_WR_done_o,

    input               EXT_RD_start_i,
    input   [31:0]      EXT_RD_addr_i32,
    input   [31:0]      EXT_RD_len_i32, 
    output  [31:0]      EXT_RD_data_o32,
	output				EXT_RD_done_o
);

/*-----------------------AXI写状态机------------------------*/
    // 定义状态
    localparam WR_IDLE  = 3'd0;
    localparam WA_WAIT  = 3'd1;
    localparam WA_START = 3'd2;
    localparam WD_WAIT  = 3'd3;
    localparam WD_PROC  = 3'd4;
    localparam WR_WAIT  = 3'd5;
    localparam WR_DONE  = 3'd6;
    // 寄存器
    reg [2:0]   wr_state;
    reg [31:0]  reg_wr_adrs_32;
    reg [31:0]  reg_wr_len_32;
    reg         reg_awvalid, reg_wvalid, reg_w_last;
    reg [7:0]   reg_w_len_8;
    reg [7:0]   reg_w_stb_8;
    reg [1:0]   reg_wr_status_2;
    reg [3:0]   reg_w_count_4, reg_r_count_4;

    assign  AXI_awaddr_o32  [31:0]  =   reg_wr_adrs_32[31:0];
    assign  AXI_awlen_o8    [7:0]   =   reg_w_len_8[7:0];
    assign  AXI_awsize_o3   [2:0]   =   3'b011;
    assign  AXI_awburst_o2  [1:0]   =   2'b01;
    assign  AXI_awlock_o1           =   1'b0;
    assign  AXI_awcache_o4  [3:0]   =   4'b0011;
    assign  AXI_awprot_o3   [2:0]   =   3'b000;
    assign  AXI_awqos_o4    [3:0]   =   4'b0000;
    assign  AXI_awvalid_o           =   reg_awvalid;
    assign  AXI_wdata_o32   [31:0]  =   EXT_WR_data_i32;
    assign  AXI_wstrb_o4    [3:0]   =   reg_wvalid?8'hFF:8'h00;
    assign  AXI_wlast_o             =   (reg_w_len_8[7:0] == 8'd0)?1'b1:1'b0;
    assign  AXI_wvalid_o            =   reg_wvalid;
    assign  AXI_bready_o            =   AXI_bvalid_i;
	assign	EXT_WR_done_o			=	(wr_state == WR_DONE);

    always @(posedge ACLK_in or negedge ARESETn_in) begin
        if (!ARESETn_in) begin
            wr_state        <=  WR_IDLE;
            reg_wr_adrs_32  [31:0]  <=  32'd0;
            reg_wr_len_32   [31:0]  <=  32'd0;
            reg_awvalid             <=  1'b0;
            reg_wvalid              <=  1'b0;
            reg_w_last              <=  1'b0;
            reg_w_len_8     [7:0]   <=  8'd0;
            reg_w_stb_8     [7:0]   <=  8'd0;
            reg_wr_status_2 [1:0]   <=  2'd0;
            reg_w_count_4   [3:0]   <=  4'd0;
            reg_r_count_4   [3:0]   <=  4'd0;
        end
        else begin
            case(wr_state)
                WR_IDLE:    begin
                    if(EXT_WR_start_i)  begin
                        wr_state                <=  WA_WAIT;
                        reg_wr_adrs_32  [31:0]  <=  EXT_WR_addr_i32;
                        reg_wr_len_32   [31:0]  <=  EXT_WR_len_i32-32'd1;
                    end
                    reg_awvalid             <=  1'b0;
                    reg_wvalid              <=  1'b0;
                    reg_w_last              <=  1'b0;
                    reg_w_len_8     [7:0]   <=  8'd0;
                    reg_w_stb_8     [7:0]   <=  8'd0;
                    reg_wr_status_2 [1:0]   <=  2'd0;
                end
                WA_WAIT:    begin
                    wr_state    <=  WA_START;
                end
                WA_START:   begin
                    wr_state    <=  WD_WAIT;
                    reg_awvalid <=  1'b1;
                    if(reg_wr_len_32[31:11] != 21'd0) begin
                        reg_w_len_8 [7:0]   <= 8'hFF;
                        reg_w_last          <= 1'b0;
                        reg_w_stb_8 [7:0]   <= 8'hFF;
                    end
                    else    begin
                        reg_w_len_8 [7:0]   <= reg_wr_len[10:3];
                        reg_w_last          <= 1'b1;
                        reg_w_stb_8 [7:0]   <= 8'hFF;
                    end
                end
                WD_WAIT:    begin
                    if(AXI_awready_i)   begin
                        wr_state            <=  WD_PROC;
                        reg_awvalid         <=  1'b0;
                        reg_wvalid          <= 1'b1;
                    end
                end
                WD_PROC:    begin
                    if(AXI_wready_i)    begin
                        if (reg_w_len_8 [7:0] == 8'd0 ) begin
                            wr_state            <=  WR_WAIT;
                            reg_wvalid          <= 1'b0;
                            reg_w_stb_8 [7:0]   <= 8'h00;
                        end
                        else    begin
                            reg_w_len_8 [7:0]   <= reg_w_len_8[7:0] - 8'd1;
                        end
                    end
                end
                WR_WAIT:    begin
                    if(AXI_bvalid_i)   begin
                        reg_wr_status_2[1:0]  <= reg_wr_status_2[1:0] | AXI_bresp_i2[1:0];
                        if(reg_w_last) begin
                            wr_state            <=  WR_DONE;
                        end
                        else    begin
                            wr_state            <= S_WA_WAIT;
					        reg_wr_adrs_32[31:0] <= reg_wr_adrs_32[31:0] + 32'd2048;
                        end
                    end
                end
                WR_DONE:    begin
                    wr_state <= S_WR_IDLE;
                end
                default:    begin
                    wr_state <= S_WR_IDLE;
                end
            endcase
        end
    end
/*-----------------------AXI读状态机------------------------*/
    // 定义状态
    localparam RD_IDLE  = 3'd0;
    localparam RA_WAIT  = 3'd1;
    localparam RA_START = 3'd2;
    localparam RD_WAIT  = 3'd3;
    localparam RD_PROC  = 3'd4;
    localparam RD_DONE  = 3'd5;
    // 寄存器
    reg [2:0]   rd_state;
    reg [31:0]  reg_rd_adrs_32;
    reg [31:0]  reg_rd_len_32;
    reg         reg_arvalid, reg_r_last;
    reg [7:0]   reg_r_len_8;

	assign	AXI_araddr_o32	[31:0]	= reg_rd_adrs_32[31:0];
	assign	AXI_arlen_o8	[7:0]	= reg_r_len_8[7:0];
	assign	AXI_arsize_o3	[2:0]	= 3'b011;
	assign	AXI_arburst_o2	[1:0]	= 2'b01;
	assign	AXI_arlock_o1	[0:0]	= 1'b0;
	assign	AXI_arcache_o4	[3:0]	= 4'b0011;
	assign	AXI_arprot_o3	[2:0]	= 3'b000;
	assign	AXI_arqos_o4	[3:0]	= 4'b0000;
	assign	AXI_arvalid_o			= reg_arvalid;
	assign	AXI_rready_o			= AXI_rvalid_i;
	assign	EXT_RD_done_o			= (rd_state == RD_DONE);

    always @(posedge ACLK_in or negedge ARESETn_in) begin
        if(!ARESETn_in) begin
            rd_state                <= S_RD_IDLE;
            reg_rd_adrs_32  [31:0]  <= 32'd0;
            reg_rd_len_32   [31:0]  <= 32'd0;
            reg_arvalid             <= 1'b0;
            reg_r_len_8     [7:0]   <= 8'd0;
        end
        else    begin
            case(rd_state)
                RD_IDLE:    begin
                    if(EXT_RD_start_i)  begin
                        rd_state                <= RA_WAIT;
                        reg_rd_adrs_32  [31:0]  <= EXT_RD_addr_i32[31:0];
                        reg_rd_len_32   [31:0]  <= EXT_RD_len_i32[31:0] -32'd1;
                    end
                    reg_arvalid             <= 1'b0;
                    reg_r_len_8     [7:0]   <= 8'd0;
                end
                RA_WAIT:    begin
                    rd_state				<=	RA_START;
                end
                RA_START:   begin
                    rd_state				<=	RD_WAIT;
					reg_arvalid       		<= 1'b1;
					reg_rd_len_32[31:11] 	<= reg_rd_len_32[31:11] -21'd1;
					if(reg_rd_len_32[31:11] != 21'd0)	begin
						reg_r_last      	<= 1'b0;
						reg_r_len_8[7:0]  	<= 8'd255;
					end
					else	begin
						reg_r_last      	<= 1'b1;
						reg_r_len_8[7:0]  	<= reg_rd_len_32[10:3];
					end
                end
                RD_WAIT:    begin
                    if(AXI_arready_i)	begin
						rd_state			<=	RD_WAIT;
						reg_arvalid     	<= 1'b0;
					end
                end
                RD_PROC:    begin
                    if(AXI_rvalid_i)	begin
						if(AXI_rlast_i)	begin
							if(reg_r_last)	begin
								rd_state	<=	RD_DONE;
							end
							else	 begin
								rd_state    <= RA_WAIT;
								reg_rd_adrs_32[31:0] <= reg_rd_adrs_32[31:0] + 32'd2048;
							end
						end
						else	begin
							reg_r_len_8[7:0]<= reg_r_len_8[7:0] -8'd1;
						end
					end
                end
                RD_DONE:    begin
                    rd_state          		<= RD_IDLE;
                end
                default:    begin
                    rd_state    			<=  RD_IDLE;
                end
            endcase
        end
    end

endmodule
