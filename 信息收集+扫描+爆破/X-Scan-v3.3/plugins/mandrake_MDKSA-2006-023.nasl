
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(20817);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKSA-2006:023: perl-Net_SSLeay");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2006:023 (perl-Net_SSLeay).");
 script_set_attribute(attribute: "description", value: "Javier Fernandez-Sanguino Pena discovered that the perl Net::SSLeay
module used the file /tmp/entropy as a fallback entropy source if a
proper source was not set via the environment variable EGD_PATH. This
could potentially lead to weakened cryptographic operations if an
attacker was able to provide a /tmp/entropy file with known content.
The updated packages have been patched to correct this problem.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2006:023");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2005-0106");
script_summary(english: "Check for the version of the perl-Net_SSLeay package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"perl-Net_SSLeay-1.25-4.1.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"perl-Net_SSLeay-1.25-4.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"perl-Net_SSLeay-1.25-4.1.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"perl-Net_SSLeay-", release:"MDK10.1")
 || rpm_exists(rpm:"perl-Net_SSLeay-", release:"MDK10.2")
 || rpm_exists(rpm:"perl-Net_SSLeay-", release:"MDK2006.0") )
{
 set_kb_item(name:"CVE-2005-0106", value:TRUE);
}
exit(0, "Host is not affected");
