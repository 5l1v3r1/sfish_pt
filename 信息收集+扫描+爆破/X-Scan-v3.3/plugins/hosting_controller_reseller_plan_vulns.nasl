#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(18400);
  script_version("$Revision: 1.16 $");

  script_cve_id("CVE-2005-1784", "CVE-2005-1788", "CVE-2005-2077");
  script_bugtraq_id(13806, 13816, 13829, 14080);
  script_xref(name:"OSVDB", value:"16914");
  script_xref(name:"OSVDB", value:"16915");
  script_xref(name:"OSVDB", value:"16953");
  script_xref(name:"OSVDB", value:"17612");

  name["english"] = "Hosting Controller < 6.1 Hotfix 2.1 Multiple Vulnerabilities";
  script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains an ASP application with multiple flaws." );
 script_set_attribute(attribute:"description", value:
"According to its version number, the version of Hosting Controller on
the remote host suffers from multiple vulnerabilities:

  - An authenticated user can modify another user's profile, 
    even an admin's, recover his/her password, and then gain 
    access to the affected application as that user.

  - An authenticated user can view, edit, and even delete 
    reseller add-on plans. 

  - The scripts 'sendpassword.asp' and 'error.asp' are prone
    to cross-site scripting attacks." );
 script_set_attribute(attribute:"see_also", value:"http://securitytracker.com/alerts/2005/May/1014062.html" );
 script_set_attribute(attribute:"see_also", value:"http://securitytracker.com/alerts/2005/May/1014071.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/403571/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 6.1 if necessary and apply Hotfix 2.1." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:S/C:P/I:P/A:P" );
script_end_attributes();

 
  summary["english"] = "Checks for multiple vulnerabilities in Hosting Controller < 6.1 hotfix 2.1";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencies("hosting_controller_detect.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports("Services/www", 8887);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");


# Check for Hosting Controller installs.
ports = add_port_in_list(list:get_kb_list("Services/www"), port:8887);
foreach port (ports) {
  ver = get_kb_item(string("www/", port, "/hosting_controller"));
  if (ver) {
    # nb: versions <= 6.1 hotfix 2.0 are vulnerable.
    if (ver =~ "^(2002|[0-5]\.|6\.(0|1($| hotfix ([01]\.|2\.0))))") {
      security_warning(port);
      set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
      if (!thorough_tests) exit(0);
    }
  }
}
