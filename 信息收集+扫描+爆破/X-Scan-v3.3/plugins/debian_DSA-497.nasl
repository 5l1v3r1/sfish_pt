# This script was automatically generated from the dsa-497
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15334);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "497");
 script_cve_id("CVE-2004-0226", "CVE-2004-0231", "CVE-2004-0232");
 script_bugtraq_id(10242);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-497 security update');
 script_set_attribute(attribute: 'description', value:
'Jacub Jelinek discovered several vulnerabilities in the Midnight
Commander, a powerful file manager for GNU/Linux systems.  The
problems were classified as follows:
CVE-2004-0226 Buffer overflows
CVE-2004-0231 Insecure temporary file and directory creations
CVE-2004-0232 Format string problems
For the stable distribution (woody) this problem has been fixed in
version 4.5.55-1.2woody3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-497');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mc packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA497] DSA-497-1 mc");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-497-1 mc");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'gmc', release: '3.0', reference: '4.5.55-1.2woody3');
deb_check(prefix: 'mc', release: '3.0', reference: '4.5.55-1.2woody3');
deb_check(prefix: 'mc-common', release: '3.0', reference: '4.5.55-1.2woody3');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
