#
#  (C) Tenable Network Security
#


include("compat.inc");

if (description)
{
  script_id(24734);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2007-1083");
  script_bugtraq_id(22671);
  script_xref(name:"OSVDB", value:"33479");

  script_name(english:"VeriSign ConfigChk ActiveX Control (VSCnfChk.dll) Buffer Overflow");
  script_summary(english:"Checks version of ConfigChk ActiveX control"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an ActiveX control that is affected by a
buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The ConfigChk ActiveX control, included with a VeriSign's PKI product
on the remote host and marked as safe for scripting, is reportedly
affected by a buffer overflow vulnerability involving its
'VerCompare()' method. 

If an attacker can trick a user on the affected host into visiting a
specially-crafted web page, he may be able to leverage this issue to
execute arbitrary code on the host subject to the user's privileges." );
 script_set_attribute(attribute:"see_also", value:"http://labs.idefense.com/intelligence/vulnerabilities/display.php?id=479" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2007-02/0520.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/308087" );
 script_set_attribute(attribute:"see_also", value:"http://www.verisign.com/support/advisories/page_040740.html" );
 script_set_attribute(attribute:"solution", value:
"Apply the vendor patch and verify that the file version of the
associated 'VSCnfChk.dll' is 2.0.0.3 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

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
clsid = '{08F04139-8DFC-11D2-80E9-006008B066EE}';
file = NULL;
flags = NULL;
key = "SOFTWARE\Classes\CLSID\" + clsid +  "\InprocServer32";
key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
if (!isnull(key_h))
{
  value = RegQueryValue(handle:key_h, item:NULL);
  if (!isnull(value)) file = value[1];

  RegCloseKey(handle:key_h);
}
if (report_paranoia < 2 && file)
{
  # Check the compatibility flags for the control.
  key = "SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\" + clsid +  "";
  key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
  if (!isnull(key_h))
  {
    value = RegQueryValue(handle:key_h, item:"Compatibility Flags");
    if (!isnull(value)) flags = value[1];

    RegCloseKey(handle:key_h);
  }
}
RegCloseKey(handle:hklm);
if (isnull(file))
{
  NetUseDel();
  exit(0);
}


# Determine the version from the control itself.
share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:file);
dll =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1", string:file);
NetUseDel(close:FALSE);

rc = NetUseAdd(login:login, password:pass, domain:domain, share:share);
if (rc != 1)
{
  NetUseDel();
  exit(0);
}

fh = CreateFile(
  file:dll,
  desired_access:GENERIC_READ,
  file_attributes:FILE_ATTRIBUTE_NORMAL,
  share_mode:FILE_SHARE_READ,
  create_disposition:OPEN_EXISTING
);
if (!isnull(fh))
{
  ver = GetFileVersion(handle:fh);
  CloseFile(handle:fh);

  # If the file version is under 2.0.0.3...
  if (
    !isnull(ver) && 
    (
      ver[0] < 2 ||
      (ver[0] == 2 && ver[1] == 0 && ver[2] == 0 && ver[3] < 3)
    )
  )
  {
    version = string(ver[0], ".", ver[1], ".", ver[2], ".", ver[3]);
    report = NULL;

    if (report_paranoia > 1)
      report = string(
        "Version ", version, " of the control is installed as :\n",
        "\n",
        "  ", file, "\n",
        "\n",
        "Nessus did not check, though, whether it is disabled in Internet\n",
        "Explorer because of the Report Paranoia setting in effect when\n",
        "this scan was run.\n"
      );
    else
    {
      # There's a problem if the kill bit isn't set.
      if (isnull(flags) || flags != 0x400)
      {
        report = string(
          "Version ", version, " of the control is installed as :\n",
          "\n",
          "  ", file, "\n"
        );
      }
    }
    if (report) security_warning(port:port, extra:report);
  }
}


# Clean up.
NetUseDel();
