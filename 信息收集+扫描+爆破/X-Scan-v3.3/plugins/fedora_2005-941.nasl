#
# (C) Tenable Network Security
#
# This plugin text is was extracted from the Fedora Security Advisory
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(19881);
 script_version ("$Revision: 1.5 $");
 script_cve_id("CVE-2005-2710");
 
 name["english"] = "Fedora Core 3 2005-941: HelixPlayer";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory FEDORA-2005-941 (HelixPlayer).

The Helix Player 1.0 is an open-source media player built in the Helix
Community for consumers. Built using GTK, it plays open source formats,
like Ogg Vorbis and Theora using the powerful Helix DNA Client Media
Engine.

Update Information:

This is a fix for CVE-2005-2710" );
 script_set_attribute(attribute:"solution", value:
"Get the newest Fedora Updates" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the HelixPlayer package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005 Tenable Network Security");
 family["english"] = "Fedora Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"HelixPlayer-1.0.6-0.fc3.1", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_exists(rpm:"HelixPlayer-", release:"FC3") )
{
 set_kb_item(name:"CVE-2005-2710", value:TRUE);
}
