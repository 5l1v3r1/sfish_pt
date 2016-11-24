#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(24221);
 script_version ("$Revision: 1.8 $");
 name["english"] = "Solaris 9 (i386) : 113590-08";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing Sun Security Patch number 113590-08
(SunOS 5.9_x86: JFP manpages patch).

Date this patch was last updated by Sun : Wed Jan 03 03:31:09 MST 2007

You should install this patch for your system to be up-to-date." );
 script_set_attribute(attribute:"solution", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-113590-08-1" );
 script_set_attribute(attribute:"risk_factor", value:"High" );


 script_end_attributes();

 
 summary["english"] = "Check for patch 113590-08"; 
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2008 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"113590-08", obsoleted_by:"", package:"SUNWjeman", version:"1.2,REV=2002.09.12.16.42");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"113590-08", obsoleted_by:"", package:"SUNWjman", version:"1.2,REV=2002.01.31.09.18");
e +=  solaris_check_patch(release:"5.9_x86", arch:"i386", patch:"113590-08", obsoleted_by:"", package:"SUNWjmane", version:"1.1,REV=2002.09.12.16.42");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
