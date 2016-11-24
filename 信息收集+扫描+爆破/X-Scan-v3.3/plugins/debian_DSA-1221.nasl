# This script was automatically generated from the dsa-1221
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(23743);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "1221");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1221 security update');
 script_set_attribute(attribute: 'description', value:
'<q>infamous41md</q> discovered a heap buffer overflow vulnerability in
libgsf, a GNOME library for reading and writing structured file
formats, which could lead to the execution of arbitrary code.
For the stable distribution (sarge) this problem has been fixed in
version 1.11.1-1sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1221');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your libgsf packages.');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1221] DSA-1221-1 libgsf");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1221-1 libgsf");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libgsf-1', release: '3.1', reference: '1.11.1-1sarge1');
deb_check(prefix: 'libgsf-1-dbg', release: '3.1', reference: '1.11.1-1sarge1');
deb_check(prefix: 'libgsf-1-dev', release: '3.1', reference: '1.11.1-1sarge1');
deb_check(prefix: 'libgsf-gnome-1', release: '3.1', reference: '1.11.1-1sarge1');
deb_check(prefix: 'libgsf-gnome-1-dbg', release: '3.1', reference: '1.11.1-1sarge1');
deb_check(prefix: 'libgsf-gnome-1-dev', release: '3.1', reference: '1.11.1-1sarge1');
deb_check(prefix: 'libgsf', release: '3.1', reference: '1.11.1-1sarge1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
