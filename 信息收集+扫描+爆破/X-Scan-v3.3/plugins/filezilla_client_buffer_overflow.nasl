#
#  (C) Tenable Network Security
#


include("compat.inc");

if (description)
{
  script_id(21565);
  script_version("$Revision: 1.11 $");

  script_cve_id("CVE-2006-2403");
  script_bugtraq_id(17972);
  script_xref(name:"OSVDB", value:"29970");

  script_name(english:"FileZilla FTP Client Unspecified Overflow");
  script_summary(english:"Checks version of FileZilla client"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an application that suffers from a
remotely-exploitable buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"According to its version, the FileZilla FTP client installed on the
remote host is affected by an unspecified buffer overflow
vulnerability.  It may be possible to exploit this issue remotely by
tricking a user into connecting to a malicious FTP site using the
affected client; remote code execution would then be possible subject
to the user's privileges." );
 script_set_attribute(attribute:"see_also", value:"http://sourceforge.net/project/shownotes.php?release_id=416790" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to FileZilla client version 2.2.23 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}


include("smb_func.inc");


# Connect to the appropriate share.
if (!get_kb_item("SMB/Registry/Enumerated")) exit(0);

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
if (rc != 1)
{
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


# Get some info about the install.
key = "SOFTWARE\FileZilla";
key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
path = NULL;
if (!isnull(key_h))
{
  item = RegQueryValue(handle:key_h, item:"Install_Dir");
  if (!isnull(item)) path = item[1];

  RegCloseKey(handle:key_h);
}


# If it is...
if (path)
{
  # Determine its version from the executable itself.
  share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:path);
  exe =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1\FileZilla.exe", string:path);
  NetUseDel(close:FALSE);

  rc = NetUseAdd(login:login, password:pass, domain:domain, share:share);
  if (rc != 1)
  {
    NetUseDel();
    exit(0);
  }

  fh = CreateFile(
    file:exe,
    desired_access:GENERIC_READ,
    file_attributes:FILE_ATTRIBUTE_NORMAL,
    share_mode:FILE_SHARE_READ,
    create_disposition:OPEN_EXISTING
  );
  if (!isnull(fh))
  {
    ver = GetFileVersion(handle:fh);
    CloseFile(handle:fh);
  }

  # There's a problem if the version is < 2.2.23.
  if (!isnull(ver))
  {
    if (
      ver[0] < 2 ||
      (
        ver[0] == 2 && 
        (
          ver[1] < 2 ||
          (ver[1] == 2 && ver[2] < 23)
        )
      )
    ) security_hole(kb_smb_transport());
  }
}


# Clean up.
RegCloseKey(handle:hklm);
NetUseDel();
