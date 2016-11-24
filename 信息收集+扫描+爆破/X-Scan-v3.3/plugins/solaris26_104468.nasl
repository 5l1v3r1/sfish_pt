#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(23093);
 script_version ("$Revision: 1.8 $");
 name["english"] = "Solaris 2.6 (sparc) : 104468-20";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing Sun Security Patch number 104468-20
(Solstice AdminSuite 2.3/AutoClient 2.1: y2000 NIS+ BSM).

Date this patch was last updated by Sun : Thu Nov 17 06:28:21 MST 2005

You should install this patch for your system to be up-to-date." );
 script_set_attribute(attribute:"solution", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-104468-20-1" );
 script_set_attribute(attribute:"risk_factor", value:"High" );


 script_end_attributes();

 
 summary["english"] = "Check for patch 104468-20"; 
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

e +=  solaris_check_patch(release:"5.6", arch:"sparc", patch:"104468-20", obsoleted_by:"", package:"SUNWsacb", version:"6.6,REV=96.11.18.00.42");
e +=  solaris_check_patch(release:"5.6", arch:"sparc", patch:"104468-20", obsoleted_by:"", package:"SUNWsacd", version:"6.6,REV=96.11.18.00.42");
e +=  solaris_check_patch(release:"5.6", arch:"sparc", patch:"104468-20", obsoleted_by:"", package:"SUNWsaco", version:"6.6,REV=96.11.18.00.43");
e +=  solaris_check_patch(release:"5.6", arch:"sparc", patch:"104468-20", obsoleted_by:"", package:"SUNWsadma", version:"6.6,REV=96.11.18.00.42");
e +=  solaris_check_patch(release:"5.6", arch:"sparc", patch:"104468-20", obsoleted_by:"", package:"SUNWsadmb", version:"6.6,REV=96.11.18.00.42");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
