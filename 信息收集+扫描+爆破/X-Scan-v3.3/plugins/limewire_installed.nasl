#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(11427);
 script_version("$Revision: 1.7 $");

 script_name(english:"LimeWire Detection");

 script_set_attribute(attribute:"synopsis", value:
"The remote host has a p2p application installed." );
 script_set_attribute(attribute:"description", value:
"The remote host is using LimeWire - a p2p software, 
which may not be suitable for a business environment." );
 script_set_attribute(attribute:"see_also", value:"http://www.limewire.com/" );
 script_set_attribute(attribute:"solution", value:
"Remove this software if it does not comply with your corporate
security policy." );
 script_set_attribute(attribute:"risk_factor", value:
"None" );

script_end_attributes();

 script_summary(english:"Determines if LimeWire is installed");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_family(english:"Peer-To-Peer File Sharing");
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}

#

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



key = "SOFTWARE\LimeWire";
item = "InstallDir";

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
RegCloseKey(handle:hklm);
NetUseDel();
