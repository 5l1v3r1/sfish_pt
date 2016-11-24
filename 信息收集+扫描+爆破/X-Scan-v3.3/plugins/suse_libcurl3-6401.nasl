
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42012);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  libcurl3 fix for embedded zero in SSL certificate subject name (libcurl3-6401)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libcurl3-6401");
 script_set_attribute(attribute: "description", value: "This update of libcurl2 fixes the 0-character handling in
the subject name of a SSL certificate. This bug could be
used to execute an undetected man-in-the-middle-attack.
(CVE-2009-2417)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch libcurl3-6401");
script_end_attributes();

script_cve_id("CVE-2009-2417");
script_summary(english: "Check for the libcurl3-6401 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"libcurl3-7.15.5-34.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
