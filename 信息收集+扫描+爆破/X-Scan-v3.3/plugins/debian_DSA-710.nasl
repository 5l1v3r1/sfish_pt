# This script was automatically generated from the dsa-710
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(18080);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "710");
 script_cve_id("CVE-2003-0541");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-710 security update');
 script_set_attribute(attribute: 'description', value:
'Alan Cox discovered a problem in gtkhtml, an HTML rendering widget
used by the Evolution mail reader.  Certain malformed messages could
cause a crash due to a null pointer dereference.
For the stable distribution (woody) this problem has been fixed in
version 1.0.2-1.woody1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-710');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your gtkhtml package and restart
Evolution.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA710] DSA-710-1 gtkhtml");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-710-1 gtkhtml");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'gtkhtml', release: '3.0', reference: '1.0.2-1.woody1');
deb_check(prefix: 'libgtkhtml-data', release: '3.0', reference: '1.0.2-1.woody1');
deb_check(prefix: 'libgtkhtml-dev', release: '3.0', reference: '1.0.2-1.woody1');
deb_check(prefix: 'libgtkhtml20', release: '3.0', reference: '1.0.2-1.woody1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
