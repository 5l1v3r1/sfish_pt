# This script was automatically generated from the dsa-695
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(17578);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "695");
 script_cve_id("CVE-2001-0775", "CVE-2005-0638", "CVE-2005-0639");
 script_bugtraq_id(3006);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-695 security update');
 script_set_attribute(attribute: 'description', value:
'Several vulnerabilities have been discovered in xli, an image viewer
for X11.  The Common Vulnerabilities and Exposures project identifies
the following problems:
    A buffer overflow in the decoder for FACES format images could be
    exploited by an attacker to execute arbitrary code.  This problem
    has already been fixed in xloadimage in
    DSA 069.
    Tavis Ormandy of the Gentoo Linux Security Audit Team has reported
    a flaw in the handling of compressed images, where shell
    meta-characters are not adequately escaped.
    Insufficient validation of image properties in have been
    discovered which could potentially result in buffer management
    errors.
For the stable distribution (woody) these problems have been fixed in
version 1.17.0-11woody1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-695');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your xli package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA695] DSA-695-1 xli");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-695-1 xli");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'xli', release: '3.0', reference: '1.17.0-11woody1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
