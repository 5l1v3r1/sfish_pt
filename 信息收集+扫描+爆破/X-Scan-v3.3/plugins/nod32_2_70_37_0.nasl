#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(25293);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2007-2852");
  script_bugtraq_id(24098);
  script_xref(name:"OSVDB", value:"36650");

  script_name(english:"NOD32 Long Path Name Stack Overflow Vulnerabilities");
  script_summary(english:"Checks version of NOD32"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an application that is affected by
multiple buffer overflow vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The version of NOD32 installed on the remote host reportedly contains
two stack overflow vulnerabilities that can be triggered when the
application tries to delete, disinfect, or rename an infected file in
a specially-formatted directory.  A remote attacker may be able to
leverage these issues to execute code remotely or crash the affected
service." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/469300/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://www.eset.com/support/news.php" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to NOD32 v2.70.37 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

  script_dependencies("nod32_installed.nasl");
  script_require_keys("Antivirus/NOD32/version");

  exit(0);
}


ver = get_kb_item("Antivirus/NOD32/version");
if (isnull(ver)) exit(0);

iver = split(ver, sep:'.', keep:FALSE);
for (i=0; i<max_index(iver); i++)
  iver[i] = int(iver[i]);

if (
  iver[0] < 2 ||
  (
    iver[0] == 2 &&
    (
      iver[1] < 70 ||
      (iver[1] == 70 && iver[2] < 37)
    )
  )
) 
{
  # nb: the GUI only reports 3 parts of the version.
  version = string(iver[0], ".", iver[1], ".", iver[2]);
  report = desc + string(
    "\n",
    "Version ", version, " of the NOD32 Antivirus System is currently installed\n",
    "on the remote host.\n"
  );
  security_hole(port:get_kb_item("SMB/transport"), extra:report);
}
