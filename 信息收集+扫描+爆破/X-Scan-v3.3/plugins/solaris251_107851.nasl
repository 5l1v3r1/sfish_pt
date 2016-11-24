#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(23043);
 script_version ("$Revision: 1.7 $");
 script_bugtraq_id(5390);
 name["english"] = "Solaris 2.5.1 (sparc) : 107851-26";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing Sun Security Patch number 107851-26
(PGX32 2.1: Graphics Patch).

Date this patch was last updated by Sun : Fri Jan 07 01:47:31 MST 2005

You should install this patch for your system to be up-to-date." );
 script_set_attribute(attribute:"solution", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-107851-26-1" );
 script_set_attribute(attribute:"risk_factor", value:"High" );


 script_end_attributes();

 
 summary["english"] = "Check for patch 107851-26"; 
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

e +=  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"107851-26", obsoleted_by:"", package:"TSIgfxOW", version:"2.1");
e +=  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"107851-26", obsoleted_by:"", package:"TSIgfxdrv", version:"2.1");
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
