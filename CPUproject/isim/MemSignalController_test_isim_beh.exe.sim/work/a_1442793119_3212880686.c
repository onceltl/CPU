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
static const char *ng0 = "D:/XilinxWorkspace/CPUThinPad/CPU/CPUproject/MemSignalController.vhd";
extern char *WORK_P_0588050543;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_3620187407_sub_4058165771_3965413181(char *, char *, char *, char *, char *);
unsigned char ieee_p_3620187407_sub_4060537613_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_767740470_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_1442793119_3212880686_p_0(char *t0)
{
    char t10[16];
    char t18[16];
    char t28[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    unsigned char t9;
    char *t11;
    int t12;
    unsigned int t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    int t21;
    unsigned char t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    unsigned int t34;

LAB0:    xsi_set_current_line(24, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t1 = (t0 + 1968U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    memcpy(t1, t2, 16U);
    xsi_set_current_line(25, ng0);
    t1 = ((WORK_P_0588050543) + 4408U);
    t2 = *((char **)t1);
    t1 = (t0 + 3352);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(27, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t7 = *((unsigned char *)t2);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t7 = *((unsigned char *)t2);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB24;

LAB26:
LAB25:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 3416);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 3272);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(28, ng0);
    t1 = (t0 + 1968U);
    t3 = *((char **)t1);
    t1 = (t0 + 5548U);
    t4 = (t0 + 5606);
    t6 = (t10 + 0U);
    t11 = (t6 + 0U);
    *((int *)t11) = 0;
    t11 = (t6 + 4U);
    *((int *)t11) = 15;
    t11 = (t6 + 8U);
    *((int *)t11) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t11 = (t6 + 12U);
    *((unsigned int *)t11) = t13;
    t14 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t3, t1, t4, t10);
    if (t14 == 1)
        goto LAB8;

LAB9:    t9 = (unsigned char)0;

LAB10:    if (t9 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5638);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t8 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t8 == 1)
        goto LAB13;

LAB14:    t7 = (unsigned char)0;

LAB15:    if (t7 != 0)
        goto LAB11;

LAB12:    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5686);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t7 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t7 != 0)
        goto LAB19;

LAB20:
LAB6:    xsi_set_current_line(36, ng0);
    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5702);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t7 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t7 != 0)
        goto LAB21;

LAB23:
LAB22:    goto LAB3;

LAB5:    xsi_set_current_line(29, ng0);
    t20 = ((WORK_P_0588050543) + 4888U);
    t23 = *((char **)t20);
    t20 = (t0 + 3352);
    t24 = (t20 + 56U);
    t25 = *((char **)t24);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    memcpy(t27, t23, 4U);
    xsi_driver_first_trans_fast_port(t20);
    goto LAB6;

LAB8:    t11 = (t0 + 1968U);
    t15 = *((char **)t11);
    t11 = (t0 + 5548U);
    t16 = (t0 + 5622);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 0;
    t20 = (t19 + 4U);
    *((int *)t20) = 15;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (15 - 0);
    t13 = (t21 * 1);
    t13 = (t13 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t13;
    t22 = ieee_p_3620187407_sub_4058165771_3965413181(IEEE_P_3620187407, t15, t11, t16, t18);
    t9 = t22;
    goto LAB10;

LAB11:    xsi_set_current_line(31, ng0);
    t26 = ((WORK_P_0588050543) + 4648U);
    t27 = *((char **)t26);
    t26 = (t0 + 3352);
    t30 = (t26 + 56U);
    t31 = *((char **)t30);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memcpy(t33, t27, 4U);
    xsi_driver_first_trans_fast_port(t26);
    goto LAB6;

LAB13:    t6 = (t0 + 1968U);
    t11 = *((char **)t6);
    t6 = (t0 + 5548U);
    t15 = (t0 + 5654);
    t17 = (t18 + 0U);
    t19 = (t17 + 0U);
    *((int *)t19) = 0;
    t19 = (t17 + 4U);
    *((int *)t19) = 15;
    t19 = (t17 + 8U);
    *((int *)t19) = 1;
    t21 = (15 - 0);
    t13 = (t21 * 1);
    t13 = (t13 + 1);
    t19 = (t17 + 12U);
    *((unsigned int *)t19) = t13;
    t14 = ieee_p_3620187407_sub_4058165771_3965413181(IEEE_P_3620187407, t11, t6, t15, t18);
    if (t14 == 1)
        goto LAB16;

LAB17:    t19 = (t0 + 1968U);
    t20 = *((char **)t19);
    t19 = (t0 + 5548U);
    t23 = (t0 + 5670);
    t25 = (t28 + 0U);
    t26 = (t25 + 0U);
    *((int *)t26) = 0;
    t26 = (t25 + 4U);
    *((int *)t26) = 15;
    t26 = (t25 + 8U);
    *((int *)t26) = 1;
    t29 = (15 - 0);
    t13 = (t29 * 1);
    t13 = (t13 + 1);
    t26 = (t25 + 12U);
    *((unsigned int *)t26) = t13;
    t22 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t20, t19, t23, t28);
    t9 = t22;

