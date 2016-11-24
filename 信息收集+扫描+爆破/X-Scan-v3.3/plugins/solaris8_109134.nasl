#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(13312);
 script_version("$Revision: 1.21 $");

 script_name(english: "Solaris 8 (sparc) : 109134-33");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 109134-33");
 script_set_attribute(attribute: "description", value:
'SunOS 5.8: WBEM patch.
Date this patch was last updated by Sun : Jul/06/06');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-109134-33-1");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Check for patch 109134-33");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWdclnt", version:"1.0,REV=2000.10.25.13.07");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWmga", version:"1.0,REV=2000.11.21.00.05");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWmgapp", version:"1.0,REV=1999.12.16.15.15");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWwbapi", version:"2.0,REV=1999.12.16.15.15");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWwbcor", version:"2.0,REV=1999.12.16.15.15");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWwbcou", version:"2.0,REV=1999.12.16.15.15");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWwbdev", version:"2.2,REV=2001.02.15.09.57");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWwbdoc", version:"2.2,REV=2001.01.23.23.08");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109134-33", obsoleted_by:"", package:"SUNWwbmc", version:"11.8,REV=2000.11.21.00.05");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
