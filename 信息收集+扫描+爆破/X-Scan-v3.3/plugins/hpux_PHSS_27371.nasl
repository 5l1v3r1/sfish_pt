
#
# (C) Tenable Network Security
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(17476);
 script_version ("$Revision: 1.8 $");
 script_name(english: "HP-UX Security patch : PHSS_27371");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing HP-UX PHSS_27371 security update");
 script_set_attribute(attribute: "description", value:
"Virtualvault 4.5 OWS update");
 script_set_attribute(attribute: "solution", value: "ftp://ftp.itrc.hp.com//superseded_patches/hp-ux_patches/s700_800/11.X/PHSS_27371");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Checks for patch PHSS_27371");
 script_category(ACT_GATHER_INFO);
 script_copyright(english: "This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "HP-UX Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/HP-UX/swlist");
 exit(0);
}

include("hpux.inc");
if ( ! hpux_check_ctx ( ctx:"11.04 " ) )
{
 exit(0);
}

if ( hpux_patch_installed (patches:"PHSS_27371 PHSS_27627 PHSS_28098 PHSS_28685 PHSS_29545 PHSS_29690 PHSS_30160 PHSS_30648 PHSS_31828 PHSS_32184 PHSS_33396 PHSS_34119 PHSS_35107 PHSS_35461 PHSS_35556 ") )
{
 exit(0);
}

if ( hpux_check_patch( app:"VaultWS.WS-CORE", version:"A.04.50") )
{
 security_hole(0);
 exit(0);
}
exit(0, "Host is not affected");
