
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(13898);
 script_version ("$Revision: 1.5 $");
 script_name(english: "MDKSA-2001:085: procmail");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2001:085 (procmail).");
 script_set_attribute(attribute: "description", value: "In older versions of procmail, it is possible to crash procmail by
sending it certain signals. If procmail is installed setuid, this
could be exploited to gain unauthorized privilege. This problem is
fixed in unstable version 3.20 and stable version 3.15.2.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2001:085");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the procmail package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"procmail-3.15.2-1.4mdk", release:"MDK7.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"procmail-3.15.2-1.3mdk", release:"MDK7.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"procmail-3.15.2-1.2mdk", release:"MDK8.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"procmail-3.22-1.1mdk", release:"MDK8.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
