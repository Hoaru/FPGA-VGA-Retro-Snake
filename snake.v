module snake(
	input			sys_clk,		//ϵͳʱ��
	input 			sys_rst_n,		//��λ�ź�
	input 	[3:0]	direct_x_w,
	input 			sta_en_w,
	//VGA�ӿ�
	output			vga_hs,			//��ͬ���ź�
	output			vga_vs,			//��ͬ���ź�
	output	[2:0]	vga_rgb			//��������ԭɫ���
	);
	
//wire define
wire			vga_clk_w;			//PLL��Ƶ�õ�25Mhzʱ��
wire			locked_w;			//PLL����ȶ��ź�
wire			rst_n_w;			//PLL�ڲ���λ�ź�
wire [2:0]		pixel_data_w;		//���ص�����
wire [9:0]		pixel_xpos_w;		//���ص������
wire [9:0] 		pixel_ypos_w;		//���ص�������

//**********************************************************
//**                    main code
//**********************************************************
assign rst_n_w = sys_rst_n && locked_w;
vga_pll u_vga_pll (
	.areset(~sys_rst_n),
	.inclk0(sys_clk),
	.c0(vga_clk_w),
	.locked(locked_w)
	);
	
	
vga_driver u_vga_driver(
	.vga_clk(vga_clk_w),		
	.sys_rst_n(rst_n_w),		
	.vga_hs(vga_hs),			
	.vga_vs(vga_vs),			
	.vga_rgb(vga_rgb),		
	.pixel_data(pixel_data_w),
	.pixel_xpos(pixel_xpos_w),
	.pixel_ypos(pixel_ypos_w)	
	);
	
vga_display	u_vga_display(
	.vga_clk(vga_clk_w),
	.sys_rst_n(rst_n_w),
	.sta_en(sta_en_w),
	.direct_x(direct_x_w),
	.pixel_xpos(pixel_xpos_w),
	.pixel_ypos(pixel_ypos_w),
	.pixel_data(pixel_data_w)
	);
	
endmodule
	