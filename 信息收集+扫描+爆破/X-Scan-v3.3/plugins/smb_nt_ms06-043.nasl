#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(22185);
 script_version("$Revision: 1.10 $");

 script_cve_id("CVE-2006-2766");
 script_bugtraq_id(18198);
 script_xref(name:"OSVDB", value:"25949");

 name["english"] = "MS06-043: Vulnerability in Microsoft Windows Could Allow Remote Code Execution (920214)";

 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code can be executed on the remote host through the email
client." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of Microsoft Outlook Express
which contains a security flaw which may allow an attacker to execute
arbitrary code on the remote host. 

To exploit this flaw, an attacker would need to send a malformed HTML
email to a victim on the remote host and have him open it." );
 script_set_attribute(attribute:"solution", value:
"Microsoft has released a set of patches for Outlook Express :

See: http://www.microsoft.com/technet/security/bulletin/ms06-043.mspx" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:N/I:N/A:P" );


script_end_attributes();

 
 summary["english"] = "Determines the presence of update 920214";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows : Microsoft Bulletins";
 script_family(english:family["english"]);
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}



include("smb_hotfixes_fcheck.inc");
include("smb_hotfixes.inc");
include("smb_func.inc");


if ( hotfix_check_sp(xp:3, win2003:2) <= 0 ) exit(0);

if (is_accessible_share())
{
 if ( hotfix_is_vulnerable (os:"5.2", sp:1, file:"Inetcomm.dll", version:"6.0.3790.2757", dir:"\system32") ||
      hotfix_is_vulnerable (os:"5.1", sp:2, file:"Inetcomm.dll", version:"6.0.2900.2962", dir:"\system32") )
 {
 set_kb_item(name:"SMB/Missing/MS06-043", value:TRUE);
 hotfix_security_note();
 }
 
 hotfix_check_fversion_end(); 
 exit (0);
}
