#
# (C) Tenable Network Security
#
# This plugin text was extracted from SuSE Security Advisory SUSE-SA:2007:024
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(25413);
 script_version ("$Revision: 1.4 $");
 
 name["english"] = "SUSE-SA:2007:024: gpg";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory SUSE-SA:2007:024 (gpg)." );
 script_set_attribute(attribute:"solution", value:
"http://www.novell.com/linux/security/advisories/2007_24_gpg.html" );
 script_set_attribute(attribute:"risk_factor", value:"Medium" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the gpg package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2007 Tenable Network Security");
 family["english"] = "SuSE Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"gpg-1.4.2-5.14", release:"SUSE10.0") )
{
 security_warning(0);
 exit(0);
}
if ( rpm_check( reference:"gpg-1.4.0-4.14", release:"SUSE9.3") )
{
 security_warning(0);
 exit(0);
}
