# This script was automatically generated from the dsa-462
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15299);
 script_version("$Revision: 1.10 $");
 script_xref(name: "DSA", value: "462");
 script_cve_id("CVE-2004-0151");
 script_bugtraq_id(9851);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-462 security update');
 script_set_attribute(attribute: 'description', value:
'Steve Kemp from the Debian Security Audit Project discovered a problem in
xitalk, a talk intercept utility for the X Window System.  A local
user can exploit this problem and execute arbitrary commands under the
GID utmp.  This could be used by an attacker to remove traces from the
utmp file.
For the stable distribution (woody) this problem has been fixed in
version 1.1.11-9.1woody1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-462');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your xitalk package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA462] DSA-462-1 xitalk");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-462-1 xitalk");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'xitalk', release: '3.0', reference: '1.1.11-9.1woody1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
