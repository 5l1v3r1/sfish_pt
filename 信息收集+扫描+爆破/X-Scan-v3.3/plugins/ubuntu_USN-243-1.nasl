# This script was automatically generated from the 243-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20790);
script_version("$Revision: 1.4 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "243-1");
script_summary(english:"tuxpaint vulnerability");
script_name(english:"USN243-1 : tuxpaint vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- tuxpaint 
- tuxpaint-data 
');
script_set_attribute(attribute:'description', value: 'Javier Fern�ndez-Sanguino Pe�a discovered that the tuxpaint-import.sh
script created a temporary file in an insecure way. This could allow a
symlink attack to create or overwrite arbitrary files with the
privileges of the user running tuxpaint.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- tuxpaint-0.9.14-2ubuntu0.1 (Ubuntu 5.10)
- tuxpaint-data-0.9.14-2ubuntu0.1 (Ubuntu 5.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

script_cve_id("CVE-2005-3340");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "5.10", pkgname: "tuxpaint", pkgver: "0.9.14-2ubuntu0.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package tuxpaint-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to tuxpaint-0.9.14-2ubuntu0.1
');
}
found = ubuntu_check(osver: "5.10", pkgname: "tuxpaint-data", pkgver: "0.9.14-2ubuntu0.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package tuxpaint-data-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to tuxpaint-data-0.9.14-2ubuntu0.1
');
}

if (w) { security_hole(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
