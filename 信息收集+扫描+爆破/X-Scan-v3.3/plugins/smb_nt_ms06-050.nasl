#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(22192);
 script_version("$Revision: 1.11 $");

 script_cve_id("CVE-2006-3086", "CVE-2006-3438");
 script_bugtraq_id(19405);
 script_xref(name:"OSVDB", value:"26666");
 script_xref(name:"OSVDB", value:"29724");

 name["english"] = "MS06-050: Vulnerabilities in Microsoft Windows Hyperlink Object Library Could Allow Remote Code Execution (920670)";
 script_name(english:name["english"]);

 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code can be executed on the remote host through the web
client." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of Windows that contains a flaw
in the Hyperlink Object Library. 

An attacker may exploit this flaw to execute arbitrary code on the
remote host. 

To exploit this flaw, an attacker would need to construct a malicious
hyperlink and lure a victim into clicking it." );
 script_set_attribute(attribute:"solution", value:
"Microsoft has released a set of patches for Windows 2000, XP and 
2003 :

http://www.microsoft.com/technet/security/bulletin/ms06-050.mspx" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
 summary["english"] = "Checks for KB 920670 via the registry";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows : Microsoft Bulletins";
 script_family(english:family["english"]);

 script_dependencies("smb_hotfixes.nasl" );
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}

include("smb_hotfixes_fcheck.inc");
include("smb_hotfixes.inc");
include("smb_func.inc");

if ( hotfix_check_sp(xp:3, win2k:6, win2003:2) <= 0 ) exit(0);

if (is_accessible_share())
{
 if ( hotfix_is_vulnerable (os:"5.2", sp:0, file:"Hlink.dll", version:"5.2.3790.560", dir:"\system32") ||
      hotfix_is_vulnerable (os:"5.2", sp:1, file:"Hlink.dll", version:"5.2.3790.2748", dir:"\system32") ||
      hotfix_is_vulnerable (os:"5.1", file:"Hlink.dll", version:"5.2.3790.2748", dir:"\system32") ||
      hotfix_is_vulnerable (os:"5.0", file:"Hlink.dll", version:"5.2.3790.2748", dir:"\system32") )
 {
 set_kb_item(name:"SMB/Missing/MS06-050", value:TRUE);
 hotfix_security_hole();
 }
 
 hotfix_check_fversion_end(); 
 exit (0);
}
