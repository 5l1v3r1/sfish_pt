# This script was automatically generated from the dsa-1555
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(32035);
 script_version("$Revision: 1.5 $");
 script_xref(name: "DSA", value: "1555");
 script_cve_id("CVE-2008-1380");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1555 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that crashes in the Javascript engine of Iceweasel,
an unbranded version of the Firefox browser, could potentially lead to 
the execution of arbitrary code.
For the stable distribution (etch), this problem has been fixed in
version 2.0.0.14-0etch1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2008/dsa-1555');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your iceweasel package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1555] DSA-1555-1 iceweasel");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1555-1 iceweasel");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'firefox', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'firefox-dom-inspector', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'firefox-gnome-support', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'iceweasel', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'iceweasel-dbg', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'iceweasel-dom-inspector', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'iceweasel-gnome-support', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'mozilla-firefox', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'mozilla-firefox-dom-inspector', release: '4.0', reference: '2.0.0.14-0etch1');
deb_check(prefix: 'mozilla-firefox-gnome-support', release: '4.0', reference: '2.0.0.14-0etch1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
