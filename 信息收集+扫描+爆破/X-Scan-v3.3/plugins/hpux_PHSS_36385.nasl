
#
# (C) Tenable Network Security
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(26154);
 script_version ("$Revision: 1.8 $");
 script_name(english: "HP-UX Security patch : PHSS_36385");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing HP-UX PHSS_36385 security update");
 script_set_attribute(attribute: "description", value:
"X PA-RISC OV NNM7.51 Intermediate Patch 16");
 script_set_attribute(attribute: "solution", value: "ftp://ftp.itrc.hp.com//superseded_patches/hp-ux_patches/s700_800/11.X/PHSS_36385");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Checks for patch PHSS_36385");
 script_category(ACT_GATHER_INFO);
 script_copyright(english: "This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "HP-UX Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/HP-UX/swlist");
 exit(0);
}

include("hpux.inc");
if ( ! hpux_check_ctx ( ctx:"11.00 11.11 11.23 11.31 " ) )
{
 exit(0);
}

if ( hpux_patch_installed (patches:"PHSS_36385 PHSS_36901 PHSS_37273 ") )
{
 exit(0);
}

if ( hpux_check_patch( app:"OVNNMETCore.OVNNMET-CORE", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMETCore.OVNNMET-PD", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMETCore.OVNNMET-PESA", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVMIB-CONTRIB", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVNNM-RUN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVNNMGR-JPN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVNNMGR-KOR", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVNNMGR-SCH", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVRPT-RUN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVWWW-JPN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVWWW-KOR", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgr.OVWWW-SCH", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgrMan.OVNNM-RUN-MAN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgrRtDOC.OVNNM-DOC-REUS", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVNNMgrRtDOC.OVNNM-ENG-DOC", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVDB-RUN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVEVENT-MIN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVMIN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVSNMP-MIN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVWIN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVWWW-EVNT", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVWWW-FW", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatform.OVWWW-SRV", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatformMan.OVEVENTMIN-MAN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatformMan.OVSNMP-MIN-MAN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVPlatformMan.OVWIN-MAN", version:"B.07.50.00") )
{
 security_hole(0);
 exit(0);
}
exit(0, "Host is not affected");
