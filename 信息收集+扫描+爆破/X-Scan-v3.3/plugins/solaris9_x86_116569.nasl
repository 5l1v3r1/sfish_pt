#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(37470);
 script_version("$Revision: 1.1 $");

 script_name(english: "Solaris 5.9 (x86) : 116569-99");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 116569-99");
 script_set_attribute(attribute: "description", value:
'Messaging Server 6.1_x86: core patch.
Date this patch was last updated by Sun : Feb/09/05');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-116569-99-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 116569-99");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgco", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgen", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgin", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsglb", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgmf", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgmp", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgmt", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgst", version:"6.0,REV=2003.10.29");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"116569-99", obsoleted_by:"118208-28 120229-20 ", package:"SUNWmsgwm", version:"6.0,REV=2003.10.29");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
