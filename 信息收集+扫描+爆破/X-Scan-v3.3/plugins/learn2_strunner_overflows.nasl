#
#  (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(31352);
  script_version("$Revision: 1.3 $");

  script_cve_id("CVE-2007-6252");
  script_bugtraq_id(28058);
  script_xref(name:"OSVDB", value:"42554");

  script_name(english:"Learn2 STRunner ActiveX Control Multiple Buffer Overflow Vulnerabilities");
  script_summary(english:"Checks for affected ActiveX control"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an ActiveX control that is susceptible to
multiple buffer overflow attacks." );
 script_set_attribute(attribute:"description", value:
"The Learn2 Corporation's STRunner ActiveX control, used with various
online tutorials, is installed on the remote host.  It reportedly is
affected by multiple and as-yet unspecified stack buffer overflows. 
If a remote attacker can trick a user on the affected host into
visiting a specially-crafted web page, he may be able to leverage this
issue to execute arbitrary code on the affected host subject to the
user's privileges." );
 script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/524857" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}


include("global_settings.inc");
include("smb_func.inc");
include("smb_activex_func.inc");


if (!get_kb_item("SMB/Registry/Enumerated")) exit(0);


# Locate the file used by the control.
if (activex_init() != ACX_OK) exit(0);

clsid = "{0B72CCA4-5F11-11D0-9CB5-0000C0EC9FDB}";
file = activex_get_filename(clsid:clsid);
if (file)
{
  # Get its version.
  ver = activex_get_fileversion(clsid:clsid);

  if (ver) ver = string("Version ", ver);
  else ver = string("An unknown version");

  if (report_paranoia > 1)
    report = string(
      "\n",
      ver, " of the vulnerable control is installed as :\n",
      "\n",
      "  ", file, "\n",
      "\n",
      "Note, though, that Nessus did not check whether the 'kill' bit was\n",
      "set for the control's CLSID because of the Report Paranoia setting\n",
      "in effect when this scan was run.\n"
    );
  else if (activex_get_killbit(clsid:clsid) != TRUE)
    report = string(
      "\n",
      ver, " of the vulnerable control is installed as :\n",
      "\n",
      "  ", file, "\n",
      "\n",
      "Moreover, its 'kill' bit is not set so it is accessible via Internet\n",
      "Explorer.\n"
    );
  if (report)
  {
    if (report_verbosity) security_hole(port:kb_smb_transport(), extra:report);
    else security_hole(kb_smb_transport());
  }
}
activex_end();
