
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41120);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE9 Security Update:  Security update for gpg (11464)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 11464");
 script_set_attribute(attribute: "description", value: 'When printing a text stream with a GPG signature it was
possible for an attacker to create a stream with "unsigned
text, signed text" where both unsigned and signed text would
be shown without distinction which one was signed and which
part wasn\'t.
This is tracked by the Mitre CVE ID CVE-2007-1263.
The update introduces a new option --allow-multiple-messages
to print out such messages in the future, by default it only
prints and handles the first one.
');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Install the security patch 11464");
script_end_attributes();

script_cve_id("CVE-2007-1263");
script_summary(english: "Check for the security advisory #11464");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"gpg-1.2.4-68.25", release:"SUSE9", cpu: "i586") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
