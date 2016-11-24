# This script was automatically generated from the dsa-326
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15163);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "326");
 script_cve_id("CVE-2003-0441");
 script_bugtraq_id(7988);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-326 security update');
 script_set_attribute(attribute: 'description', value:
'Orville Write, a replacement for the standard write(1) command,
contains a number of buffer overflows.  These could be exploited to
gain either gid tty or root privileges, depending on the configuration
selected when the package is installed.
For the stable distribution (woody) this problem has been fixed in
version 2.53-4woody1.
The old stable distribution (potato) does not contain an orville-write
package.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2003/dsa-326');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2003/dsa-326
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA326] DSA-326-1 orville-write");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-326-1 orville-write");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'orville-write', release: '3.0', reference: '2.53-4woody1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
