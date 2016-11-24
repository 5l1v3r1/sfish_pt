#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(23609);
 script_version("$Revision: 1.16 $");

 script_name(english: "Solaris 5.9 (x86) : 118908-06");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 118908-06");
 script_set_attribute(attribute: "description", value:
'X11 6.7.0_x86: Xorg patch.
Date this patch was last updated by Sun : Sep/23/08');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-118908-06-1");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Check for patch 118908-06");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"118908-06", obsoleted_by:"", package:"SUNWxorg-doc", version:"6.7.0.5.9.1701,REV=0.2004.08.27");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"118908-06", obsoleted_by:"", package:"SUNWxorg-graphics-ddx", version:"6.7.0.5.9.1701,REV=0.2004.08.27");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"118908-06", obsoleted_by:"", package:"SUNWxorg-server", version:"6.7.0.5.9.1701,REV=0.2004.08.27");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
