# This script was automatically generated from the dsa-580
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15678);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "580");
 script_cve_id("CVE-2004-0986");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-580 security update');
 script_set_attribute(attribute: 'description', value:
'Faheem Mitha noticed that the iptables command, an administration tool
for IPv4 packet filtering and NAT, did not always load the required
modules on its own as it was supposed to.  This could lead to firewall
rules not being loaded on system startup.  This caused a failure in
connection with rules provided by lokkit at least.
For the stable distribution (woody) this problem has been fixed in
version 1.2.6a-5.0woody2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-580');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your iptables package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA580] DSA-580-1 iptables");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-580-1 iptables");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'iptables', release: '3.0', reference: '1.2.6a-5.0woody2');
deb_check(prefix: 'iptables-dev', release: '3.0', reference: '1.2.6a-5.0woody2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
