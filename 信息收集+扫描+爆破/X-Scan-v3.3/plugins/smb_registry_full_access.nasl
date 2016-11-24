#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if(description)
{
  script_id(10428);
  script_version ("$Revision: 1.34 $");

  script_name(english:"SMB fully accessible registry");
  script_summary(english:"Determines whether the remote registry is fully accessible");

  script_set_attribute(
    attribute:'synopsis',
    value:'Nessus had insufficient access to the remote registry.'
  );

  script_set_attribute(
    attribute:'description',
    value:"Nessus did not access the remote registry completely,
because this needs to be logged in as administrator.

If you want the permissions / values of all the sensitive
registry keys to be checked for, we recommend that
you fill the 'SMB Login' options in the
'Prefs.' section of the client by the administrator
login name and password."
  );

  script_set_attribute(
    attribute:'solution',
    value:'Use an administrator level account for scanning.'
  );

  script_set_attribute(
    attribute:'risk_factor',
    value:'None'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_family(english:"Windows");

  script_dependencies("netbios_name_get.nasl", "smb_login.nasl", "smb_registry_access.nasl");
  script_require_keys("SMB/transport", "SMB/name", "SMB/login", "SMB/password", "SMB/registry_access");
  script_require_ports(139, 445);
  exit(0);
}

include("smb_func.inc");

access = get_kb_item("SMB/registry_access");
if(!access)exit(0);


#---------------------------------------------------------------------#
# Here is our main()                                                  #
#---------------------------------------------------------------------#

name	= kb_smb_name();
login	= kb_smb_login();
pass	= kb_smb_password();
domain  = kb_smb_domain();
port	= kb_smb_transport();

if ( ! get_port_state(port) ) exit(0);
soc = open_sock_tcp(port);
if ( ! soc ) exit(0);

session_init(socket:soc, hostname:name);
r = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
if ( r != 1 ) exit(0);

hklm = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
if ( isnull(hklm) )
{
 NetUseDel();
 exit(0);
}


full = FALSE;

keys = make_list(
		"SOFTWARE\Microsoft\Internet Explorer\Version Vector",
		"SOFTWARE\Microsoft\Internet Explorer",
		"SOFTWARE\Microsoft\Internet Explorer"
	);

items = make_list(
		"IE",
		"IVer",
		"Version"
	);

# IE test -> enough rights
for (i=0; i<max_index(keys); i++)
{
 key_h = RegOpenKey(handle:hklm, key:keys[i], mode:MAXIMUM_ALLOWED);
 if ( ! isnull(key_h) )
 {
  value = RegQueryValue(handle:key_h, item:items[i]);
  if (!isnull (value))
  {
   full = TRUE;
   set_kb_item(name:"SMB/registry_full_access", value:TRUE);
   break;
  }

  RegCloseKey (handle:key_h);
 }
}

RegCloseKey(handle:hklm);
NetUseDel();

if (full == FALSE)
  security_note (port);
