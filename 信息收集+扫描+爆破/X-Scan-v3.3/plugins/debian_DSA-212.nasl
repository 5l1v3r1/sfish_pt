# This script was automatically generated from the dsa-212
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15049);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "212");
 script_cve_id("CVE-2002-1373", "CVE-2002-1374", "CVE-2002-1375", "CVE-2002-1376");
 script_bugtraq_id(6368, 6373, 6375);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-212 security update');
 script_set_attribute(attribute: 'description', value:
'While performing an audit of MySQL e-matters found several problems:
For Debian GNU/Linux 3.0/woody this has been fixed in version 3.23.49-8.2
and version 3.22.32-6.3 for Debian GNU/Linux 2.2/potato.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2002/dsa-212');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mysql packages as soon as possible.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA212] DSA-212-1 mysql");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-212-1 mysql");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mysql-client', release: '2.2', reference: '3.22.32-6.3');
deb_check(prefix: 'mysql-doc', release: '2.2', reference: '3.22.32-6.3');
deb_check(prefix: 'mysql-server', release: '2.2', reference: '3.22.32-6.3');
deb_check(prefix: 'libmysqlclient10', release: '3.0', reference: '3.23.49-8.2');
deb_check(prefix: 'libmysqlclient10-dev', release: '3.0', reference: '3.23.49-8.2');
deb_check(prefix: 'mysql-client', release: '3.0', reference: '3.23.49-8.2');
deb_check(prefix: 'mysql-common', release: '3.0', reference: '3.23.49-8.2');
deb_check(prefix: 'mysql-doc', release: '3.0', reference: '3.23.49-8.2');
deb_check(prefix: 'mysql-server', release: '3.0', reference: '3.23.49-8.2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
