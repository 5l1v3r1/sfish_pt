#
# (C) Tenable Network Security 
#
#


include("compat.inc");

if(description)
{
 script_id(12018);
 script_version("$Revision: 1.5 $");

 script_name(english: "POWER SEARCH detection");
 
 script_set_attribute(attribute:"synopsis", value:
"A spyware is installed on the remote host." );
 script_set_attribute(attribute:"description", value:
"The remote host is using the POWER SEARCH program. You should ensure 
that :
- the user intended to install POWER SEARCH (it is sometimes silently 
  installed)
- the use of POWER SEARCH matches your corporate mandates and security 
  policies.

To remove this sort of software, you may wish to check out ad-aware or 
Spybot." );
 script_set_attribute(attribute:"see_also", value:"http://www3.ca.com/securityadvisor/pest/pest.aspx?id=453094133" );
 script_set_attribute(attribute:"solution", value:
"Uninstall this software." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 script_summary(english: "POWER SEARCH detection");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security");
 script_family(english: "Windows");
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");

 script_require_ports(139, 445);
 exit(0);
}


# start the script
include("smb_func.inc");

if ( ! get_kb_item("SMB/Registry/Enumerated") ) exit(0);

path[0] = "SOFTWARE\classes\clsid\{4e7bd74f-2b8d-469e-d3fa-f27ba787ad2d}";
path[1] = "SOFTWARE\microsoft\internet explorer\toolbar\{4e7bd74f-2b8d-469e-d3fa-f27ba787ad2d}";


port = kb_smb_transport();
if(!port || ! get_port_state(port) )exit(0);

login = kb_smb_login();
pass  = kb_smb_password();
domain = kb_smb_domain();

          
soc = open_sock_tcp(port);
if(!soc) exit(0);

session_init(socket:soc, hostname:kb_smb_name());
r = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
if ( r != 1 ) exit(0);

handle = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
if ( isnull(handle) )
{
 NetUseDel();
 exit(0);
}


for (i=0; path[i]; i++) {
       key_h = RegOpenKey(handle:handle, key:path[i], mode:MAXIMUM_ALLOWED);
       if ( !isnull(key_h) ) 
       { 
         RegCloseKey(handle:key_h);
         RegCloseKey(handle:handle);
	 security_hole(kb_smb_transport()); 
	 NetUseDel();
	 exit(0);
       }
}


RegCloseKey(handle:handle);
NetUseDel();
