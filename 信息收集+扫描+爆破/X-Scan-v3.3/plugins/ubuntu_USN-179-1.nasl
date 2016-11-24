# This script was automatically generated from the 179-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20589);
script_version("$Revision: 1.5 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "179-1");
script_summary(english:"openssl weak default configuration");
script_name(english:"USN179-1 : openssl weak default configuration");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- libssl-dev 
- libssl0.9.7 
- openssl 
');
script_set_attribute(attribute:'description', value: 'The current default algorithm for creating "message digests"
(electronic signatures) for certificates created by openssl is MD5.
However, this algorithm is not deemed secure any more, and some
practical attacks have been demonstrated which could allow an attacker
to forge certificates with a valid certification authority signature
even if he does not know the secret CA signing key.

Therefore all Ubuntu versions of openssl have now been changed to use
SHA-1 by default. This is a more appropriate default algorithm for
the majority of use cases; however, if you still want to use MD5 as
default, you can revert this change by changing the two instances of
"default_md = sha1" to "default_md = md5" in /etc/ssl/openssl.cnf.

A detailed explanation and further links can be found at

  http://www.cits.rub.de/MD5Collisions/');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- libssl-dev-0.9.7e-3ubuntu0.1 (Ubuntu 5.04)
- libssl0.9.7-0.9.7e-3ubuntu0.1 (Ubuntu 5.04)
- openssl-0.9.7e-3ubuntu0.1 (Ubuntu 5.04)
');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();

exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "5.04", pkgname: "libssl-dev", pkgver: "0.9.7e-3ubuntu0.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libssl-dev-',found,' is vulnerable in Ubuntu 5.04
Upgrade it to libssl-dev-0.9.7e-3ubuntu0.1
');
}
found = ubuntu_check(osver: "5.04", pkgname: "libssl0.9.7", pkgver: "0.9.7e-3ubuntu0.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libssl0.9.7-',found,' is vulnerable in Ubuntu 5.04
Upgrade it to libssl0.9.7-0.9.7e-3ubuntu0.1
');
}
found = ubuntu_check(osver: "5.04", pkgname: "openssl", pkgver: "0.9.7e-3ubuntu0.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package openssl-',found,' is vulnerable in Ubuntu 5.04
Upgrade it to openssl-0.9.7e-3ubuntu0.1
');
}

if (w) { security_hole(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
