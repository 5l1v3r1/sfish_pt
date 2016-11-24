#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(11887);
 script_version("$Revision: 1.15 $");

 script_cve_id("CVE-2003-0662");
 script_bugtraq_id(8833);
 script_xref(name:"IAVA", value:"2003-A-0029");
 script_xref(name:"OSVDB", value:"10999");
 
 name["english"] = "MS03-042: Buffer Overflow in Windows Troubleshooter ActiveX Control (826232)";
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code can be executed on the remote host through the web
client." );
 script_set_attribute(attribute:"description", value:
"The remote host contains a version of the Troubleshooter ActiveX
control module that may allow an attacker to execute arbitrary code on
the remote host by constructing a malicious web page and entice a
victim to visit this web page." );
 script_set_attribute(attribute:"solution", value:
"Microsoft has released a set of patches for Windows 2000 :

http://www.microsoft.com/technet/security/bulletin/ms03-042.mspx" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
 summary["english"] = "Checks for hotfix Q826232";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows : Microsoft Bulletins";
 script_family(english:family["english"]);
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}

include("smb_func.inc");
include("smb_hotfixes.inc");
include("smb_hotfixes_fcheck.inc");

if ( hotfix_check_sp(win2k:5) <= 0 ) exit(0);

if (is_accessible_share())
{
 if ( hotfix_is_vulnerable (os:"5.0", file:"tshoot.ocx", version:"1.0.1.2125", dir:"\help") )
 {
 set_kb_item(name:"SMB/Missing/MS03-042", value:TRUE);
 security_hole(get_kb_item("SMB/transport"));
 }
 
 hotfix_check_fversion_end();
 exit (0);
}
else if ( hotfix_missing(name:"KB826232") > 0 )
	 {
 set_kb_item(name:"SMB/Missing/MS03-042", value:TRUE);
 hotfix_security_hole();
 }
