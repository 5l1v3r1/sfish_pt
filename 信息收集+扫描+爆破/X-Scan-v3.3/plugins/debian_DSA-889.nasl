# This script was automatically generated from the dsa-889
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22755);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "889");
 script_cve_id("CVE-2005-3256");
 script_xref(name: "CERT", value: "805121");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-889 security update');
 script_set_attribute(attribute: 'description', value:
'Hadmut Danish discovered a bug in enigmail, GPG support for Mozilla
MailNews and Mozilla Thunderbird, that can lead to the encryption of
mail with the wrong public key, hence, potential disclosure of
confidential data to others.
The old stable distribution (woody) does not contain enigmail packages.
For the stable distribution (sarge) this problem has been fixed in
version 0.91-4sarge2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-889');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your enigmail packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA889] DSA-889-1 enigmail");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-889-1 enigmail");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mozilla-enigmail', release: '3.1', reference: '0.91-4sarge2');
deb_check(prefix: 'mozilla-thunderbird-enigmail', release: '3.1', reference: '0.91-4sarge2');
deb_check(prefix: 'enigmail', release: '3.1', reference: '0.91-4sarge2');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
