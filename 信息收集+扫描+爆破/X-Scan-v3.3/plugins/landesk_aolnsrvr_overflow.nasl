#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(25085);
  script_version("$Revision: 1.6 $");

  script_cve_id("CVE-2007-1674");
  script_bugtraq_id(23483);
  script_xref(name:"OSVDB", value:"34964");

  script_name(english:"LANDesk Management Suite Alert Service (aolnsrvr.exe) Remote Overflow");
  script_summary(english:"Checks for Intel Pro Alerting Proxy"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an application that is affected by a
buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"LANDesk Management Suite, used to automate system and security
management tasks, is installed on the remote host. 

The version of LANDesk Management Suite includes an instance of Intel
Pro Alerting Proxy, which contains a stack-based buffer overflow
vulnerability.  An attacker may be able to leverage this issue by
connecting to it over UDP port 65535 and sending sufficient data to
overflow a 268 byte stack-based buffer to execute arbitrary code with
LOCAL SYSTEM privileges." );
 script_set_attribute(attribute:"see_also", value:"http://www.tippingpoint.com/security/advisories/TSRT-07-04.html" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2007-04/0212.html" );
 script_set_attribute(attribute:"solution", value:
"Apply the the latest Service Pack followed by hotfix
INST-11050687.2.zip or remove the Intel Pro Alerting Proxy software." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );
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


# Get some info about the install.
landesk = NULL;
path = NULL;

key = "SOFTWARE\LANDesk\ManagementSuite\Setup";
key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
if (!isnull(key_h))
{
  # If LANDesk is installed...
  item = RegQueryValue(handle:key_h, item:"LdmainPath");
  if (!isnull(item))
  {
    # Figure out where Alerting Proxy is installed.
    key2 = "SOFTWARE\INTEL\Alert on LAN\Proxy";
    key2_h = RegOpenKey(handle:hklm, key:key2, mode:MAXIMUM_ALLOWED);
    if (!isnull(key2_h))
    {
      item = RegQueryValue(handle:key2_h, item:"ImagePath");
      if (!isnull(item))
      {
        path = item[1];
        path = ereg_replace(pattern:"^(.+)\\$", replace:"\1", string:path);
      }
      RegCloseKey(handle:key2_h);
    }
  }
  RegCloseKey(handle:key_h);
}
RegCloseKey(handle:hklm);


# If it is...
if (path)
{
  # Make sure the executable exists.
  share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:path);
  exe =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1\Aolnsrvr.exe", string:path);
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
    CloseFile(handle:fh);

    # nb: the patch removes the affected software.
    report = string(
      "The LANDesk Management Suite Alert Service is installed under :\n",
      "\n",
      "  ", path, "\n"
    );
    security_hole(port:port, extra:report);
  }
}


# Clean up.
NetUseDel();
