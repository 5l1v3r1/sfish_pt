# This script was automatically generated from the SSA-2007-093-01
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(24916);
script_version("$Revision: 1.3 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2007-093-01 security update');
script_set_attribute(attribute:'description', value: '
New file packages are available for Slackware 8.1, 9.0, 9.1,
10.0, 10.1, 10.2, 11.0, and -current to fix a security issue.

NOTE:  In Slackware 11.0 and earlier, the file utility was part
of the required "bin" package, so this patch is needed even if
your machine does not have a "file" package installed (which,
if you\'re not running Slackware -current, it probably does not).

More details about this issue may be found in the Common
Vulnerabilities and Exposures (CVE) database:

  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-1536


');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2007-093-01");
script_summary("SSA-2007-093-01 file [and bin package] ");
script_name(english: "SSA-2007-093-01 file [and bin package] ");
script_cve_id("CVE-2007-1536");
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "8.1", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 8.1
Upgrade to file-4.20-i386-1_slack8.1 or newer.
');
}
if (slackware_check(osver: "9.0", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 9.0
Upgrade to file-4.20-i386-1_slack9.0 or newer.
');
}
if (slackware_check(osver: "9.1", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 9.1
Upgrade to file-4.20-i486-1_slack9.1 or newer.
');
}
if (slackware_check(osver: "10.0", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 10.0
Upgrade to file-4.20-i486-1_slack10.0 or newer.
');
}
if (slackware_check(osver: "10.1", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 10.1
Upgrade to file-4.20-i486-1_slack10.1 or newer.
');
}
if (slackware_check(osver: "10.2", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 10.2
Upgrade to file-4.20-i486-1_slack10.2 or newer.
');
}
if (slackware_check(osver: "11.0", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware 11.0
Upgrade to file-4.20-i486-1_slack11.0 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "file", pkgver: "4.20", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package file is vulnerable in Slackware -current
Upgrade to file-4.20-i486-1 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
