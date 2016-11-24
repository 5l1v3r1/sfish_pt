#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description) {
  script_id(18416);
  script_version("$Revision: 1.12 $");

  script_cve_id("CVE-2005-1875");
  script_bugtraq_id(13844);
  script_xref(name:"OSVDB", value:"17006");
  script_xref(name:"Secunia", value:"15583");

  script_name(english:"Exhibit Engine list.php Multiple Parameter SQL Injection");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is vulnerable to
SQL injection attacks." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Exhibit Engine, a web-based photo gallery
written in PHP. 

The version installed on the remote host suffers from a SQL injection
vulnerability due to its failure to sanitize user-supplied input to
various parameters of the 'list.php' script.  An attacker can exploit
these flaws to inject arbitrary SQL statements into the affected
application, possibly even reading arbitrary database entries." );
 script_set_attribute(attribute:"see_also", value:"https://www.sec-consult.com/files/20050602-2.txt" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2005-06/0007.html" );
 script_set_attribute(attribute:"see_also", value:"http://photography-on-the.net/forum/showthread.php?p=579692" );
 script_set_attribute(attribute:"solution", value:
"Upgrade if necessary to EE 1.5RC4 and apply the patched
'slashwork.php' script referenced in the second URL above." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  summary["english"] = "Checks for SQL injection vulnerability in Exhibit Engine's list.php";
  script_summary(english:summary["english"]);
 
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# For each CGI directory...
foreach dir (cgi_dirs()) {
  # Make sure the affected script exists.
  r = http_send_recv3(method:"GET", item:string(dir, "/list.php"), port:port);
  if (isnull(r)) exit(0);
  res = r[2];

  # If it's from Exhibit Engine...
  if (egrep(string:res, pattern:'href="http://photography-on-the\\.net/ee/?" title=".*Exhibit Engine')) {
    # Try to exploit the flaw.
    #
    # nb: this will fail if there are no public exhibitions.
    postdata = string(
      # nb: try to cause a syntax error with the single quote.
      "search_row=ee_photo.ee_photo_exif_text'&",
      "keyword=", SCRIPT_NAME
    );
    r = http_send_recv3(method: "POST ", item: dir+"/list.php", port:port, 
      add_headers: make_array("Content-Type", "application/x-www-form-urlencoded"),
      data: postdata);
    if (isnull(r)) exit(0);
    res = r[2];

    # There's a problem if we see a syntax error.
    if (
      (
        # versions 1.5 and above.
        ">Exhibit Engine MySQL error!</big><br>ERROR FROM QUERY" >< res ||
        # versions 1.3 and earlier.
        ">An error in retrieving data from database was reported by EE<" >< res
      ) &&
      egrep(string:res, pattern:string("(SQL syntax|syntax to use) near '\\\\' LIKE '%", SCRIPT_NAME))
    ) {
      security_hole(port);
      set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
      exit(0);
    }
  }
}
