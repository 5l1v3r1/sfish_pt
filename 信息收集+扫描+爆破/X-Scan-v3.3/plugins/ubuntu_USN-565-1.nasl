# This script was automatically generated from the 565-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(29921);
script_version("$Revision: 1.3 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "565-1");
script_summary(english:"Squid vulnerability");
script_name(english:"USN565-1 : Squid vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- squid 
- squid-cgi 
- squid-common 
- squidclient 
');
script_set_attribute(attribute:'description', value: 'It was discovered that Squid did not always clean up cache memory
correctly.  A remote attacker could manipulate cache update replies and
cause Squid to use all available memory, leading to a denial of service.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- squid-2.6.14-1ubuntu2.1 (Ubuntu 7.10)
- squid-cgi-2.6.14-1ubuntu2.1 (Ubuntu 7.10)
- squid-common-2.6.14-1ubuntu2.1 (Ubuntu 7.10)
- squidclient-2.6.14-1ubuntu2.1 (Ubuntu 7.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

script_cve_id("CVE-2007-6239");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "7.10", pkgname: "squid", pkgver: "2.6.14-1ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package squid-',found,' is vulnerable in Ubuntu 7.10
Upgrade it to squid-2.6.14-1ubuntu2.1
');
}
found = ubuntu_check(osver: "7.10", pkgname: "squid-cgi", pkgver: "2.6.14-1ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package squid-cgi-',found,' is vulnerable in Ubuntu 7.10
Upgrade it to squid-cgi-2.6.14-1ubuntu2.1
');
}
found = ubuntu_check(osver: "7.10", pkgname: "squid-common", pkgver: "2.6.14-1ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package squid-common-',found,' is vulnerable in Ubuntu 7.10
Upgrade it to squid-common-2.6.14-1ubuntu2.1
');
}
found = ubuntu_check(osver: "7.10", pkgname: "squidclient", pkgver: "2.6.14-1ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package squidclient-',found,' is vulnerable in Ubuntu 7.10
Upgrade it to squidclient-2.6.14-1ubuntu2.1
');
}

if (w) { security_warning(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
