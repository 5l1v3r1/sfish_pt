#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(27596);
  script_version("$Revision: 1.4 $");

  script_cve_id("CVE-2007-3874", "CVE-2007-5838");
  script_bugtraq_id(26265, 26266);
  script_xref(name:"OSVDB", value:"40863");
  script_xref(name:"OSVDB", value:"44700");

  script_name(english:"Altiris AClient < 6.8.380 Local Vulnerabilities");
  script_summary(english:"Checks version of aclient.exe");

 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has a program that is prone to multiple local
attacks." );
 script_set_attribute(attribute:"description", value:
"The version of the Altiris Client Agent (aclient) installed on the
remote host contains a flaw in its browser option whereby a local user
can open or execute files on the affected host with SYSTEM privileges. 

It also contains a directory traversal vulnerability that allows a
local user to read privileged system files." );
 script_set_attribute(attribute:"see_also", value:"http://www.symantec.com/avcenter/security/Content/2007.10.31.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.symantec.com/avcenter/security/Content/2007.10.31a.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Altiris Deployment Solution version 6.8.380.0 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C" );


script_end_attributes();


  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

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


# Check whether it's installed.
path = NULL;

key = "SOFTWARE\Altiris\Client Service";
key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
if (!isnull(key_h))
{
  value = RegQueryValue(handle:key_h, item:"InstallDir");
  if (!isnull(value))
  {
    path = value[1];
    path = ereg_replace(pattern:"^(.+)\\$", replace:"\1", string:path);
  }

  RegCloseKey(handle:key_h);
}
RegCloseKey(handle:hklm);
if (isnull(path))
{
  NetUseDel();
  exit(0);
}


# Check the version of the main exe.
share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:path);
exe =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1\aclient.exe", string:path);
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
ver = NULL;
if (!isnull(fh))
{
  ver = GetFileVersion(handle:fh);
  CloseFile(handle:fh);
}

# Check the version number.
if (!isnull(ver) && ver[0] == 6)
{
  fix = split("6.8.380.0", sep:'.', keep:FALSE);
  for (i=0; i<4; i++)
    fix[i] = int(fix[i]);

  for (i=0; i<max_index(ver); i++)
    if ((ver[i] < fix[i]))
    {
      version = string(ver[0], ".", ver[1], ".", ver[2]);
      report = string(
        "Version ", version, " of the Altiris Client Agent is installed under :\n",
        "\n",
        "  ", path, "\n"
      );
      security_hole(port:port, extra:report);
      break;
    }
    else if (ver[i] > fix[i])
      break;
}


# Clean up.
NetUseDel();
