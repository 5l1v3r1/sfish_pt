#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(13406);
 script_version("$Revision: 1.15 $");

 script_name(english: "Solaris 8 (sparc) : 117000-05");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 117000-05");
 script_set_attribute(attribute: "description", value:
'SunOS 5.8: Kernel Patch.
Date this patch was last updated by Sun : Apr/30/04');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-117000-05-1");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Check for patch 117000-05");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"FJSVhea", version:"1.0,REV=1999.12.23.19.10");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcar", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcar", version:"11.8.0,REV=2000.01.13.13.40");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcarx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcarx", version:"11.8.0,REV=2000.01.13.13.40");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcpc", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcpc", version:"11.8.0,REV=2000.01.13.13.40");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcpcx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcpcx", version:"11.8.0,REV=2000.01.13.13.40");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcpr", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcprx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcsr", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcsu", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWcsxu", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWdrr", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWdrr", version:"11.8.0,REV=2000.12.12.12.13");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWdrrx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWdrrx", version:"11.8.0,REV=2000.12.12.12.13");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWged", version:"3.0,REV=5.8.1999.11.16");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWgedu", version:"3.0,REV=5.8.1999.11.16");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWhea", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWidn", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWidnx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWmdb", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWmdbx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWncar", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWncarx", version:"11.8.0,REV=2000.01.08.18.12");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWusx", version:"11.8.0,REV=2000.07.05.13.22");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWwrsax", version:"11.8.0,REV=2001.08.10.04.15");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"117000-05", obsoleted_by:"", package:"SUNWwrsmx", version:"11.8.0,REV=2001.09.29.20.43");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
