#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(23392);
 script_version("$Revision: 1.10 $");

 script_name(english: "Solaris 5.8 (sparc) : 116856-35");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 116856-35");
 script_set_attribute(attribute: "description", value:
'Portal Server 6.2: Miscellaneous Fixes.
Date this patch was last updated by Sun : Mar/16/09');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-116856-35-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 116856-35");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWps", version:"6.2,REV=2003.11.17.14.07");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsap", version:"6.2,REV=2003.11.17.14.11");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpscp", version:"6.2,REV=2003.11.17.14.11");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsdt", version:"6.2,REV=2003.11.17.13.49");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsdtx", version:"6.2,REV=2003.11.17.14.08");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsgw", version:"6.2,REV=2003.11.17.14.14");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsgws", version:"6.2,REV=2003.11.17.14.14");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsks", version:"6.2,REV=2003.11.17.14.13");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsmig", version:"6.2,REV=2003.11.17.14.07");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsnf", version:"6.2,REV=2003.11.17.14.20");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsnl", version:"6.2,REV=2003.11.17.14.17");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsnlp", version:"6.2,REV=2003.11.17.14.17");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsnm", version:"6.2,REV=2003.11.17.14.08");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsp", version:"6.2,REV=2003.11.17.13.50");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsrw", version:"6.2,REV=2003.11.17.13.48");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpsrwp", version:"6.2,REV=2003.11.17.14.14");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpssdk", version:"6.2,REV=2003.11.17.14.08");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"116856-35", obsoleted_by:"", package:"SUNWpssso", version:"6.2,REV=2003.11.17.14.10");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
