# This script was automatically generated from the dsa-1712
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(35547);
 script_version("$Revision: 1.2 $");
 script_xref(name: "DSA", value: "1712");
 script_cve_id("CVE-2009-0282");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1712 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that an integer overflow in the "Probe Request" packet
parser of the Ralinktech wireless drivers might lead to remote denial of
service or the execution of arbitrary code.
Please note that you need to rebuild your driver from the source
package in order to set this update into effect. Detailed
instructions can be found in /usr/share/doc/rt2400-source/README.Debian
For the stable distribution (etch), this problem has been fixed in
version 1.2.2+cvs20060620-4+etch1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2009/dsa-1712');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your rt2400 package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1712] DSA-1712-1 rt2400");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1712-1 rt2400");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'rt2400', release: '4.0', reference: '1.2.2+cvs20060620-4+etch1');
deb_check(prefix: 'rt2400-source', release: '4.0', reference: '1.2.2+cvs20060620-4+etch1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
