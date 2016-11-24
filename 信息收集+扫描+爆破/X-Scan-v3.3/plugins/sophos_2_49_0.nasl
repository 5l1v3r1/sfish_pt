#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(26002);
  script_version("$Revision: 1.7 $");

  script_cve_id("CVE-2007-4512", "CVE-2007-4787");
  script_bugtraq_id(25572, 25574);
  script_xref(name:"OSVDB", value:"37527");
  script_xref(name:"OSVDB", value:"37988");

  script_name(english:"Sophos Anti-Virus CAB, RAR and LZH Scanning Evasion");
  script_summary(english:"Checks version of Sophos engine"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an application that is affected by
multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The version of Sophos Anti-Virus installed on the remote host
reportedly contains several problems involving the processing of 'CAB'
'RAR' and 'LZH' files which may allow an attacker to evade the anti-
virus scanning by sending a specially-malformed archive. 

In addition, an attacker may exploit an HTML injection vulnerability
when processing a ZIP file." );
 script_set_attribute(attribute:"see_also", value:"http://www.sophos.com/support/knowledgebase/article/29146.html" );
 script_set_attribute(attribute:"solution", value:
"Update to Sophos Anti-Virus engine version 2.49.0 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

  script_dependencies("sophos_installed.nasl");
  script_require_keys("Antivirus/Sophos/installed", "Antivirus/Sophos/eng_ver");

  exit(0);
}


# Get the signature database update for the target.
engine = get_kb_item("Antivirus/Sophos/eng_ver");
if (!engine) exit(0);

ver = split(engine, sep:'.', keep:FALSE);
for (i=0; i<max_index(ver); i++)
  ver[i] = int(ver[i]);

fix = split("2.49.0", sep:'.', keep:FALSE);
for (i=0; i<max_index(fix); i++)
  fix[i] = int(fix[i]);

for (i=0; i<max_index(ver); i++)
  if ((ver[i] < fix[i]))
  {
    # nb: Sophos doesn't report the last part in its advisory.
    ver = string(ver[0], ".", ver[1], ".", ver[2]);
    report = string(
      "\n",
      "The current engine version on the remote is ", ver, ".\n"
    );
    security_warning(port:get_kb_item("SMB/transport"), extra:report);
    break;
  }
  else if (ver[i] > fix[i])
    break;
