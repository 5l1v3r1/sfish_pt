# This script was automatically generated from the 411-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(28000);
script_version("$Revision: 1.3 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "411-1");
script_summary(english:"libsoup vulnerability");
script_name(english:"USN411-1 : libsoup vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- libsoup2.2-8 
- libsoup2.2-dev 
- libsoup2.2-doc 
');
script_set_attribute(attribute:'description', value: 'Roland Lezuo and Josselin Mouette discovered that the HTTP server code 
in libsoup did not correctly verify request headers.  Remote attackers 
could crash applications using libsoup by sending a crafted HTTP 
request, resulting in a denial of service.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- libsoup2.2-8-2.2.96-0ubuntu2.1 (Ubuntu 6.10)
- libsoup2.2-dev-2.2.96-0ubuntu2.1 (Ubuntu 6.10)
- libsoup2.2-doc-2.2.96-0ubuntu2.1 (Ubuntu 6.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:C');
script_end_attributes();

script_cve_id("CVE-2006-5876");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "6.10", pkgname: "libsoup2.2-8", pkgver: "2.2.96-0ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libsoup2.2-8-',found,' is vulnerable in Ubuntu 6.10
Upgrade it to libsoup2.2-8-2.2.96-0ubuntu2.1
');
}
found = ubuntu_check(osver: "6.10", pkgname: "libsoup2.2-dev", pkgver: "2.2.96-0ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libsoup2.2-dev-',found,' is vulnerable in Ubuntu 6.10
Upgrade it to libsoup2.2-dev-2.2.96-0ubuntu2.1
');
}
found = ubuntu_check(osver: "6.10", pkgname: "libsoup2.2-doc", pkgver: "2.2.96-0ubuntu2.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package libsoup2.2-doc-',found,' is vulnerable in Ubuntu 6.10
Upgrade it to libsoup2.2-doc-2.2.96-0ubuntu2.1
');
}

if (w) { security_hole(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
