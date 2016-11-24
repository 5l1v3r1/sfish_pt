#
# (C) Tenable Network Security
#


include("compat.inc");

if(description)
{
 script_id(19767);
 script_version("$Revision: 1.5 $");

 name["english"] = "Google Secure Access VPN Client Installed"; 

 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"A potentially unauthorized VPN connection is installed on the remote host" );
 script_set_attribute(attribute:"description", value:
"The remote host has the program 'Google Secure Access' installed. This software
is a VPN client allowing roaming users to establish a VPN connection with 
Google's VPN server, thus protecting the local communications from being 
eavesdropped by a local user. This potentially allows Google to eavesdrop 
on the communications of the remote user.

Make sure that the remote installation of Google Secure Access has been done in
accordance to your security policy." );
 script_set_attribute(attribute:"solution", value:
"Disable this software if it does not match your corporate security policy." );
 script_set_attribute(attribute:"see_also", value:"http://wifi.google.com" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:S/C:P/I:N/A:N" );



script_end_attributes();

 
 summary["english"] = "Determines the presence of the Google Secure Access";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows";
 script_family(english:family["english"]);
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}


include("smb_func.inc");
include("smb_hotfixes.inc");

rootfile = hotfix_get_programfilesdir();
if ( ! rootfile ) exit(1);

share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:rootfile);
exe =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1\Google\Secure Access\GoogleSecureAccess.exe", string:rootfile);

name 	=  kb_smb_name();
login	=  kb_smb_login();
pass  	=  kb_smb_password();
domain 	=  kb_smb_domain();
port    =  kb_smb_transport();


if(!get_port_state(port))exit(1);
soc = open_sock_tcp(port);
if(!soc)exit(1);

session_init(socket:soc, hostname:name);

r = NetUseAdd(login:login, password:pass, domain:domain, share:share);
if ( r != 1 ) exit(1);


handle = CreateFile (file:exe, desired_access:GENERIC_READ, file_attributes:FILE_ATTRIBUTE_NORMAL,
                     share_mode:FILE_SHARE_READ, create_disposition:OPEN_EXISTING);

if ( ! isnull(handle) )
{
 version = GetFileVersion (handle:handle);
 CloseFile(handle:handle);
 if ( isnull(version) )
	{
	 NetUseDel();
	 exit(1);
	}

 set_kb_item(name:"SMB/Google/SecureAccess/Version", value:version[0] + "." + version[1] + "." + version[2] + "." + version[3]);
 security_warning(0);

}

NetUseDel();
