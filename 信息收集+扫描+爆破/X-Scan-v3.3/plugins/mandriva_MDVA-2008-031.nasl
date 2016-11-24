
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandriva Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(36934);
 script_version ("$Revision: 1.1 $");
 script_name(english: "MDVA-2008:031: x11-driver-video-openchrome");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDVA-2008:031 (x11-driver-video-openchrome).");
 script_set_attribute(attribute: "description", value: "The openchrome driver version shipped with Mandriva 2008.0 is not fully
functional with most chrome based video cards available in the market.
This update, requested by upstream developers, should correct the
problems, and provide a more mature driver.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDVA-2008:031");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the x11-driver-video-openchrome package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"x11-driver-video-openchrome-0.2.901-1.1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
