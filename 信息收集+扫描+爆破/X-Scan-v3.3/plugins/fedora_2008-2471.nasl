
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-2471
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(31435);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 8 2008-2471: roundup");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-2471 (roundup)");
 script_set_attribute(attribute: "description", value: "Roundup is a simple and flexible issue-tracking system with command line,
web and email interfaces.  It is based on the winning design from Ka-Ping
Yee in the Software Carpentry 'Track' design competition.

-
ChangeLog:


Update information :

* Fri Mar  7 2008 Paul P. Komkoff Jr <i stingr net> - 1.4.4-1
- new upstream version with security fixes (bz#436546)
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

script_summary(english: "Check for the version of the roundup package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"roundup-1.4.4-1.fc8", release:"FC8") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
