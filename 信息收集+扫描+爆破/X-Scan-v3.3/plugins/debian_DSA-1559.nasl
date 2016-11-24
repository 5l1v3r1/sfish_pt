# This script was automatically generated from the dsa-1559
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(32060);
 script_version("$Revision: 1.5 $");
 script_xref(name: "DSA", value: "1559");
 script_cve_id("CVE-2007-5051");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1559 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that phpGedView, an application to provide online access
to genealogical data, performed insufficient input sanitising on some
parameters, making it vulnerable to cross site scripting.
For the stable distribution (etch), this problem has been fixed in version
4.0.2.dfsg-3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2008/dsa-1559');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your phpgedview package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1559] DSA-1559-1 phpgedview");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1559-1 phpgedview");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'phpgedview', release: '4.0', reference: '4.0.2.dfsg-3');
deb_check(prefix: 'phpgedview-languages', release: '4.0', reference: '4.0.2.dfsg-3');
deb_check(prefix: 'phpgedview-places', release: '4.0', reference: '4.0.2.dfsg-3');
deb_check(prefix: 'phpgedview-themes', release: '4.0', reference: '4.0.2.dfsg-3');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
