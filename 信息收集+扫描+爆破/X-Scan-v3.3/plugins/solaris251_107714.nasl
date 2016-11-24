#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(23042);
 script_version ("$Revision: 1.8 $");
 script_bugtraq_id(5390);
 name["english"] = "Solaris 2.5.1 (sparc) : 107714-25";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing Sun Security Patch number 107714-25
(PGX32 2.5.1: PGX32 Graphics Patch).

Date this patch was last updated by Sun : Wed Sep 24 03:49:52 MDT 2003

You should install this patch for your system to be up-to-date." );
 script_set_attribute(attribute:"solution", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-107714-25-1" );
 script_set_attribute(attribute:"risk_factor", value:"High" );


 script_end_attributes();

 
 summary["english"] = "Check for patch 107714-25"; 
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

e +=  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"107714-25", obsoleted_by:"", package:"TSIpgxmn", version:"2.5.1,REV=1999.03.18");
e +=  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"107714-25", obsoleted_by:"", package:"TSIpgxw", version:"2.5.1,REV=1999.03.18");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
else 
{
	set_kb_item(name:"BID-5390", value:TRUE);
}
