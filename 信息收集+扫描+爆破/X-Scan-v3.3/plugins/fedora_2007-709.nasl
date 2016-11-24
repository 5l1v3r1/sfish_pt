
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2007-709
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(26115);
 script_version ("$Revision: 1.4 $");
script_name(english: "Fedora 6 2007-709: php");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2007-709 (php)");
 script_set_attribute(attribute: "description", value: "PHP is an HTML-embedded scripting language. PHP attempts to make it
easy for developers to write dynamically generated webpages. PHP also
offers built-in database integration for several commercial and
non-commercial database management systems, so writing a
database-enabled webpage with PHP is fairly simple. The most common
use of PHP coding is probably as a replacement for CGI scripts.

The php package contains the module which adds support for the PHP
language to Apache HTTP Server.

Update Information:

This update fixes a number of security issues in PHP:


Update information :

* various integer overflow flaws were found in the PHP gd
extension. A script that could be forced to resize images
from an untrusted source could possibly allow a remote
attacker to execute arbitrary code as the apache user.
(CVE-2007-3996)

");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-2756", "CVE-2007-2872", "CVE-2007-3799", "CVE-2007-3996", "CVE-2007-3998", "CVE-2007-4658", "CVE-2007-4670");
script_summary(english: "Check for the version of the php package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"php-snmp-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-cli-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-mysql-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-ldap-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-gd-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-pdo-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-soap-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-odbc-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-xml-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-imap-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-devel-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-pgsql-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-dba-5.1.6-3.7.fc6", release:"FC6") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
