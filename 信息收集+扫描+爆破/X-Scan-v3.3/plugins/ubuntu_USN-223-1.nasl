# This script was automatically generated from the 223-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20766);
script_version("$Revision: 1.4 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "223-1");
script_summary(english:"inkscape vulnerability");
script_name(english:"USN223-1 : inkscape vulnerability");
script_set_attribute(attribute:'synopsis', value: 'The remote package "inkscape" is missing a security patch.');
script_set_attribute(attribute:'description', value: 'Javier Fern�ndez-Sanguino Pe�a discovered that Inkscape\'s ps2epsi.sh
script, which converts PostScript files to Encapsulated PostScript
format, creates a temporary file in an insecure way. A local attacker
could exploit this with a symlink attack to create or overwrite
arbitrary files with the privileges of the user running Inkscape.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- inkscape-0.40-2ubuntu1.1 (Ubuntu 5.04)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:N/I:P/A:N');
script_end_attributes();

script_cve_id("CVE-2005-3885");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "5.04", pkgname: "inkscape", pkgver: "0.40-2ubuntu1.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package inkscape-',found,' is vulnerable in Ubuntu 5.04
Upgrade it to inkscape-0.40-2ubuntu1.1
');
}

if (w) { security_note(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
