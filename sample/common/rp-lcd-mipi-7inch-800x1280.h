#ifndef __RP_LCD_MIPI_7INCH_800X1280_H__
#define __RP_LCD_MIPI_7INCH_800X1280_H__
#include "sample_comm.h"
#include "hi_mipi_tx.h"
/*============================= mipi 7 inch 800x1280 lcd config ====================================*/
combo_dev_cfg_t MIPI_TX_7INCH_800X1280_60_CONFIG =
{
    .devno = 0,
    .lane_id = {0, 1, 2, 3},
    .output_mode = OUTPUT_MODE_DSI_VIDEO,
    .output_format = OUT_FORMAT_RGB_24_BIT,
    .video_mode =  BURST_MODE,

    .sync_info = {
        .vid_pkt_size=800,
		.vid_hsa_pixels=4,
		.vid_hbp_pixels=40,
		.vid_hline_pixels=884,
		.vid_vsa_lines=2,
		.vid_vbp_lines=22,
		.vid_vfp_lines=16,
		.vid_active_lines=1320,
		.edpi_cmd_size=0,

    },

    .phy_data_rate=841,
	.pixel_clk=70013,
};

VO_SYNC_INFO_S MIPI_TX_7INCH_800X1280_60_SYNC_INFO = 
{
	.u16Hact=800,
	.u16Hbb=44,
	.u16Hfb=40,
	.u16Hpw=4,
	.u16Vact=1280,
	.u16Vbb=24,
	.u16Vfb=16,
	.u16Vpw=2,

};

VO_USER_INTFSYNC_INFO_S MIPI_TX_7INCH_800X1280_60_USER_INTFSYNC_INFO = 
{
	.stUserIntfSyncAttr = 
	{
		.stUserSyncPll	= 
		{
			.u32Fbdiv=70,
			.u32Frac=0x346DC,
			.u32Refdiv=2,
			.u32Postdiv1=4,
			.u32Postdiv2=3,
		},
	},

	.u32DevDiv			= 1,
	.u32PreDiv			= 1,
};

lcd_resoluton_t MIPI_TX_7INCH_800X1280_60_LCD_RESOLUTION = 
{
	.pu32W	= 800,
	.pu32H	= 1280,
	.pu32Frm= 60,

};


HI_VOID InitScreen_mipi_7inch_800x1280(HI_S32 s32fd)
{
	HI_S32     fd     = s32fd;
    HI_S32     s32Ret;
    cmd_info_t cmd_info = {0};
	
	cmd_info.devno = 0;
	cmd_info.cmd_size = 0x11;
	cmd_info.data_type    = 0x05;
	cmd_info.cmd          = NULL;
	s32Ret = ioctl(fd, HI_MIPI_TX_SET_CMD, &cmd_info);
	if (HI_SUCCESS != s32Ret)
	{
		SAMPLE_PRT("MIPI_TX_SET CMD failed\n");
		close(fd);
		return;
	}           
	usleep(120000);

	cmd_info.devno = 0;
	cmd_info.cmd_size = 0x29;
	cmd_info.data_type    = 0x05;
	cmd_info.cmd          = NULL;
	s32Ret = ioctl(fd, HI_MIPI_TX_SET_CMD, &cmd_info);
	if (HI_SUCCESS != s32Ret)
	{
		SAMPLE_PRT("MIPI_TX_SET CMD failed\n");
		close(fd);
		return;
	}
	usleep(120000);
    SAMPLE_PRT("%s,%d.\n",__FUNCTION__,__LINE__);
	usleep(1000);

}

#endif /* End of #ifndef __RP_LCD_MIPI_7INCH_800x1280_H__ */
