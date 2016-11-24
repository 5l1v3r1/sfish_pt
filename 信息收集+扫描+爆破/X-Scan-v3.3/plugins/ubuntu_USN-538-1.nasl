# This script was automatically generated from the 538-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(28145);
script_version("$Revision: 1.3 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "538-1");
script_summary(english:"libpng vulnerabilities");
script_name(english:"USN538-1 : libpng vulnerabilities");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- libpng12-0 
- libpng12-dev 
- libpng3 
');
script_set_attribute(attribute:'description', value: 'It was discovered that libpng did not properly perform bounds checking
and comparisons in certain operations. An attacker could send a specially
crafted PNG image and cause a denial of service in applications linked
against libpng.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- libpng12-0-1.2.8rel-5.1ubuntu0.3 (Ubuntu 6.10)
- libpng12-dev-1.2.8rel-5.1ubuntu0.3 (Ubuntu 6.10)
- libpng3-1.2.8rel-5.1ubuntu0.3 (Ubuntu 6.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

script_cve_id("CVE-2007-5268","CVE-2007-5269");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "6.10", pkgname: "libpng12-0", pkgver: "1.2.8rel-5.1ubuntu0.3");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libpng12-0-',found,' is vulnerable in Ubuntu 6.10
Upgrade it to libpng12-0-1.2.8rel-5.1ubuntu0.3
');
}
found = ubuntu_check(osver: "6.10", pkgname: "libpng12-dev", pkgver: "1.2.8rel-5.1ubuntu0.3");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libpng12-dev-',found,' is vulnerable in Ubuntu 6.10
Upgrade it to libpng12-dev-1.2.8rel-5.1ubuntu0.3
');
}
found = ubuntu_check(osver: "6.10", pkgname: "libpng3", pkgver: "1.2.8rel-5.1ubuntu0.3");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libpng3-',found,' is vulnerable in Ubuntu 6.10
Upgrade it to libpng3-1.2.8rel-5.1ubuntu0.3
');
}

if (w) { security_warning(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
