# This script was automatically generated from the dsa-1113
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22655);
 script_version("$Revision: 1.4 $");
 script_xref(name: "DSA", value: "1113");
 script_cve_id("CVE-2006-3458");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1113 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that the Zope web application server allows read access
to arbitrary pages on the server, if a user has the privilege to edit
"restructured text" pages.
For the stable distribution (sarge) this problem has been fixed in
version 2.7.5-2sarge2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1113');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your zope2.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:N/A:N');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1113] DSA-1113-1 zope2.7");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1113-1 zope2.7");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'zope2.7', release: '3.1', reference: '2.7.5-2sarge2');
if (deb_report_get()) security_note(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
