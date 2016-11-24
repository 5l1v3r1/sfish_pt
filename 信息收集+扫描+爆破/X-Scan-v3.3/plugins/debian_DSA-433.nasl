# This script was automatically generated from the dsa-433
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15270);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "433");
 script_cve_id("CVE-2003-0961");
 script_bugtraq_id(9138);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-433 security update');
 script_set_attribute(attribute: 'description', value:
'Red Hat and SuSE kernel and security teams revealed an integer overflow
in the do_brk() function of the Linux kernel allows local users to
gain root privileges.
For the stable distribution (woody) this problem has been fixed in
version 2.4.17-0.020226.2.woody4.  Other architectures are already or
will be fixed separately.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-433');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your kernel image packages for the mips
and mipsel architectures.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA433] DSA-433-1 kernel-patch-2.4.17-mips");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-433-1 kernel-patch-2.4.17-mips");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'kernel-headers-2.4.17', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
deb_check(prefix: 'kernel-image-2.4.17-r3k-kn02', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
deb_check(prefix: 'kernel-image-2.4.17-r4k-ip22', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
deb_check(prefix: 'kernel-image-2.4.17-r4k-kn04', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
deb_check(prefix: 'kernel-image-2.4.17-r5k-ip22', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
deb_check(prefix: 'kernel-patch-2.4.17-mips', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
deb_check(prefix: 'mips-tools', release: '3.0', reference: '2.4.17-0.020226.2.woody4');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
