
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41139);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE9 Security Update:  SLES9-SP4: Security update for yast2-mail-server (11602)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 11602");
 script_set_attribute(attribute: "description", value: 'If you go to YaST --> Mail Server --> FetchMail and select
add account window. While entering the password for the
remote user, it shows the password. Now the password field
echoes \'*\', instead of plain text.
');
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Install the security patch 11602");
script_end_attributes();

script_summary(english: "Check for the security advisory #11602");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"yast2-mail-server-2.9.14-0.7", release:"SUSE9", cpu: "noarch") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