LAB18:    t7 = t9;
    goto LAB15;

LAB16:    t9 = (unsigned char)1;
    goto LAB18;

LAB19:    xsi_set_current_line(33, ng0);
    t6 = ((WORK_P_0588050543) + 5248U);
    t11 = *((char **)t6);
    t6 = (t0 + 3352);
    t15 = (t6 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t19 = *((char **)t17);
    memcpy(t19, t11, 4U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB6;

LAB21:    xsi_set_current_line(37, ng0);
    t6 = (t0 + 1968U);
    t11 = *((char **)t6);
    t6 = (t0 + 5548U);
    t15 = (t0 + 5718);
    t17 = (t28 + 0U);
    t19 = (t17 + 0U);
    *((int *)t19) = 0;
    t19 = (t17 + 4U);
    *((int *)t19) = 15;
    t19 = (t17 + 8U);
    *((int *)t19) = 1;
    t21 = (15 - 0);
    t13 = (t21 * 1);
    t13 = (t13 + 1);
    t19 = (t17 + 12U);
    *((unsigned int *)t19) = t13;
    t19 = ieee_p_3620187407_sub_767740470_3965413181(IEEE_P_3620187407, t18, t11, t6, t15, t28);
    t20 = (t0 + 1968U);
    t23 = *((char **)t20);
    t20 = (t23 + 0);
    t24 = (t18 + 12U);
    t13 = *((unsigned int *)t24);
    t34 = (1U * t13);
    memcpy(t20, t19, t34);
    goto LAB22;

LAB24:    xsi_set_current_line(42, ng0);
    t1 = (t0 + 1968U);
    t3 = *((char **)t1);
    t1 = (t0 + 5548U);
    t4 = (t0 + 5734);
    t6 = (t10 + 0U);
    t11 = (t6 + 0U);
    *((int *)t11) = 0;
    t11 = (t6 + 4U);
    *((int *)t11) = 15;
    t11 = (t6 + 8U);
    *((int *)t11) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t11 = (t6 + 12U);
    *((unsigned int *)t11) = t13;
    t14 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t3, t1, t4, t10);
    if (t14 == 1)
        goto LAB30;

LAB31:    t9 = (unsigned char)0;

LAB32:    if (t9 != 0)
        goto LAB27;

LAB29:    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5766);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t8 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t8 == 1)
        goto LAB35;

LAB36:    t7 = (unsigned char)0;

LAB37:    if (t7 != 0)
        goto LAB33;

LAB34:    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5814);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t7 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t7 != 0)
        goto LAB41;

LAB42:    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5830);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t7 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t7 != 0)
        goto LAB43;

