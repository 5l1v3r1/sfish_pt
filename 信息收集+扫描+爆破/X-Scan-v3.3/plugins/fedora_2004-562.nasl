#
# (C) Tenable Network Security
#
# This plugin text is was extracted from the Fedora Security Advisory
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(16027);
 script_version ("$Revision: 1.5 $");
 script_cve_id("CVE-2004-1154");
 
 name["english"] = "Fedora Core 3 2004-562: samba";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory FEDORA-2004-562 (samba).

Samba is the suite of programs by which a lot of PC-related machines
share files, printers, and other information (such as lists of
available
files and printers). The Windows NT, OS/2, and Linux operating systems
support this natively, and add-on packages can enable the same thing
for DOS, Windows, VMS, UNIX of all kinds, MVS, and more. This package
provides an SMB server that can be used to provide network services to
SMB (sometimes called 'Lan Manager') clients. Samba uses NetBIOS over
TCP/IP (NetBT) protocols and does NOT need the NetBEUI (Microsoft Raw
NetBIOS frame) protocol.


* Fri Dec 17 2004 Jay Fenlason 3.0.10-1.fc3

- New upstream release that closes CVE-2004-1154 bz#142544
- Include the -64bit patch from Nalin. This closes bz#142873
- Update the -logfiles patch to work with 3.0.10
- Create /var/run/winbindd and make it part of the -common rpm to
close
bz#142242" );
 script_set_attribute(attribute:"solution", value:
"http://www.fedoranews.org/blog/index.php?p=216" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the samba package";
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
if ( rpm_check( reference:"samba-3.0.10-1.fc3", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-client-3.0.10-1.fc3", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-common-3.0.10-1.fc3", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-swat-3.0.10-1.fc3", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-debuginfo-3.0.10-1.fc3", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_exists(rpm:"samba-", release:"FC3") )
{
 set_kb_item(name:"CVE-2004-1154", value:TRUE);
}
