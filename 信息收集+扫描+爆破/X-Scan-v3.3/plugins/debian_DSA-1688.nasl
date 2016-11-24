# This script was automatically generated from the dsa-1688
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(35225);
 script_version("$Revision: 1.2 $");
 script_xref(name: "DSA", value: "1688");
 script_cve_id("CVE-2008-2380", "CVE-2008-2667");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1688 security update');
 script_set_attribute(attribute: 'description', value:
'Two SQL injection vulnerabilities have been found in courier-authlib,
the courier authentification library.  The MySQL database interface used
insufficient escaping mechanisms when constructing SQL statements,
leading to SQL injection vulnerabilities if certain charsets are used
(CVE-2008-2380).  A similar issue affects the PostgreSQL database
interface (CVE-2008-2667).
For the stable distribution (etch), these problems have been fixed in
version 0.58-4+etch2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2008/dsa-1688');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your courier-authlib packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1688] DSA-1688-1 courier-authlib");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1688-1 courier-authlib");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'courier-authdaemon', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib-dev', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib-ldap', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib-mysql', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib-pipe', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib-postgresql', release: '4.0', reference: '0.58-4+etch2');
deb_check(prefix: 'courier-authlib-userdb', release: '4.0', reference: '0.58-4+etch2');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
