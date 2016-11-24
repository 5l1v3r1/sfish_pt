# This script was automatically generated from the dsa-540
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15377);
 script_version("$Revision: 1.12 $");
 script_xref(name: "DSA", value: "540");
 script_cve_id("CVE-2004-0457");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-540 security update');
 script_set_attribute(attribute: 'description', value:
'Jeroen van Wolffelaar discovered an insecure
temporary file vulnerability in the mysqlhotcopy script when using the
scp method which is part of the mysql-server package.
For the stable distribution (woody) this problem has been fixed in
version 3.23.49-8.7 of mysql.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-540');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mysql-server package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA540] DSA-540-1 mysql");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-540-1 mysql");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libmysqlclient10', release: '3.0', reference: '3.23.49-8.7');
deb_check(prefix: 'libmysqlclient10-dev', release: '3.0', reference: '3.23.49-8.7');
deb_check(prefix: 'mysql-client', release: '3.0', reference: '3.23.49-8.7');
deb_check(prefix: 'mysql-common', release: '3.0', reference: '3.23.49-8.7');
deb_check(prefix: 'mysql-doc', release: '3.0', reference: '3.23.49-8.5');
deb_check(prefix: 'mysql-server', release: '3.0', reference: '3.23.49-8.7');
deb_check(prefix: 'mysql', release: '3.0', reference: '3.23.49-8.7');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
