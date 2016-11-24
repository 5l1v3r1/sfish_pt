# This script was automatically generated from the dsa-1557
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(32058);
 script_version("$Revision: 1.4 $");
 script_xref(name: "DSA", value: "1557");
 script_cve_id("CVE-2008-1149", "CVE-2008-1149", "CVE-2008-1567", "CVE-2008-1567", "CVE-2008-1924", "CVE-2008-1924");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1557 security update');
 script_set_attribute(attribute: 'description', value:
'Several remote vulnerabilities have been discovered in phpMyAdmin,
an application to administrate MySQL over the WWW. The Common
Vulnerabilities and Exposures project identifies the following problems:
CVE-2008-1924
    Attackers with CREATE table permissions were allowed to read
    arbitrary files readable by the webserver via a crafted
    HTTP POST request.
CVE-2008-1567
    The PHP session data file stored the username and password of
    a logged in user, which in some setups can be read by a local
    user.
CVE-2008-1149
    Cross site scripting and SQL injection were possible by attackers
    that had permission to create cookies in the same cookie domain
    as phpMyAdmin runs in.
For the stable distribution (etch), these problems have been fixed in
version 4:2.9.1.1-7.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2008/dsa-1557');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your phpmyadmin package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1557] DSA-1557-1 phpmyadmin");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1557-1 phpmyadmin");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'phpmyadmin', release: '4.0', reference: '2.9.1.1-7');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
