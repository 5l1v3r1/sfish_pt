#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(13331);
 script_version("$Revision: 1.15 $");

 script_name(english: "Solaris 8 (sparc) : 109887-18");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 109887-18");
 script_set_attribute(attribute: "description", value:
'SunOS 5.8: smartcard and usr/sbin/ocfserv patch.
Date this patch was last updated by Sun : Nov/17/03');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-109887-18-1");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Check for patch 109887-18");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"FJSVhea", version:"1.0,REV=1999.12.23.19.10");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWcstl", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWcstlx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWhea", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWiscr", version:"11.8.0,REV=2000.07.05.13.22");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWocf", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWocfh", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWocfr", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWocfx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWpamsc", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWpamsx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"109887-18", obsoleted_by:"", package:"SUNWscmos", version:"11.8.0,REV=2000.01.08.18.12");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
