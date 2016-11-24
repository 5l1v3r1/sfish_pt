#
# (C) Tenable Network Security
#
# This plugin text is was extracted from the Fedora Security Advisory
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(13680);
 script_version ("$Revision: 1.5 $");
 
 name["english"] = "Fedora Core 1 2004-080: kernel";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory FEDORA-2004-080 (kernel).

The kernel package contains the Linux kernel (vmlinuz), the core of your
Fedora Core Linux operating system.  The kernel handles the basic functions
of the operating system:  memory allocation, process allocation, device
input and output, etc.

Update Information:

The previous security errata (2.4.22-1.2173) unfortunatly contained a bug
which made some systems unbootable, due to breakage in the aacraid scsi
driver. This update contains no further changes vs 2173." );
 script_set_attribute(attribute:"solution", value:
"http://www.fedoranews.org/updates/FEDORA-2004-080.shtml" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the kernel package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004 Tenable Network Security");
 family["english"] = "Fedora Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"kernel-2.4.22-1.2174.nptl", prefix:"kernel-", release:"FC1") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
