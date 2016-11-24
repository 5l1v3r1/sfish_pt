#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(21625);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2006-1175");
  script_bugtraq_id(18192);
  script_xref(name:"OSVDB", value:"25838");

  script_name(english:"wodSFTP ActiveX Arbitrary File Access");
  script_summary(english:"Checks for the wodSFTP ActiveX control"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an ActiveX control that allows arbitrary
access to the filesystem." );
 script_set_attribute(attribute:"description", value:
"The Windows remote host contains the wodSFTP ActiveX control, which
provides SFTP functionality to applications that use it and is marked
as 'safe for scripting'.  A remote attacker may be able to use this
control to store files on the remote filesystem or retrieve files from
it by means of a specially-crafted HTML page or email and without any
further interaction from the user." );
 script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/378604" );
 script_set_attribute(attribute:"solution", value:
"Disable the use of this ActiveX control from within Internet Explorer
by setting its 'kill' bit." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:N" );

script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}


include("global_settings.inc");
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
clid = "6795FA0F-35C3-4BEB-B3AA-F19DB0B228EA";
key = "SOFTWARE\Classes\CLSID\{" + clid +  "}\InprocServer32";
key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
path = NULL;
if (!isnull(key_h))
{
  value = RegQueryValue(handle:key_h, item:NULL);
  if (!isnull(value)) path = value[1];

  RegCloseKey(handle:key_h);
}


# If it is...
if (path)
{
  if (report_paranoia > 1)
  {
    report = string(
      "The ActiveX control is installed, but Nessus did not check\n",
      "whether it is disabled in Internet Explorer because of the\n",
      "Report Paranoia setting in effect when this scan was run.\n"
    );
    security_warning(port:get_kb_item("SMB/transport"), extra:report);
  }
  else
  {
    # Check the compatibility flags for the control.
    key = "SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{" + clid +  "}";
    key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
    flags = NULL;
    if (!isnull(key_h))
    {
      value = RegQueryValue(handle:key_h, item:"Compatibility Flags");
      if (!isnull(value)) flags = value[1];
 
      RegCloseKey(handle:key_h);
    }

    # There's a problem if the kill bit isn't set.
    if (isnull(flags) || flags != 0x400)
    {
      security_warning(port:get_kb_item("SMB/transport"));
    }
  }
}


# Clean up.
RegCloseKey(handle:hklm);
NetUseDel();
