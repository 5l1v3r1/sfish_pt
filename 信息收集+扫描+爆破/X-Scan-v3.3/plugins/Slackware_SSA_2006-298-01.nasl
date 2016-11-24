# This script was automatically generated from the SSA-2006-298-01
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(24657);
script_version("$Revision: 1.3 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2006-298-01 security update');
script_set_attribute(attribute:'description', value: '
New qt packages are available for Slackware 10.0, 10.1, 10.2, and 11.0
to fix a possible security issue.

More details about this issue may be found in the Common
Vulnerabilities and Exposures (CVE) database:

  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-4811

Trolltech has put out a press release which may be found here:

  http://www.trolltech.com/company/newsroom/announcements/press.2006-10-19.5434451733


');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2006-298-01");
script_summary("SSA-2006-298-01 qt ");
script_name(english: "SSA-2006-298-01 qt ");
script_cve_id("CVE-2006-4811");
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "10.0", pkgname: "qt", pkgver: "3.3.3", pkgnum:  "2", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package qt is vulnerable in Slackware 10.0
Upgrade to qt-3.3.3-i486-2_slack10.0 or newer.
');
}
if (slackware_check(osver: "10.1", pkgname: "qt", pkgver: "3.3.3", pkgnum:  "4", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package qt is vulnerable in Slackware 10.1
Upgrade to qt-3.3.3-i486-4_slack10.1 or newer.
');
}
if (slackware_check(osver: "10.2", pkgname: "qt", pkgver: "3.3.4", pkgnum:  "3", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package qt is vulnerable in Slackware 10.2
Upgrade to qt-3.3.4-i486-3_slack10.2 or newer.
');
}
if (slackware_check(osver: "11.0", pkgname: "qca-tls", pkgver: "1.0", pkgnum:  "3", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package qca-tls is vulnerable in Slackware 11.0
Upgrade to qca-tls-1.0-i486-3_slack11.0 or newer.
');
}
if (slackware_check(osver: "11.0", pkgname: "qt", pkgver: "3.3.7", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package qt is vulnerable in Slackware 11.0
Upgrade to qt-3.3.7-i486-1_slack11.0 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
