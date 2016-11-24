
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-1422
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(31029);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 8 2008-1422: kernel");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-1422 (kernel)");
 script_set_attribute(attribute: "description", value: "The kernel package contains the Linux kernel (vmlinuz), the core of any
Linux operating system.  The kernel handles the basic functions
of the operating system:  memory allocation, process allocation, device
input and output, etc.

-
Update Information:

Update to Linux kernel 2.6.23.15:
[8]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23.15    Fix vmspl
ice
local root vulnerability:  CVE-2008-0009: Fixed by update to 2.6.23.15.
CVE-2008-0010: Fixed by update to 2.6.23.15.  CVE-2008-0600: Extra fix from
upstream applied.    Fix memory leak in netlabel code (#352281)  Autoload the
Dell dcdbas driver like in F8 (#326041)  Work around broken Seagate LBA48 disks
.
(F8#429364)  Fix futex oops on uniprocessor machine. (F8#429412)  Add support
for new Macbook touchpads. (F8#426574)  Fix the initio driver broken in 2.6.23.
(F8#390531)  Fix segfaults from using vdso=2. (F8#427641)  FireWire updates,
fixing multiple problems.  ACPI: fix multiple problems with brightness controls
(F8#427518)  Wireless driver updates from upstream.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-5938", "CVE-2008-0009", "CVE-2008-0600");
script_summary(english: "Check for the version of the kernel package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"kernel-2.6.23.15-80.fc7", prefix:"kernel-", release:"FC8") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
