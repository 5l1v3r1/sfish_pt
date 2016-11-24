
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandriva Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(36606);
 script_version ("$Revision: 1.1 $");
 script_name(english: "MDVSA-2009:048-2: epiphany");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDVSA-2009:048-2 (epiphany).");
 script_set_attribute(attribute: "description", value: "Python has a variable called sys.path that contains all paths where
Python loads modules by using import scripting procedure. A wrong
handling of that variable enables local attackers to execute arbitrary
code via Python scripting in the current Epiphany working directory
(CVE-2008-5985).
This update provides fix for that vulnerability.
Update:
The previous update package was not built against the correct (latest)
libxulrunner-1.9.0.6 library (fixes #48163)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDVSA-2009:048-2");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2008-5985");
script_summary(english: "Check for the version of the epiphany package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"epiphany-2.22.3-0.3mdv2008.1", release:"MDK2008.1", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"epiphany-devel-2.22.3-0.3mdv2008.1", release:"MDK2008.1", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"epiphany-", release:"MDK2008.1") )
{
 set_kb_item(name:"CVE-2008-5985", value:TRUE);
}
exit(0, "Host is not affected");
