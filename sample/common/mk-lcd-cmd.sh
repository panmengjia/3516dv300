#!/bin/bash
# init format
# "addr value1 value2 ..."
init=(
"FF 98 81 03"
"01 00"
"02 00"
"03 73"
"04 D7"
"05 00"
"06 08"
"07 11"
"08 00"
"09 3F"
"0a 00"
"0b 00"
"0c 00"
"0d 00"
"0e 00"
"0f 3F"
"10 3F"
"11 00"
"12 00"
"13 00"
"14 00"
"15 00"
"16 00"
"17 00"
"18 00"
"19 00"
"1a 00"
"1b 00"
"1c 00"
"1d 00"
"1e 40"
"1f 80"
"20 06"
"21 01"
"22 00"
"23 00"
"24 00"
"25 00"
"26 00"
"27 00"
"28 33"
"29 33"
"2a 00"
"2b 00"
"2c 00"
"2d 00"
"2e 00"
"2f 00"
"30 00"
"31 00"
"32 00"
"33 00"
"34 00"
"35 00"
"36 00"
"37 00"
"38 00"
"39 00"
"3a 00"
"3b 00"
"3c 00"
"3d 00"
"3e 00"
"3f 00"
"40 00"
"41 00"
"42 00"
"43 00"
"44 00"
"50 01"
"51 23"
"52 44"
"53 67"
"54 89"
"55 ab"
"56 01"
"57 23"
"58 45"
"59 67"
"5a 89"
"5b ab"
"5c cd"
"5d ef"
"5e 00"
"5f 0C"
"60 0C"
"61 0F"
"62 0F"
"63 0E"
"64 0E"
"65 06"
"66 07"
"67 0D"
"68 02"
"69 02"
"6a 02"
"6b 02"
"6c 02"
"6d 02"
"6e 0D"
"6f 02"
"70 02"
"71 05"
"72 01"
"73 08"
"74 00"
"75 0C"
"76 0C"
"77 0F"
"78 0F"
"79 0E"
"7a 0E"
"7b 06"
"7c 07"
"7d 0D"
"7e 02"
"7f 02"
"80 02"
"81 02"
"82 02"
"83 02"
"84 0D"
"85 02"
"86 02"
"87 05"
"88 01"
"89 08"
"8A 00"
"FF 98 81 04"
"6E 3B"
"6F 57"
"3A 24"
"8D 1F"
"87 BA"
"B2 D1"
"88 0B"
"38 01"
"39 00"
"B5 07"
"31 75"
"3B 98"
"FF 98 81 01"
"22 0A"
"31 09"
"35 07"
"53 7B"
"55 40"
"50 86"
"51 82"
"60 27"
"62 20"
"A0 00"
"A1 12"
"A2 20"
"A3 13"
"A4 14"
"A5 27"
"A6 1D"
"A7 1F"
"A8 7C"
"A9 1D"
"AA 2A"
"AB 6B"
"AC 1A"
"AD 18"
"AE 4E"
"AF 24"
"B0 2A"
"B1 4D"
"B2 5B"
"B3 23"
"C0 00"
"C1 13"
"C2 20"
"C3 12"
"C4 15"
"C5 28"
"C6 1C"
"C7 1E"
"C8 7B"
"C9 1E"
"CA 29"
"CB 6C"
"CC 1A"
"CD 19"
"CE 4D"
"CF 22"
"D0 2A"
"D1 4D"
"D2 5B"
"D3 23"
"FF 98 81 00"
"01 11"
"01 29"
)
echo   "HI_S32     fd     = s32fd;
    	HI_S32     s32Ret;
    	HI_U8      cmd[30];
    	cmd_info_t cmd_info = {0};" > rp-lcd.h

n_init=${#init[*]}							#获取一维init的数组长度
for ((i=0;i<$n_init;i++));
do
	inner_init=(${init[$i]})				#将一维init字符串赋值到数组
	n_inner_init=${#inner_init[*]}			#获取二维init的数组长度

	if [ $n_inner_init -gt 2 ]; then
		#echo "inner size : $n_inner_init"

		for ((j=0;j<$n_inner_init;j++));
  		do
			#echo ${inner_init[$j]}					# 显示测试
			echo "	cmd[$j] = 0x${inner_init[$j]};" >> rp-lcd.h
  		done
		#n_inner_init_10to16=$(echo "obase=16;${n_inner_init}"|bc)
		#n_inner_init_10to16=$(printf "%x" $n_inner_init)
		#n_inner_init_10to16=$(echo "obase=16;15"|bc)
		#echo "inner size : $n_inner_init"
		#echo "$n_inner_init_10to16"
		n_inner_init_10to16=$(printf "%x" $n_inner_init)
		echo "	cmd_info.devno     = 0;
	cmd_info.cmd_size  = ${n_inner_init_10to16}; 
	cmd_info.data_type = 0x29;
	cmd_info.cmd       = cmd;
	s32Ret = ioctl(fd, HI_MIPI_TX_SET_CMD, &cmd_info);
	if (HI_SUCCESS != s32Ret)
	{
	    SAMPLE_PRT(\"MIPI_TX SET CMD failed\\n\");
	    close(fd);
	    return;
	}
	usleep(1000);
		" >> rp-lcd.h
	elif [ $n_inner_init -eq 2 ]; then
		#echo "inner size : $n_inner_init"
		echo "	cmd_info.devno     = 0;
	cmd_info.cmd_size  = 0x${inner_init[1]}${inner_init[0]}; 
	cmd_info.data_type = 0x23;
	cmd_info.cmd       = NULL;
	s32Ret = ioctl(fd, HI_MIPI_TX_SET_CMD, &cmd_info);
	if (HI_SUCCESS != s32Ret)
	{
	    SAMPLE_PRT(\"MIPI_TX SET CMD failed\\n\");
	    close(fd);
	    return;
	}
	usleep(1000);
		" >> rp-lcd.h
	else
		echo "error size : $n_inner_init"
	fi
done

echo "	cmd_info.devno     = 0;
	cmd_info.cmd_size  = 0x0011; 
	cmd_info.data_type = 0x05;
	cmd_info.cmd       = NULL;
	s32Ret = ioctl(fd, HI_MIPI_TX_SET_CMD, &cmd_info);
	if (HI_SUCCESS != s32Ret)
	{
	    SAMPLE_PRT(\"MIPI_TX SET CMD failed\\n\");
	    close(fd);
	    return;
	}
	usleep(200000);
" >> rp-lcd.h
		
echo "	cmd_info.devno     = 0;
	cmd_info.cmd_size  = 0x0029; 
	cmd_info.data_type = 0x05;
	cmd_info.cmd       = NULL;
	s32Ret = ioctl(fd, HI_MIPI_TX_SET_CMD, &cmd_info);
	if (HI_SUCCESS != s32Ret)
	{
	    SAMPLE_PRT(\"MIPI_TX SET CMD failed\\n\");
	    close(fd);
	    return;
	}
	usleep(1000);
" >> rp-lcd.h
