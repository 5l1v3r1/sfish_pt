# This script was automatically generated from the dsa-337
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15174);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "337");
 script_cve_id("CVE-2003-0444");
 script_bugtraq_id(8061);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-337 security update');
 script_set_attribute(attribute: 'description', value:
'Viliam Holub discovered a bug in gtksee whereby, when loading PNG
images of certain color depths, gtksee would overflow a heap-allocated
buffer.  This vulnerability could be exploited by an attacker using a
carefully constructed PNG image to execute arbitrary code when the
victim loads the file in gtksee.
For the stable distribution (woody) this problem has been fixed in
version 0.5.0-6.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2003/dsa-337');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2003/dsa-337
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA337] DSA-337-1 gtksee");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-337-1 gtksee");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'gtksee', release: '3.0', reference: '0.5.0-6');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
