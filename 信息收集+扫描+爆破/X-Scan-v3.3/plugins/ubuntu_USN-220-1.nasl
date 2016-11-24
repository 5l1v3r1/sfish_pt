# This script was automatically generated from the 220-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20762);
script_version("$Revision: 1.4 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "220-1");
script_summary(english:"w3c-libwww vulnerability");
script_name(english:"USN220-1 : w3c-libwww vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- libwww-dev 
- libwww-ssl-dev 
- libwww-ssl0 
- libwww0 
');
script_set_attribute(attribute:'description', value: 'Sam Varshavchik discovered several buffer overflows in the
HTBoundary_put_block() function. By sending specially crafted HTTP
multipart/byteranges MIME messages, a malicious HTTP server could
trigger an out of bounds memory access in the libwww library, which
causes the program that uses the library to crash.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- libwww-dev-5.4.0-9ubuntu0.5.10 (Ubuntu 5.10)
- libwww-ssl-dev-5.4.0-9ubuntu0.5.10 (Ubuntu 5.10)
- libwww-ssl0-5.4.0-9ubuntu0.5.10 (Ubuntu 5.10)
- libwww0-5.4.0-9ubuntu0.5.10 (Ubuntu 5.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:N/I:N/A:P');
script_end_attributes();

script_cve_id("CVE-2005-3183");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "5.10", pkgname: "libwww-dev", pkgver: "5.4.0-9ubuntu0.5.10");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libwww-dev-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to libwww-dev-5.4.0-9ubuntu0.5.10
');
}
found = ubuntu_check(osver: "5.10", pkgname: "libwww-ssl-dev", pkgver: "5.4.0-9ubuntu0.5.10");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libwww-ssl-dev-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to libwww-ssl-dev-5.4.0-9ubuntu0.5.10
');
}
found = ubuntu_check(osver: "5.10", pkgname: "libwww-ssl0", pkgver: "5.4.0-9ubuntu0.5.10");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libwww-ssl0-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to libwww-ssl0-5.4.0-9ubuntu0.5.10
');
}
found = ubuntu_check(osver: "5.10", pkgname: "libwww0", pkgver: "5.4.0-9ubuntu0.5.10");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libwww0-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to libwww0-5.4.0-9ubuntu0.5.10
');
}

if (w) { security_warning(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
