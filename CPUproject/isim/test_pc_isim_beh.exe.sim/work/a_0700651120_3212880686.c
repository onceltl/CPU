/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Shine/Desktop/Git/CPU/CPUproject/JumpController.vhd";
extern char *WORK_P_0588050543;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_3620187407_sub_4042748798_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_767668596_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_0700651120_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    int t9;
    int t10;
    int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(29, ng0);
    t1 = (t0 + 4296);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(31, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t7 = (t6 == (unsigned char)3);
    if (t7 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(34, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t1 = ((WORK_P_0588050543) + 1288U);
    t3 = *((char **)t1);
    t9 = xsi_mem_cmp(t3, t2, 2U);
    if (t9 == 1)
        goto LAB6;

LAB10:    t1 = ((WORK_P_0588050543) + 1408U);
    t4 = *((char **)t1);
    t10 = xsi_mem_cmp(t4, t2, 2U);
    if (t10 == 1)
        goto LAB7;

LAB11:    t1 = ((WORK_P_0588050543) + 1528U);
    t5 = *((char **)t1);
    t11 = xsi_mem_cmp(t5, t2, 2U);
    if (t11 == 1)
        goto LAB8;

LAB12:
LAB9:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 4296);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB5:
LAB3:    t1 = (t0 + 4200);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(32, ng0);
    t1 = (t0 + 4296);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB3;

LAB6:    xsi_set_current_line(36, ng0);
    t1 = (t0 + 1992U);
    t8 = *((char **)t1);
    t1 = (t0 + 6732U);
    t12 = ((WORK_P_0588050543) + 6328U);
    t13 = *((char **)t12);
    t12 = ((WORK_P_0588050543) + 20520U);
    t6 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t8, t1, t13, t12);
    if (t6 != 0)
        goto LAB14;

LAB16:
LAB15:    goto LAB5;

LAB7:    xsi_set_current_line(40, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 6732U);
    t3 = ((WORK_P_0588050543) + 6328U);
    t4 = *((char **)t3);
    t3 = ((WORK_P_0588050543) + 20520U);
    t6 = ieee_p_3620187407_sub_4042748798_3965413181(IEEE_P_3620187407, t2, t1, t4, t3);
    if (t6 != 0)
        goto LAB17;

LAB19:
LAB18:    goto LAB5;

LAB8:    xsi_set_current_line(44, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t7 = (t6 == (unsigned char)2);
    if (t7 != 0)
        goto LAB20;

LAB22:
LAB21:    goto LAB5;

LAB13:;
LAB14:    xsi_set_current_line(37, ng0);
    t14 = (t0 + 4296);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t14);
    goto LAB15;

LAB17:    xsi_set_current_line(41, ng0);
    t5 = (t0 + 4296);
    t8 = (t5 + 56U);
    t12 = *((char **)t8);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t5);
    goto LAB18;

LAB20:    xsi_set_current_line(45, ng0);
    t1 = (t0 + 4296);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB21;

}

static void work_a_0700651120_3212880686_p_1(char *t0)
{
    char t9[16];
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    int t6;
    char *t7;
    int t8;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t1 = ((WORK_P_0588050543) + 1648U);
    t3 = *((char **)t1);
    t4 = xsi_mem_cmp(t3, t2, 2U);
    if (t4 == 1)
        goto LAB3;

LAB7:    t1 = ((WORK_P_0588050543) + 1768U);
    t5 = *((char **)t1);
    t6 = xsi_mem_cmp(t5, t2, 2U);
    if (t6 == 1)
        goto LAB4;

LAB8:    t1 = ((WORK_P_0588050543) + 1888U);
    t7 = *((char **)t1);
    t8 = xsi_mem_cmp(t7, t2, 2U);
    if (t8 == 1)
        goto LAB5;

LAB9:
LAB6:    xsi_set_current_line(65, ng0);
    t1 = ((WORK_P_0588050543) + 6328U);
    t2 = *((char **)t1);
    t1 = (t0 + 4360);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    t7 = (t5 + 56U);
    t10 = *((char **)t7);
    memcpy(t10, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t1 = (t0 + 4216);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 1832U);
    t10 = *((char **)t1);
    t1 = (t0 + 6716U);
    t11 = (t0 + 1672U);
    t12 = *((char **)t11);
    t11 = (t0 + 6700U);
    t13 = ieee_p_3620187407_sub_767668596_3965413181(IEEE_P_3620187407, t9, t10, t1, t12, t11);
    t14 = (t9 + 12U);
    t15 = *((unsigned int *)t14);
    t16 = (1U * t15);
    t17 = (16U != t16);
    if (t17 == 1)
        goto LAB11;

LAB12:    t18 = (t0 + 4360);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t13, 16U);
    xsi_driver_first_trans_fast_port(t18);
    goto LAB2;

LAB4:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 4360);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    t7 = (t5 + 56U);
    t10 = *((char **)t7);
    memcpy(t10, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB5:    xsi_set_current_line(63, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 4360);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    t7 = (t5 + 56U);
    t10 = *((char **)t7);
    memcpy(t10, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB10:;
LAB11:    xsi_size_not_matching(16U, t16, 0);
    goto LAB12;

}


extern void work_a_0700651120_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0700651120_3212880686_p_0,(void *)work_a_0700651120_3212880686_p_1};
	xsi_register_didat("work_a_0700651120_3212880686", "isim/test_pc_isim_beh.exe.sim/work/a_0700651120_3212880686.didat");
	xsi_register_executes(pe);
}
