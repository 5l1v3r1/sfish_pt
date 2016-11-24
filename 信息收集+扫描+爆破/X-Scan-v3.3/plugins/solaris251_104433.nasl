#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(23010);
 script_version("$Revision: 1.10 $");

 script_name(english: "Solaris 2.5.1 (sparc) : 104433-09");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 104433-09");
 script_set_attribute(attribute: "description", value:
'.
Date this patch was last updated by Sun : Oct/06/98');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-104433-09-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 104433-09");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"104433-09", obsoleted_by:"104818-02 106563-01 ", package:"SUNWcsr", version:"11.5.1,REV=96.05.02.21.09");
e +=  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"104433-09", obsoleted_by:"104818-02 106563-01 ", package:"SUNWcsu", version:"11.5.1,REV=96.05.02.21.09");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
