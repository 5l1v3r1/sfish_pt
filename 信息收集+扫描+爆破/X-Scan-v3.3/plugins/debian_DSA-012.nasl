# This script was automatically generated from the dsa-012
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(14849);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "012");
 script_cve_id("CVE-2001-0233");
 script_bugtraq_id(2254);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-012 security update');
 script_set_attribute(attribute: 'description', value:
'PkC has reported that there is a buffer overflow in
sprintf() in micq versions 0.4.6 and previous, that allows to a remote attacker
able to sniff packets to the ICQ server to execute arbitrary code on the victim
system.

We recommend you upgrade your micq package immediately.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2001/dsa-012');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2001/dsa-012
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA012] DSA-012-1 micq");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-012-1 micq");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'micq', release: '2.2', reference: '0.4.3-4');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
