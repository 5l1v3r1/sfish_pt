# This script was automatically generated from the dsa-205
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15042);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "205");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-205 security update');
 script_set_attribute(attribute: 'description', value:
'Steve Kemp and James Antill found several buffer overflows in the
gtetrinet (a multiplayer tetris-like game) package as shipped in
Debian GNU/Linux 3.0, which could be abused by a malicious server.
This has been fixed in upstream version 0.4.4 and release
0.4.1-9woody1.1 of the Debian package.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2002/dsa-205');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2002/dsa-205
and install the recommended updated packages.');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA205] DSA-205-1 gtetrinet");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-205-1 gtetrinet");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'gtetrinet', release: '3.0', reference: '0.4.1-9woody1.1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
