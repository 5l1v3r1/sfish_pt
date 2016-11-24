#
# (C) Tenable Network Security
#

if(description)
{
 script_id(11425);
 script_bugtraq_id(1307, 132, 246, 2664, 3226, 3813, 929);

 script_cve_id("CAN-1999-1418", "CAN-1999-1440", "CAN-2000-0046", "CAN-2000-0564", "CVE-2000-0552", "CAN-2001-0367", "CVE-2002-0028", "CAN-2001-1305");
 
 script_version("$Revision: 1.8 $");

 name["english"] = "ICQ is installed";

 script_name(english:name["english"]);
 
 desc["english"] = "
The remote host is using ICQ - a p2p software, 
which may not be suitable for a business environment. 

Solution : Uninstall this software
Risk factor : Low";



 script_description(english:desc["english"]);
 
 summary["english"] = "Determines if ICQ is installed";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2003 Tenable Network Security");
 family["english"] = "Peer-To-Peer File Sharing";
 script_family(english:family["english"]);
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}


include("smb_func.inc");


if ( ! get_kb_item("SMB/Registry/Enumerated") ) exit(1);


name	= kb_smb_name();
login	= kb_smb_login(); 
pass	= kb_smb_password(); 	
domain  = kb_smb_domain(); 	
port	= kb_smb_transport();

if ( ! get_port_state(port) ) exit(1);
soc = open_sock_tcp(port);
if ( ! soc ) exit(1);

session_init(socket:soc, hostname:name);
r = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
if ( r != 1 ) exit(1);

hklm = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
if ( isnull(hklm) ) 
{
 NetUseDel();
 exit(1);
}

vuln = 0;

key = "SOFTWARE\Microsoft\CurrentVersion\Uninstall\ICQ";
item = "DisplayName";

key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
if ( ! isnull(key_h) )
{
 value = RegQueryValue(handle:key_h, item:item);

 if (!isnull (value))
 {
   vuln = 1;
   security_note(port);
 }

 RegCloseKey (handle:key_h);
}


if (!vuln)
{
 key = "SOFTWARE\Microsoft\CurrentVersion\Uninstall\ICQLite";
 item = "DisplayName";

 key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
 if ( ! isnull(key_h) )
 {
  value = RegQueryValue(handle:key_h, item:item);

  if (!isnull (value))
  {
   security_note(port);
  }

  RegCloseKey (handle:key_h);
 }
}


RegCloseKey (handle:hklm);
NetUseDel ();
