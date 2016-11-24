# This script was automatically generated from the dsa-452
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15289);
 script_version("$Revision: 1.12 $");
 script_xref(name: "DSA", value: "452");
 script_cve_id("CVE-2003-0973");
 script_bugtraq_id(9129);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-452 security update');
 script_set_attribute(attribute: 'description', value:
'The Apache Software Foundation announced that some versions of
mod_python contain a bug which, when processing a request with a
malformed query string, could cause the corresponding Apache child to
crash.  This bug could be exploited by a remote attacker to cause a
denial of service.
For the current stable distribution (woody) this problem has been
fixed in version 2:2.7.8-0.0woody2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-452');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2004/dsa-452
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA452] DSA-452-1 libapache-mod-python");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-452-1 libapache-mod-python");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libapache-mod-python', release: '3.0', reference: '2.7.8-0.0woody2');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
