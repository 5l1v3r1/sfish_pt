# This script was automatically generated from the dsa-096
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(14933);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "096");
 script_cve_id("CVE-2002-0001");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-096 security update');
 script_set_attribute(attribute: 'description', value:
'Joost Pol found a buffer overflow in the address handling code of
mutt (a popular mail user agent). Even though this is a one byte
overflow this is exploitable.

This has been fixed upstream in version 1.2.5.1 and 1.3.25. The
relevant patch has been added to version 1.2.5-5 of the Debian
package.

');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2002/dsa-096');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2002/dsa-096
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA096] DSA-096-2 mutt");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-096-2 mutt");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mutt', release: '2.2', reference: '1.2.5-5');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
