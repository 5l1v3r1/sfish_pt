
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(25597);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKA-2007:069: x11-driver-video-vesa");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKA-2007:069 (x11-driver-video-vesa).");
 script_set_attribute(attribute: "description", value: "X.org was crashing and/or corrupting the screen when the screen
is resized using the Resize and Rotate (randr) server extension.
The problem identified was that the vesa driver was trying to use
outdated values for its frame buffer, and so causing problem. The
updated package has a patch fixing this issue.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKA-2007:069");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the x11-driver-video-vesa package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"x11-driver-video-vesa-1.2.1-2.1mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
