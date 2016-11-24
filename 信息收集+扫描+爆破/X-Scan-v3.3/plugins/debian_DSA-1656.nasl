# This script was automatically generated from the dsa-1656
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(34449);
 script_version("$Revision: 1.4 $");
 script_xref(name: "DSA", value: "1656");
 script_cve_id("CVE-2008-3639", "CVE-2008-3640", "CVE-2008-3641");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1656 security update');
 script_set_attribute(attribute: 'description', value:
'Several local vulnerabilities have been discovered in the Common UNIX
Printing System. The Common Vulnerabilities and Exposures project
identifies the following problems:
CVE-2008-3639
    It was discovered that insufficient bounds checking in the SGI
    image filter may lead to the execution of arbitrary code.
CVE-2008-3640
    It was discovered that an integer overflow in the Postscript
    conversion tool <q>texttops</q> may lead to the execution of arbitrary
    code.
CVE-2008-3641
    It was discovered that insufficient bounds checking in the HPGL
    filter may lead to the execution of arbitrary code.
For the stable distribution (etch), these problems have been fixed in
version 1.2.7-4etch5.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2008/dsa-1656');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your cupsys package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1656] DSA-1656-1 cupsys");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1656-1 cupsys");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'cupsys', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'cupsys-bsd', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'cupsys-client', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'cupsys-common', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'cupsys-dbg', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'libcupsimage2', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'libcupsimage2-dev', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'libcupsys2', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'libcupsys2-dev', release: '4.0', reference: '1.2.7-4etch5');
deb_check(prefix: 'libcupsys2-gnutls10', release: '4.0', reference: '1.2.7-4etch5');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
