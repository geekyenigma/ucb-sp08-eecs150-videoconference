////////////////////////////////////////////////////////////////////////////////
//   ____  ____  
//  /   /\/   /  
// /___/  \  /   
// \   \   \/    
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /___/   /\   
// \   \  /  \  
//  \___\/\___\ 
////////////////////////////////////////////////////////////////////////////////

#ifndef H_workM_s_d_r_a_m_control_H
#define H_workM_s_d_r_a_m_control_H

#ifdef _MSC_VER
#pragma warning(disable: 4355)
#endif

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif

class workM_s_d_r_a_m_control : public HSim__s5{
public: 
    workM_s_d_r_a_m_control(const char *instname);
    ~workM_s_d_r_a_m_control();
    void setDefparam();
    void constructObject();
    void moduleInstantiate(HSimConfigDecl *cfg);
    void connectSigs();
    void reset();
    virtual void archImplement();
    HSim__s2 *driver_us0;
    HSim__s2 *driver_us1;
    HSim__s2 *driver_us2;
    HSim__s2 *driver_us3;
    HSim__s2 *driver_us4;
    HSim__s2 *driver_us5;
    HSim__s2 *driver_us6;
    HSim__s2 *driver_us7;
    HSim__s2 *driver_us8;
    HSim__s2 *driver_us9;
    HSim__s2 *driver_us10;
    HSim__s2 *driver_us11;
    HSim__s1 us[27];
    HSim__s3 uv[1];
    HSimVlogParam up[24];
};

#endif
