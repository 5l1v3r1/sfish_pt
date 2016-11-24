# This script was automatically generated from the dsa-164
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15001);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "164");
 script_cve_id("CVE-2002-1477", "CVE-2002-1478");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-164 security update');
 script_set_attribute(attribute: 'description', value:
'A problem in cacti, a PHP based frontend to rrdtool for monitoring
systems and services, has been discovered.  This could lead into cacti
executing arbitrary program code under the user id of the web server.
This problem, however, is only persistent to users who already have
administrator privileges in the cacti system.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2002/dsa-164');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your cacti package immediately.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA164] DSA-164-1 cacti");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-164-1 cacti");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'cacti', release: '3.0', reference: '0.6.7-2.1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
