
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(13937);
 script_version ("$Revision: 1.7 $");
 script_name(english: "MDKSA-2002:031: fileutils");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2002:031 (fileutils).");
 script_set_attribute(attribute: "description", value: "Wojciech Purczynski reported a race condition in some utilities in the
GNU fileutils package that may cause root to delete the entire
filesystem. This only affects version 4.1 stable and 4.1.6 development
versions, and the authors have fixed this in the latest development
version.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:H/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2002:031");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2002-0435");
script_summary(english: "Check for the version of the fileutils package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"fileutils-4.1-4.1mdk", release:"MDK8.1", yank:"mdk") )
{
 security_note(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"fileutils-4.1.5-4.1mdk", release:"MDK8.2", yank:"mdk") )
{
 security_note(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"fileutils-", release:"MDK8.1")
 || rpm_exists(rpm:"fileutils-", release:"MDK8.2") )
{
 set_kb_item(name:"CVE-2002-0435", value:TRUE);
}
exit(0, "Host is not affected");
