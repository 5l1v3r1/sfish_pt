# This script was automatically generated from the dsa-867
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(20070);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "867");
 script_cve_id("CVE-2005-3121");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-867 security update');
 script_set_attribute(attribute: 'description', value:
'Eduard Bloch discovered that a rule file in module-assistant, a tool
to ease the creation of module packages, creates a temporary file in
an insecure fashion.  It is usually executed from other packages as
well.
The old stable distribution (woody) does not contain a module-assistant
package.
For the stable distribution (sarge) this problem has been fixed in
version 0.9sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-867');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your module-assistant package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:N/I:P/A:N');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA867] DSA-867-1 module-assistant");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-867-1 module-assistant");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'module-assistant', release: '3.1', reference: '0.9sarge1');
if (deb_report_get()) security_note(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
