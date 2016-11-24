#
#  This script was written by David Maciejak <david dot maciejak at kyxar dot fr>
#
#  based on work from Tenable Network Security
#
#  Ref: Marcel Boesch <marboesc@student.ethz.ch>.
#
# This script is released under the GNU GPLv2

# Changes by Tenable:
# - Revised plugin title, output formatting and touch-ups (10/26/09)


include("compat.inc");

if(description)
{
 script_id(14668);
 script_version("$Revision: 1.14 $");
 script_cve_id("CVE-2004-0758");
 script_bugtraq_id(10703);
 script_xref(name:"OSVDB", value:"7939");

 script_name(english:"Mozilla Multiple Browsers CA Certificate SSL Page DoS");

 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has a web browser installed that is affected
by a denial-of-service vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is using Mozilla, an alternative web browser.

The Mozilla Personal Security Manager (PSM) contains a flaw
that may permit a attacker to import silently a certificate into
the PSM certificate store. This corruption may result in a denial
of SSL connections." );
 script_set_attribute(attribute:"see_also", value:"https://bugzilla.mozilla.org/show_bug.cgi?id=249004" );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=bugtraq&m=109900315219363&w=2" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to the latest version of this software." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );

script_end_attributes();

 script_summary(english:"Determines the version of Mozilla/Firefox");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2004-2009 David Maciejak");
 script_family(english:"Windows");
 script_dependencies("mozilla_org_installed.nasl");
 if ( NASL_LEVEL >= 3206 ) script_require_ports("Mozilla/Version", "Mozilla/Firefox/Version", "Mozilla/Thunderbird/Version");
 exit(0);
}

#

include("misc_func.inc");

ver = read_version_in_kb("Mozilla/Version");
if (!isnull(ver)) 
{
  if (
    ver[0] < 1 ||
    (
      ver[0] == 1 &&
      (
        ver[1] < 7 ||
        (ver[1] == 7 && ver[2] < 1)
      )
    )
  )  security_warning(get_kb_item("SMB/transport"));
}

ver = read_version_in_kb("Mozilla/Firefox/Version");
if (!isnull(ver))
{
  if (
    ver[0] == 0 && 
    (
      ver[1] < 9 ||
      (ver[1] == 9 && ver[2] < 3)
    )
  )  security_warning(get_kb_item("SMB/transport"));
}

ver = read_version_in_kb("Mozilla/Thunderbird/Version");
if (!isnull(ver))
{
  if (ver[0] == 0 && ver[1] < 8)
    security_warning(get_kb_item("SMB/transport"));
}
