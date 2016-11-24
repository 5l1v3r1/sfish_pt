#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(25573);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2007-3410");
  script_bugtraq_id(24658);
  script_xref(name:"OSVDB", value:"37374");
  script_xref(name:"OSVDB", value:"38342");

  script_name(english:"RealPlayer for Windows < Build 6.0.12.1578");
  script_summary(english:"Checks RealPlayer build number");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows application is affected by a buffer overflow
vulnerability." );
 script_set_attribute(attribute:"description", value:
"According to its build number, the installed version of RealPlayer on
the remote Windows host contains a stack buffer overflow that can be
triggered by a specially-crafted SMIL file, perhaps accessed over the
web using the CLSID 'CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA'.  A remote
attacker may be able to exploit this issue to execute arbitrary code
subject to the user's privileges on the affected host." );
 script_set_attribute(attribute:"see_also", value:"http://labs.idefense.com/intelligence/vulnerabilities/display.php?id=547" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/472295/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrading to the latest version of the product supposedly resolves the
issue, although the vendor has not confirmed that." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

  script_dependencies("realplayer_detect.nasl");
  script_require_keys("SMB/RealPlayer/Product", "SMB/RealPlayer/Build");

  exit(0);
}


include("global_settings.inc");


# nb: there's no information regarding whether RealOne Player 
#     or RealPlayer Enterprise are also affected.
prod = get_kb_item("SMB/RealPlayer/Product");
if (!prod || prod != "RealPlayer") exit(0);


# There's a problem if the build is before 6.0.12.1578.
build = get_kb_item("SMB/RealPlayer/Build");
if (!build) exit(0);

ver = split(build, sep:'.', keep:FALSE);
if (
  int(ver[0]) < 6 ||
  (
    int(ver[0]) == 6 &&
    int(ver[1]) == 0 && 
    (
      int(ver[2]) < 12 ||
      (int(ver[2]) == 12 && int(ver[3]) < 1578)
    )
  )
)
{
  if (report_verbosity)
  {
    report = string(
      "\n",
      prod, " build ", build, " is installed on the remote host.\n"
    );
    security_hole(port:get_kb_item("SMB/transport"), extra:report);
  }
  else security_hole(get_kb_item("SMB/transport"));
}
