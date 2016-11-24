#
#  This script was written by David Maciejak <david dot maciejak at kyxar dot fr>
#  based on work from
#  (C) Tenable Network Security
#
#  Ref: Kyuzo <ogl@SirDrinkalot.rm-f.net>
#
#  This script is released under the GNU GPL v2
#
# Changes by Tenable :
# - Updated to use compat.inc (11/20/2009)


include("compat.inc");

if(description)
{
 script_id(15822);
 script_cve_id("CVE-2002-1059");
 script_bugtraq_id(5287);
 if ( defined_func("script_xref") ) script_xref(name:"OSVDB", value:"4991");
 
 script_version("$Revision: 1.7 $");
  
 name["english"] = "SecureCRT SSH1 protocol version string overflow";

 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host has an application that is affected by a
buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is using a vulnerable version of SecureCRT, a
SSH/Telnet client built for Microsoft Windows operation systems.

It has been reported that SecureCRT contain a remote buffer overflow
allowing an SSH server to execute arbitrary command via a specially
long SSH1 protocol version string." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to SecureCRT 3.2.2, 3.3.4, 3.4.6, 4.1 or newer" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 
 summary["english"] = "Determines the version of SecureCRT";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004 David Maciejak");
 family["english"] = "Windows";
 script_family(english:family["english"]);
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");

 script_require_ports(139, 445);
 exit(0);
}

include("smb_func.inc");

# Connect to the appropriate share.
name    =  kb_smb_name();
port    =  kb_smb_transport();
if (!get_port_state(port)) exit(0);
login   =  kb_smb_login();
pass    =  kb_smb_password();
domain  =  kb_smb_domain();

soc = open_sock_tcp(port);
if (!soc) exit(0);

session_init(socket:soc, hostname:name);
rc = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
if (rc != 1) {
  NetUseDel();
  exit(0);
}

# Connect to remote registry.
hklm = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
if (isnull(hklm))
{
  NetUseDel();
  exit(0);
}

key = "SOFTWARE\VanDyke\SecureCRT\License";
key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
if ( isnull(key_h) )
{
 key = "SOFTWARE/VanDyke/SecureCRT/Evaluation License/Version";
 if ( isnull(key_h) ) 
 {
  RegCloseKey(handle:hklm);
  NetUseDel();
  exit(0);
 }
}

version = RegQueryValue(handle:key_h, item:"Version");
RegCloseKey(handle:key_h);
RegCloseKey(handle:hklm);
NetUseDel();
if ( version )
{
 set_kb_item(name:"SMB/SecureCRT/Version", value:version);
 if (egrep(pattern:"^(2\.|3\.([01]|2[^.]|2\.1[^0-9]|3[^.]|3\.[1-3][^0-9]|4[^.]|4\.[1-5][^0-9])|4\.0 beta [12]([^0-9]|$))", string:version))
  security_hole(kb_smb_transport());
}

