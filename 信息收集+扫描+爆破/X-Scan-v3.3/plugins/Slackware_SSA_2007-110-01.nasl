# This script was automatically generated from the SSA-2007-110-01
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(25094);
script_version("$Revision: 1.3 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2007-110-01 security update');
script_set_attribute(attribute:'description', value: '
A new x11-6.9.0-i486-14_slack11.0.tgz patch is available for Slackware 11.0 to
fix the inadvertent inclusion of two old fontconfig binaries.  Installing the
original fontconfig patch followed by the original x11 patch would cause
fc-cache and fc-list to be overwritten by old versions, breaking fontconfig.

To fix the issue, reinstall the fontconfig patch.  The x11 package has been
updated so that installation will not be order-specific for anyone fetching
the patches now.

Sorry for the inconvenience.


');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2007-110-01");
script_summary("SSA-2007-110-01 Slackware 11.0 x11-6.9.0 patch fix ");
script_name(english: "SSA-2007-110-01 Slackware 11.0 x11-6.9.0 patch fix ");
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "11.0", pkgname: "x11", pkgver: "6.9.0", pkgnum:  "14", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package x11 is vulnerable in Slackware 11.0
Upgrade to x11-6.9.0-i486-14_slack11.0 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
