
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(24556);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKSA-2006:170-1: webmin");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2006:170-1 (webmin).");
 script_set_attribute(attribute: "description", value: "Webmin before 1.296 and Usermin before 1.226 does not properly handle a
URL with a null ('%00') character, which allows remote attackers to
conduct cross-site scripting (XSS), read CGI program source code, list
directories, and possibly execute programs.
Updated packages have been patched to correct this issue.
Update:
Packages are now available for Mandriva Linux 2007.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2006:170-1");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2006-4542");
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

if ( rpm_check( reference:"webmin-1.290-4.1mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"webmin-1.290-4.1mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"webmin-", release:"MDK2007.0") )
{
 set_kb_item(name:"CVE-2006-4542", value:TRUE);
}
exit(0, "Host is not affected");
