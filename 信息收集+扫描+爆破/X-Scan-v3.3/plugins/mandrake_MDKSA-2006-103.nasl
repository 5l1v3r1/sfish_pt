
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(21718);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKSA-2006:103: spamassassin");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2006:103 (spamassassin).");
 script_set_attribute(attribute: "description", value: "A flaw was discovered in the way that spamd processes the virtual POP
usernames passed to it. If running with the --vpopmail and --paranoid
flags, it is possible for a remote user with the ability to connect to
the spamd daemon to execute arbitrary commands as the user running
spamd.
By default, the Spamassassin packages do not start spamd with either
of these flags and this usage is uncommon.
The updated packages have been patched to correct this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2006:103");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2006-2447");
script_summary(english: "Check for the version of the spamassassin package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"perl-Mail-SpamAssassin-3.0.4-0.3.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-3.0.4-0.3.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-spamc-3.0.4-0.3.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-spamd-3.0.4-0.3.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-tools-3.0.4-0.3.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"perl-Mail-SpamAssassin-3.0.4-3.3.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-3.0.4-3.3.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-spamc-3.0.4-3.3.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-spamd-3.0.4-3.3.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"spamassassin-tools-3.0.4-3.3.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"spamassassin-", release:"MDK10.2")
 || rpm_exists(rpm:"spamassassin-", release:"MDK2006.0") )
{
 set_kb_item(name:"CVE-2006-2447", value:TRUE);
}
exit(0, "Host is not affected");
