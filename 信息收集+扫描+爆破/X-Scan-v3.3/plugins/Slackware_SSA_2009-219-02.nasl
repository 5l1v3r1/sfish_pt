# This script was automatically generated from the SSA-2009-219-02
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(40512);
script_version("$Revision: 1.1 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2009-219-02 security update');
script_set_attribute(attribute:'description', value: '
New apr packages are available for Slackware 11.0, 12.0, 12.1, 12.2,
and -current to fix a security issue.

More details about this issue may be found in the Common
Vulnerabilities and Exposures (CVE) database:

  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-2412


');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2009-219-02");
script_summary("SSA-2009-219-02 apr ");
script_name(english: "SSA-2009-219-02 apr ");
script_cve_id("CVE-2009-2412");
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "11.0", pkgname: "apr", pkgver: "1.3.8", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apr is vulnerable in Slackware 11.0
Upgrade to apr-1.3.8-i486-1_slack11.0 or newer.
');
}
if (slackware_check(osver: "12.0", pkgname: "apr", pkgver: "1.3.8", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apr is vulnerable in Slackware 12.0
Upgrade to apr-1.3.8-i486-1_slack12.0 or newer.
');
}
if (slackware_check(osver: "12.1", pkgname: "apr", pkgver: "1.3.8", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apr is vulnerable in Slackware 12.1
Upgrade to apr-1.3.8-i486-1_slack12.1 or newer.
');
}
if (slackware_check(osver: "12.2", pkgname: "apr", pkgver: "1.3.8", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apr is vulnerable in Slackware 12.2
Upgrade to apr-1.3.8-i486-1_slack12.2 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
