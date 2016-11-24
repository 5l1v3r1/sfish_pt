# This script was automatically generated from the 100-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20486);
script_version("$Revision: 1.5 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "100-1");
script_summary(english:"cdrtools vulnerability");
script_name(english:"USN100-1 : cdrtools vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- cdda2wav 
- cdrecord 
- cdrtools-doc 
- mkisofs 
');
script_set_attribute(attribute:'description', value: 'Javier Fern�ndez-Sanguino Pe�a noticed that cdrecord created temporary
files in an insecure manner if DEBUG was enabled in
/etc/cdrecord/rscsi. If the default value was used (which stored the
debug output file in /tmp), this could allow a symbolic link attack to
create or overwrite arbitrary files with the privileges of the user
invoking cdrecord.

Please note that DEBUG is not enabled by default in Ubuntu, so if you
did not explicitly enable it, this does not affect you.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- cdda2wav-2.0+a30.pre1-1ubuntu2.2 (Ubuntu 4.10)
- cdrecord-2.0+a30.pre1-1ubuntu2.2 (Ubuntu 4.10)
- cdrtools-doc-2.0+a30.pre1-1ubuntu2.2 (Ubuntu 4.10)
- mkisofs-2.0+a30.pre1-1ubuntu2.2 (Ubuntu 4.10)
');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();

exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "4.10", pkgname: "cdda2wav", pkgver: "2.0+a30.pre1-1ubuntu2.2");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package cdda2wav-',found,' is vulnerable in Ubuntu 4.10
Upgrade it to cdda2wav-2.0+a30.pre1-1ubuntu2.2
');
}
found = ubuntu_check(osver: "4.10", pkgname: "cdrecord", pkgver: "2.0+a30.pre1-1ubuntu2.2");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package cdrecord-',found,' is vulnerable in Ubuntu 4.10
Upgrade it to cdrecord-2.0+a30.pre1-1ubuntu2.2
');
}
found = ubuntu_check(osver: "4.10", pkgname: "cdrtools-doc", pkgver: "2.0+a30.pre1-1ubuntu2.2");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package cdrtools-doc-',found,' is vulnerable in Ubuntu 4.10
Upgrade it to cdrtools-doc-2.0+a30.pre1-1ubuntu2.2
');
}
found = ubuntu_check(osver: "4.10", pkgname: "mkisofs", pkgver: "2.0+a30.pre1-1ubuntu2.2");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package mkisofs-',found,' is vulnerable in Ubuntu 4.10
Upgrade it to mkisofs-2.0+a30.pre1-1ubuntu2.2
');
}

if (w) { security_hole(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
