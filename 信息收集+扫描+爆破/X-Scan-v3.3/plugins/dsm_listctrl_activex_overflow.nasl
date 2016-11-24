#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(31731);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2008-1472");
  script_bugtraq_id(28268);
  script_xref(name:"OSVDB", value:"43214");
  script_xref(name:"Secunia", value:"29408");
  script_xref(name:"milw0rm", value:"5264");

  script_name(english:"CA BrightStor ARCserve Backup ListCtrl ActiveX (ListCtrl.ocx) AddColumn() Method Overflow");
  script_summary(english:"Checks for ListCtrl control");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an ActiveX control that is affected by a
buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The version of the ListCtrl ActiveX control included with various
CA products and installed on the remote host contains a buffer overflow
that can be triggered by a long argument to the 'AddColumn' method. 
If an attacker can trick a user on the affected host into visiting a
specially- crafted web page, he may be able to use this method to
execute arbitrary code on the affected system subject to the user's
privileges." );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?d3b71283" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2008-03/0567.html" );
 script_set_attribute(attribute:"solution", value:
"Apply the appropriate patch as described in the vendor advisory
referenced above." );
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


# Locate the file used by the controls.
if (activex_init() != ACX_OK) exit(0);

clsid = "{BF6EFFF3-4558-4C4C-ADAF-A87891C5F3A3}";
file = activex_get_filename(clsid:clsid);
if (file)
{
  ver = activex_get_fileversion(clsid:clsid);

  if (ver =~ "^11\.1") fix = "11.1.8124.0";
  else if (ver =~ "^11\.2") fix = "11.2.1000.16";
  else fix = "";

  if (ver && fix && activex_check_fileversion(clsid:clsid, fix:fix) == TRUE)
  {
    report = NULL;

    if (report_paranoia > 1)
      report = string(
        "\n",
        "Version ", ver, " of the vulnerable control is installed as :\n",
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
        "Version ", ver, " of the vulnerable control is installed as :\n",
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
}
activex_end();
