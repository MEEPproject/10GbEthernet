

module Ethernet_top #(
    parameter qsfp_number = 0,
    parameter dma_addr_bits = 64,
    parameter dma_word_bits = 64

) (
    input wire async_resetn,

    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 working_clock CLK" *)
    input wire working_clock,
    input wire working_clock_ok,

    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gt_clock CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF M_AXI:S_AXI_LITE" *)
	output wire        gt_clock,

    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWADDR" *)
    (* X_INTERFACE_PARAMETER = "CLK_DOMAIN gt_clock, ID_WIDTH 0, PROTOCOL AXI4LITE, DATA_WIDTH 32" *)
    input wire [15:0] s_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWVALID" *)
    input wire s_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWREADY" *)
    output wire s_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WDATA" *)
    input wire [31:0] s_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WVALID" *)
    input wire s_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WREADY" *)
    output wire s_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE BRESP" *)
    output wire [1:0] s_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE BVALID" *)
    output wire s_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE BREADY" *)
    input wire s_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARADDR" *)
    input wire [15:0] s_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARVALID" *)
    input wire s_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARREADY" *)
    output wire s_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RDATA" *)
    output wire [31:0] s_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RRESP" *)
    output wire [1:0] s_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RVALID" *)
    output wire s_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RREADY" *)
    input wire s_axi_rready,

    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWADDR" *)
    (* X_INTERFACE_PARAMETER = "CLK_DOMAIN gt_clock, ID_WIDTH 0, PROTOCOL AXI4" *)
    output wire  [dma_addr_bits-1:0] m_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWLEN" *)
    output wire  [7:0] m_axi_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWVALID" *)
    output wire  m_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWREADY" *)
    input wire m_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WDATA" *)
    output wire [dma_word_bits-1:0] m_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WSTRB" *)
    output wire [dma_word_bits/8-1:0] m_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WLAST" *)
    output wire  m_axi_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WVALID" *)
    output wire  m_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WREADY" *)
    input wire m_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BRESP" *)
    input wire [1:0] m_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BVALID" *)
    input wire m_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BREADY" *)
    output wire m_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARADDR" *)
    output wire  [dma_addr_bits-1:0] m_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARLEN" *)
    output wire  [7:0] m_axi_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARVALID" *)
    output wire  m_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARREADY" *)
    input wire m_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RDATA" *)
    input wire [dma_word_bits-1:0] m_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RLAST" *)
    input wire m_axi_rlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RRESP" *)
    input wire [1:0] m_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RVALID" *)
    input wire m_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RREADY" *)
    output wire m_axi_rready,

    (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
    (* X_INTERFACE_PARAMETER = "SENSITIVITY LEVEL_HIGH" *)
    output wire interrupt,

	/* QSFP28 #1 */
    output wire       qsfp_tx1_p,
    output wire       qsfp_tx1_n,
    input  wire       qsfp_rx1_p,
    input  wire       qsfp_rx1_n,
    input  wire       qsfp_mgt_refclk_1_p,
    input  wire       qsfp_mgt_refclk_1_n,
    output wire       qsfp_refclk_oe_b,
    output wire       qsfp_refclk_fs

);



wire [63:0] rx_axis_tdata;
wire [7:0] rx_axis_tkeep;
wire rx_axis_tlast;
wire rx_axis_tready;
wire rx_axis_tuser;
wire rx_axis_tvalid;
wire [15:0] status;
wire [63:0] tx_axis_tdata;
wire [7:0] tx_axis_tkeep;
wire tx_axis_tlast;
wire tx_axis_tready;
wire tx_axis_tuser;
wire tx_axis_tvalid;




ethernet  #(.dma_addr_bits(dma_addr_bits),.dma_word_bits(dma_word_bits)) ethernet_i
	(.m_axi_araddr(m_axi_araddr),
	.m_axi_arlen(m_axi_arlen),
	.m_axi_arready(m_axi_arready),
	.m_axi_arvalid(m_axi_arvalid),
	.m_axi_awaddr(m_axi_awaddr),
	.m_axi_awlen(m_axi_awlen),
	.m_axi_awready(m_axi_awready),
	.m_axi_awvalid(m_axi_awvalid),
	.m_axi_bready(m_axi_bready),
	.m_axi_bresp(m_axi_bresp),
	.m_axi_bvalid(m_axi_bvalid),
	.m_axi_rdata(m_axi_rdata),
	.m_axi_rlast(m_axi_rlast),
	.m_axi_rready(m_axi_rready),
	.m_axi_rresp(m_axi_rresp),
	.m_axi_rvalid(m_axi_rvalid),
	.m_axi_wdata(m_axi_wdata),
	.m_axi_wlast(m_axi_wlast),
	.m_axi_wready(m_axi_wready),
	.m_axi_wstrb(m_axi_wstrb),
	.m_axi_wvalid(m_axi_wvalid),
	.rx_axis_tdata(rx_axis_tdata),
	.rx_axis_tkeep(rx_axis_tkeep),
	.rx_axis_tlast(rx_axis_tlast),
	.rx_axis_tready(rx_axis_tready),
	.rx_axis_tuser(rx_axis_tuser),
	.rx_axis_tvalid(rx_axis_tvalid),
	.s_axi_araddr(s_axi_araddr),
	.s_axi_arready(s_axi_arready),
	.s_axi_arvalid(s_axi_arvalid),
	.s_axi_awaddr(s_axi_awaddr),
	.s_axi_awready(s_axi_awready),
	.s_axi_awvalid(s_axi_awvalid),
	.s_axi_bready(s_axi_bready),
	.s_axi_bresp(s_axi_bresp),
	.s_axi_bvalid(s_axi_bvalid),
	.s_axi_rdata(s_axi_rdata),
	.s_axi_rready(s_axi_rready),
	.s_axi_rresp(s_axi_rresp),
	.s_axi_rvalid(s_axi_rvalid),
	.s_axi_wdata(s_axi_wdata),
	.s_axi_wready(s_axi_wready),
	.s_axi_wvalid(s_axi_wvalid),
	.tx_axis_tdata(tx_axis_tdata),
	.tx_axis_tkeep(tx_axis_tkeep),
	.tx_axis_tlast(tx_axis_tlast),
	.tx_axis_tready(tx_axis_tready),
	.tx_axis_tuser(tx_axis_tuser),
	.tx_axis_tvalid(tx_axis_tvalid),
	.async_resetn(async_resetn),
	.clock(gt_clock),
	.interrupt(interrupt),
	.mdio_clock(0),//unconnected
	.mdio_data(0),//unconnected
	.mdio_int(0),//unconnected
	.mdio_reset(0),//Output unconnected
	.reset(0),//we don't need to forward-out the reset
	.status_vector(status));





ethernet_alveo #(.qsfp_number(qsfp_number)) ethernet_u280_i1(
    .clock_ok(working_clock_ok),
    .clock(working_clock),

    .eth_gt_user_clock(gt_clock),

    /* Ethernet AXI Stream */
    .eth0_rx_axis_tdata(rx_axis_tdata),
    .eth0_rx_axis_tkeep(rx_axis_tkeep),
    .eth0_rx_axis_tlast(rx_axis_tlast),
    .eth0_rx_axis_tready(rx_axis_tready),
    .eth0_rx_axis_tuser(rx_axis_tuser),
    .eth0_rx_axis_tvalid(rx_axis_tvalid),
    .eth0_status(status),
    .eth0_tx_axis_tdata(tx_axis_tdata),
    .eth0_tx_axis_tkeep(tx_axis_tkeep),
    .eth0_tx_axis_tlast(tx_axis_tlast),
    .eth0_tx_axis_tready(tx_axis_tready),
    .eth0_tx_axis_tuser(tx_axis_tuser),
    .eth0_tx_axis_tvalid(tx_axis_tvalid),

    /* QSFP28 */
    .qsfp0_tx1_p(qsfp_tx1_p),
    .qsfp0_tx1_n(qsfp_tx1_n),
    .qsfp0_rx1_p(qsfp_rx1_p),
    .qsfp0_rx1_n(qsfp_rx1_n),
    .qsfp0_mgt_refclk_1_p(qsfp_mgt_refclk_1_p),
    .qsfp0_mgt_refclk_1_n(qsfp_mgt_refclk_1_n),
    .qsfp0_refclk_oe_b(qsfp_refclk_oe_b),
    .qsfp0_refclk_fs(qsfp_refclk_fs)
);

endmodule