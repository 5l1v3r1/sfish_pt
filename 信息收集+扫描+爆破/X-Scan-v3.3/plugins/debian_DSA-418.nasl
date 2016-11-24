# This script was automatically generated from the dsa-418
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15255);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "418");
 script_cve_id("CVE-2004-0015");
 script_bugtraq_id(9381);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-418 security update');
 script_set_attribute(attribute: 'description', value:
'A bug was discovered in vbox3, a voice response system for isdn4linux,
whereby root privileges were not properly relinquished before
executing a user-supplied tcl script.  By exploiting this
vulnerability, a local user could gain root privileges.
For the current stable distribution (woody) this problem has been
fixed in version 0.1.7.1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-418');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2004/dsa-418
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA418] DSA-418-1 vbox3");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-418-1 vbox3");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'vbox3', release: '3.0', reference: '0.1.7.1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
