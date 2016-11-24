#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(33485);
  script_version("$Revision: 1.3 $");

  script_cve_id("CVE-2008-2430");
  script_bugtraq_id(30058);
  script_xref(name:"OSVDB", value:"46660");

  script_name(english:"VLC Media Player < 0.8.6i WAV File Handling Integer Overflow");
  script_summary(english:"Checks version of VLC");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host contains an application that is affected by an
integer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The installed version of VLC media player is affected by an integer
overflow vulnerability.  By tricking a user into opening a malicious
.WAV file, it may be possible to cause a denial of service condition
or execute arbitrary code within the context of the affected
application." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/493849" );
 script_set_attribute(attribute:"see_also", value:"http://wiki.videolan.org/Changelog/0.8.6i" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to VLC Media Player version 0.8.6i or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("vlc_installed.nasl");
  script_require_keys("SMB/VLC/Version");

  exit(0);
}

include("global_settings.inc");

ver = get_kb_item("SMB/VLC/Version");
if (ver && tolower(ver) =~ "^0\.([0-7]\.|8\.([0-5]|6($|[a-h]$)))")
{
  if (report_verbosity)
  {
    report = string(
      "\n",
      "VLC Media Player version ", ver, " is currently installed on the remote host.\n"
    );
    security_hole(port:get_kb_item("SMB/transport"), extra:report);
  }
  else security_hole(get_kb_item("SMB/transport"));
}
