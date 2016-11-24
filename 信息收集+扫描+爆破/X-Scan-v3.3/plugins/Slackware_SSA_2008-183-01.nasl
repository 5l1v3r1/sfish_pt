# This script was automatically generated from the SSA-2008-183-01
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(33398);
script_version("$Revision: 1.3 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2008-183-01 security update');
script_set_attribute(attribute:'description', value: '
New xorg-server packages are available for Slackware 12.1 and -current to
fix security issues in xorg-server 1.4 prior to version 1.4.2.

More details about the issues may be found in the Common
Vulnerabilities and Exposures (CVE) database:

  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-1377
  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-1379
  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-2360
  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-2361
  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-2362


');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2008-183-01");
script_summary("SSA-2008-183-01 xorg-server ");
script_name(english: "SSA-2008-183-01 xorg-server ");
script_cve_id("CVE-2008-1377","CVE-2008-1379","CVE-2008-2360","CVE-2008-2361","CVE-2008-2362");
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "12.1", pkgname: "xorg-server", pkgver: "1.4.2", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package xorg-server is vulnerable in Slackware 12.1
Upgrade to xorg-server-1.4.2-i486-1_slack12.1 or newer.
');
}
if (slackware_check(osver: "12.1", pkgname: "xorg-server-xnest", pkgver: "1.4.2", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package xorg-server-xnest is vulnerable in Slackware 12.1
Upgrade to xorg-server-xnest-1.4.2-i486-1_slack12.1 or newer.
');
}
if (slackware_check(osver: "12.1", pkgname: "xorg-server-xvfb", pkgver: "1.4.2", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package xorg-server-xvfb is vulnerable in Slackware 12.1
Upgrade to xorg-server-xvfb-1.4.2-i486-1_slack12.1 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "xorg-server", pkgver: "1.4.2", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package xorg-server is vulnerable in Slackware -current
Upgrade to xorg-server-1.4.2-i486-1 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "xorg-server-xnest", pkgver: "1.4.2", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package xorg-server-xnest is vulnerable in Slackware -current
Upgrade to xorg-server-xnest-1.4.2-i486-1 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "xorg-server-xvfb", pkgver: "1.4.2", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package xorg-server-xvfb is vulnerable in Slackware -current
Upgrade to xorg-server-xvfb-1.4.2-i486-1 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
