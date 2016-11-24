
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(14009);
 script_version ("$Revision: 1.6 $");
 script_name(english: "MDKSA-2003:025: webmin");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2003:025 (webmin).");
 script_set_attribute(attribute: "description", value: "A vulnerability was discovered in webmin by Cintia M. Imanishi, in the
miniserv.pl program, which is the core server of webmin. This
vulnerability allows an attacker to spoof a session ID by including
special metacharacters in the BASE64 encoding string used during the
authentication process. This could allow an attacker to gain full
administrative access to webmin.
MandrakeSoft encourages all users to upgrade immediately.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2003:025");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2003-0101");
script_summary(english: "Check for the version of the webmin package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"webmin-0.970-2.1mdk", release:"MDK7.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"webmin-0.970-2.2mdk", release:"MDK8.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"webmin-0.970-2.3mdk", release:"MDK8.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"webmin-0.970-2.3mdk", release:"MDK8.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"webmin-0.990-6.1mdk", release:"MDK9.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"webmin-", release:"MDK7.2")
 || rpm_exists(rpm:"webmin-", release:"MDK8.0")
 || rpm_exists(rpm:"webmin-", release:"MDK8.1")
 || rpm_exists(rpm:"webmin-", release:"MDK8.2")
 || rpm_exists(rpm:"webmin-", release:"MDK9.0") )
{
 set_kb_item(name:"CVE-2003-0101", value:TRUE);
}
exit(0, "Host is not affected");
