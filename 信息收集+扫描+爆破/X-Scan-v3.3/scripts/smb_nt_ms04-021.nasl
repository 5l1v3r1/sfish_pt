#
# (C) Tenable Network Security
#
if(description)
{
 script_id(13639);
 script_bugtraq_id(10706);
 script_version("$Revision: 1.6 $");
 script_cve_id("CAN-2004-0205");
 if ( defined_func("script_xref") ) script_xref(name:"IAVA", value:"2004-B-0011");

 name["english"] = "IIS Redirection Vulnerability (841373) (registry check)";

 script_name(english:name["english"]);

 desc["english"] = "
The remote host has a version of IIS 4.0 which is vulnerable to a remote
flaw which may allow an attacker to take the control of the remote web server
and execute arbitrary commands on the remote host with the SYSTEM privileges.

Solution : http://www.microsoft.com/technet/security/bulletin/ms04-021.mspx
Risk factor : High";

 script_description(english:desc["english"]);
 
 summary["english"] = "Checks for ms04-021 over the registry";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004 Tenable Network Security");
 family["english"] = "Windows : Microsoft Bulletins";
 script_family(english:family["english"]);
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 exit(0);
}

include("smb_hotfixes.inc");

if ( hotfix_check_sp(nt:7) <= 0 ) exit(0);
if ( hotfix_missing(name:"KB841373") > 0 )	
	security_hole(get_kb_item("SMB/transport"));
