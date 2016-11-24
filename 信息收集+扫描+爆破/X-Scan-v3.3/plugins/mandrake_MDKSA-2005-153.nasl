
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(19909);
 script_version ("$Revision: 1.5 $");
 script_name(english: "MDKSA-2005:153: gnumeric");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2005:153 (gnumeric).");
 script_set_attribute(attribute: "description", value: "Integer overflow in pcre_compile.c in Perl Compatible Regular
Expressions (PCRE) before 6.2, as used in multiple products, allows
attackers to execute arbitrary code via quantifier values in regular
expressions, which leads to a heap-based buffer overflow.
The gnumeric packages use a private copy of pcre code.
The updated packages have been patched to correct this problem.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2005:153");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2005-2491");
script_summary(english: "Check for the version of the gnumeric package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"gnumeric-1.2.13-3.1.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gnumeric-1.4.2-1.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"gnumeric-", release:"MDK10.1")
 || rpm_exists(rpm:"gnumeric-", release:"MDK10.2") )
{
 set_kb_item(name:"CVE-2005-2491", value:TRUE);
}
exit(0, "Host is not affected");