LAB44:
LAB28:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    t1 = (t0 + 5548U);
    t3 = (t0 + 5846);
    t5 = (t10 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 0;
    t6 = (t5 + 4U);
    *((int *)t6) = 15;
    t6 = (t5 + 8U);
    *((int *)t6) = 1;
    t12 = (15 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t13;
    t7 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t2, t1, t3, t10);
    if (t7 != 0)
        goto LAB45;

LAB47:
LAB46:    goto LAB25;

LAB27:    xsi_set_current_line(43, ng0);
    t20 = ((WORK_P_0588050543) + 4768U);
    t23 = *((char **)t20);
    t20 = (t0 + 3352);
    t24 = (t20 + 56U);
    t25 = *((char **)t24);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    memcpy(t27, t23, 4U);
    xsi_driver_first_trans_fast_port(t20);
    goto LAB28;

LAB30:    t11 = (t0 + 1968U);
    t15 = *((char **)t11);
    t11 = (t0 + 5548U);
    t16 = (t0 + 5750);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 0;
    t20 = (t19 + 4U);
    *((int *)t20) = 15;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (15 - 0);
    t13 = (t21 * 1);
    t13 = (t13 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t13;
    t22 = ieee_p_3620187407_sub_4058165771_3965413181(IEEE_P_3620187407, t15, t11, t16, t18);
    t9 = t22;
    goto LAB32;

LAB33:    xsi_set_current_line(45, ng0);
    t26 = ((WORK_P_0588050543) + 4528U);
    t27 = *((char **)t26);
    t26 = (t0 + 3352);
    t30 = (t26 + 56U);
    t31 = *((char **)t30);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memcpy(t33, t27, 4U);
    xsi_driver_first_trans_fast_port(t26);
    goto LAB28;

LAB35:    t6 = (t0 + 1968U);
    t11 = *((char **)t6);
    t6 = (t0 + 5548U);
    t15 = (t0 + 5782);
    t17 = (t18 + 0U);
    t19 = (t17 + 0U);
    *((int *)t19) = 0;
    t19 = (t17 + 4U);
    *((int *)t19) = 15;
    t19 = (t17 + 8U);
    *((int *)t19) = 1;
    t21 = (15 - 0);
    t13 = (t21 * 1);
    t13 = (t13 + 1);
    t19 = (t17 + 12U);
    *((unsigned int *)t19) = t13;
    t14 = ieee_p_3620187407_sub_4058165771_3965413181(IEEE_P_3620187407, t11, t6, t15, t18);
    if (t14 == 1)
        goto LAB38;

LAB39:    t19 = (t0 + 1968U);
    t20 = *((char **)t19);
    t19 = (t0 + 5548U);
    t23 = (t0 + 5798);
    t25 = (t28 + 0U);
    t26 = (t25 + 0U);
    *((int *)t26) = 0;
    t26 = (t25 + 4U);
    *((int *)t26) = 15;
    t26 = (t25 + 8U);
    *((int *)t26) = 1;
    t29 = (15 - 0);
    t13 = (t29 * 1);
    t13 = (t13 + 1);
    t26 = (t25 + 12U);
    *((unsigned int *)t26) = t13;
    t22 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t20, t19, t23, t28);
    t9 = t22;

LAB40:    t7 = t9;
    goto LAB37;

LAB38:    t9 = (unsigned char)1;
    goto LAB40;

LAB41:    xsi_set_current_line(47, ng0);
    t6 = ((WORK_P_0588050543) + 5128U);
    t11 = *((char **)t6);
    t6 = (t0 + 3352);
    t15 = (t6 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t19 = *((char **)t17);
    memcpy(t19, t11, 4U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB28;

LAB43:    xsi_set_current_line(49, ng0);
    t6 = ((WORK_P_0588050543) + 5008U);
    t11 = *((char **)t6);
    t6 = (t0 + 3352);
    t15 = (t6 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t19 = *((char **)t17);
    memcpy(t19, t11, 4U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB28;

LAB45:    xsi_set_current_line(53, ng0);
    t6 = (t0 + 1968U);
    t11 = *((char **)t6);
    t6 = (t0 + 5548U);
    t15 = (t0 + 5862);
    t17 = (t28 + 0U);
    t19 = (t17 + 0U);
    *((int *)t19) = 0;
    t19 = (t17 + 4U);
    *((int *)t19) = 15;
    t19 = (t17 + 8U);
    *((int *)t19) = 1;
    t21 = (15 - 0);
    t13 = (t21 * 1);
    t13 = (t13 + 1);
    t19 = (t17 + 12U);
    *((unsigned int *)t19) = t13;
    t19 = ieee_p_3620187407_sub_767740470_3965413181(IEEE_P_3620187407, t18, t11, t6, t15, t28);
    t20 = (t0 + 1968U);
    t23 = *((char **)t20);
    t20 = (t23 + 0);
    t24 = (t18 + 12U);
    t13 = *((unsigned int *)t24);
    t34 = (1U * t13);
    memcpy(t20, t19, t34);
    goto LAB46;

}


extern void work_a_1442793119_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1442793119_3212880686_p_0};
	xsi_register_didat("work_a_1442793119_3212880686", "isim/MemSignalController_test_isim_beh.exe.sim/work/a_1442793119_3212880686.didat");
	xsi_register_executes(pe);
}
