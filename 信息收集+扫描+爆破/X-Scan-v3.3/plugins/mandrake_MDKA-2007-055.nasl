
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(25536);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKA-2007:055: gnome-games");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKA-2007:055 (gnome-games).");
 script_set_attribute(attribute: "description", value: "A packaging error was disabling the high score support in various
games shipped in the gnome-games package. This issue is fixed,
as well as several other bugs and translation additions.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKA-2007:055");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the gnome-games package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"gnome-games-2.16.3-1.1mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gnome-games-2.18.2-2.1mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
