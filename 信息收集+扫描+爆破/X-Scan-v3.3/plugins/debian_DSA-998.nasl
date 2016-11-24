# This script was automatically generated from the dsa-998
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22864);
 script_version("$Revision: 1.5 $");
 script_xref(name: "DSA", value: "998");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-998 security update');
 script_set_attribute(attribute: 'description', value:
'Derek Noonburg has fixed several potential vulnerabilities in xpdf,
which are also present in libextractor, a library to extract arbitrary
meta-data from files.
The old stable distribution (woody) does not contain libextractor packages.
For the stable distribution (sarge) these problems have been fixed in
version 0.4.2-2sarge3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-998');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your libextractor package.');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA998] DSA-998-1 libextractor");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-998-1 libextractor");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'extract', release: '3.1', reference: '0.4.2-2sarge3');
deb_check(prefix: 'libextractor1', release: '3.1', reference: '0.4.2-2sarge3');
deb_check(prefix: 'libextractor1-dev', release: '3.1', reference: '0.4.2-2sarge3');
deb_check(prefix: 'libextractor', release: '3.1', reference: '0.4.2-2sarge3');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
