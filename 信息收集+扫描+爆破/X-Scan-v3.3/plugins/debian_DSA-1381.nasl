# This script was automatically generated from the dsa-1381
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(26211);
 script_version("$Revision: 1.7 $");
 script_xref(name: "DSA", value: "1381");
 script_cve_id("CVE-2006-5755", "CVE-2007-4133", "CVE-2007-4573", "CVE-2007-5093");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1381 security update');
 script_set_attribute(attribute: 'description', value:
'Several local vulnerabilities have been discovered in the Linux kernel
that may lead to a denial of service or the execution of arbitrary
code. The Common Vulnerabilities and Exposures project identifies the
following problems:
CVE-2006-5755
    The NT bit maybe leaked into the next task which can make it possible for local attackers
    to cause a Denial of Service (crash) on systems which run the amd64
    flavour kernel. The stable distribution (<q>etch</q>) was not believed to
    be vulnerable to this issue at the time of release, however Bastian
    Blank discovered that this issue still applied to the xen-amd64 and
    xen-vserver-amd64 flavours, and is resolved by this DSA.
CVE-2007-4133
    Hugh Dickins discovered a potential local DoS (panic) in hugetlbfs.
    A misconversion of hugetlb_vmtruncate_list to prio_tree may allow
    local users to trigger a BUG_ON() call in exit_mmap.
CVE-2007-4573
    Wojciech Purczynski discovered a vulnerability that can be exploited
    by a local user to obtain superuser privileges on x86_64 systems.
    This resulted from improper clearing of the high bits of registers
    during ia32 system call emulation. This vulnerability is relevant
    to the Debian amd64 port as well as users of the i386 port who run
    the amd64 linux-image flavour.
    
    DSA-1378 resolved this problem for the amd64 flavour kernels, but
    Tim Wickberg and Ralf Hemmenst&auml;dt reported an outstanding issue with
    the xen-amd64 and xen-vserver-amd64 flavours that is resolved by
    this DSA.
CVE-2007-5093
    Alex Smith discovered an issue with the pwc driver for certain webcam
    devices. If the device is removed while a userspace application has it
    open, the driver will wait for userspace to close the device, resulting
    in a blocked USB subsystem. This issue is of low security impact as
    it requires the attacker to either have physical access to the system
    or to convince users with local access to remove the device on their
    behalf.
    

These problems have been fixed in the stable distribution in version 
2.6.18.dfsg.1-13etch4.
This is an update to DSA-1381-1 which included only amd64 binaries for
linux-2.6. Builds for all other architectures are now available, as well as
rebuilds of ancillary packages that make use of the included linux source.
The following matrix lists additional packages that were rebuilt for
compatibility with or to take advantage of this update:
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2007/dsa-1381');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your kernel package immediately and reboot
the machine.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1381] DSA-1381-2 linux-2.6");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1381-2 linux-2.6");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'fai-kernels', release: '4.0', reference: '1.17+etch.13etch4');
deb_check(prefix: 'kernel-patch-openvz', release: '4.0', reference: '028.18.1etch5');
deb_check(prefix: 'linux-doc-2.6.18', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-486', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-686-bigmem', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-alpha', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-arm', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-hppa', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-i386', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-ia64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-mips', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-mipsel', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-powerpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-s390', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-all-sparc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-alpha-generic', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-alpha-legacy', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-alpha-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-footbridge', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-iop32x', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-itanium', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-ixp4xx', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-k7', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-mckinley', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-parisc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-parisc-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-parisc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-parisc64-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-powerpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-powerpc-miboot', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-powerpc-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-powerpc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-prep', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-qemu', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-r3k-kn02', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-r4k-ip22', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-r4k-kn04', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-r5k-cobalt', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-r5k-ip32', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-rpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-s390', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-s390x', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-s3c2410', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-sb1-bcm91250a', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-sb1a-bcm91480b', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-sparc32', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-sparc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-sparc64-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-alpha', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-k7', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-powerpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-powerpc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-s390x', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-vserver-sparc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-xen', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-xen-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-xen-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-xen-vserver', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-xen-vserver-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-headers-2.6.18-5-xen-vserver-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-486', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-686-bigmem', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-alpha-generic', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-alpha-legacy', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-alpha-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-footbridge', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-iop32x', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-itanium', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-ixp4xx', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-k7', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-mckinley', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-parisc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-parisc-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-parisc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-parisc64-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-powerpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-powerpc-miboot', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-powerpc-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-powerpc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-prep', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-qemu', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-r3k-kn02', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-r4k-ip22', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-r4k-kn04', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-r5k-cobalt', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-r5k-ip32', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-rpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-s390', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-s390-tape', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-s390x', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-s3c2410', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-sb1-bcm91250a', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-sb1a-bcm91480b', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-sparc32', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-sparc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-sparc64-smp', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-alpha', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-k7', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-powerpc', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-powerpc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-s390x', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-vserver-sparc64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-xen-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-xen-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-xen-vserver-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-image-2.6.18-5-xen-vserver-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-manual-2.6.18', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-modules-2.6.18-5-xen-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-modules-2.6.18-5-xen-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-modules-2.6.18-5-xen-vserver-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-modules-2.6.18-5-xen-vserver-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-patch-debian-2.6.18', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-source-2.6.18', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-support-2.6.18-5', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'linux-tree-2.6.18', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'user-mode-linux', release: '4.0', reference: '2.6.18-1um-2etch.13etch4');
deb_check(prefix: 'xen-linux-system-2.6.18-5-xen-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'xen-linux-system-2.6.18-5-xen-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'xen-linux-system-2.6.18-5-xen-vserver-686', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
deb_check(prefix: 'xen-linux-system-2.6.18-5-xen-vserver-amd64', release: '4.0', reference: '2.6.18.dfsg.1-13etch4');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
