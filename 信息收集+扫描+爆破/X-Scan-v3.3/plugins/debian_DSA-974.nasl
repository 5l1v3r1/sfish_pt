# This script was automatically generated from the dsa-974
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22840);
 script_version("$Revision: 1.4 $");
 script_xref(name: "DSA", value: "974");
 script_cve_id("CVE-2006-0301");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-974 security update');
 script_set_attribute(attribute: 'description', value:
'SuSE researchers discovered heap overflow errors in xpdf, the Portable
Document Format (PDF) suite, which is also present in gpdf, the GNOME
version of the Portable Document Format viewer, and which can allow
attackers to cause a denial of service by crashing the application or
possibly execute arbitrary code.
The old stable distribution (woody) does not contain gpdf packages.
For the stable distribution (sarge) these problems have been fixed in
version 2.8.2-1.2sarge3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-974');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your gpdf package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA974] DSA-974-1 gpdf");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-974-1 gpdf");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'gpdf', release: '3.1', reference: '2.8.2-1.2sarge3');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
