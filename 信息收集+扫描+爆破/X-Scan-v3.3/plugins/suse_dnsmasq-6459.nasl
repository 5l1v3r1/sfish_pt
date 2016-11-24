
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41997);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  dnsmasq: remote buffer overflow in TFTP server code (dnsmasq-6459)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch dnsmasq-6459");
 script_set_attribute(attribute: "description", value: "This update fixes a buffer overflow in the TFTP server code
of dnsmasq. Please note that the TFTP server is disabled by
default.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch dnsmasq-6459");
script_end_attributes();

script_summary(english: "Check for the dnsmasq-6459 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"dnsmasq-2.45-0.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
