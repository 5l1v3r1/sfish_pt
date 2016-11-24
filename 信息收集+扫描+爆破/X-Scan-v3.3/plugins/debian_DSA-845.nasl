# This script was automatically generated from the dsa-845
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(19953);
 script_version("$Revision: 1.7 $");
 script_xref(name: "DSA", value: "845");
 script_cve_id("CVE-2005-3118");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-845 security update');
 script_set_attribute(attribute: 'description', value:
'Christoph Martin noticed that upon configuration mason, which
interactively creates a Linux packet filtering firewall, does not
install the init script to actually load the firewall during system
boot.  This will leave the machine without a firewall after a reboot.
For the old stable distribution (woody) this problem has been fixed in
version 0.13.0.92-2woody1.
For the stable distribution (sarge) this problem has been fixed in
version 1.0.0-2.2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-845');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mason package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA845] DSA-845-1 mason");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-845-1 mason");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mason', release: '3.0', reference: '0.13.0.92-2woody1');
deb_check(prefix: 'mason', release: '3.1', reference: '1.0.0-2.2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
