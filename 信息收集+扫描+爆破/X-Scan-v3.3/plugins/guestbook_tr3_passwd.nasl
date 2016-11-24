#
# (C) Tenable Network Security, Inc.
#

# Ref:
# Message-ID: <20030321012151.9388.qmail@www.securityfocus.com>
# From: subj <r2subj3ct@dwclan.org>
# To: bugtraq@securityfocus.com
# Subject: Guestbook tr3.a


include("compat.inc");

if(description)
{
 script_id(11436);
 script_version ("$Revision: 1.18 $");

 script_cve_id("CVE-2003-1541");
 script_bugtraq_id(7167);
 script_xref(name:"Secunia", value:"8392");
 script_xref(name:"OSVDB", value:"49874");

 script_name(english:"Guestbook tr3.a Password Disclosure");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a CGI application that is affected by
an information disclosure vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote install of Guestbook tr3.a fails to restrict access to its
password file. An unauthenticated remote attacker can leverage this
issue to gain control of the affected application." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/archive/1/315895/30/25400/threaded" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
 summary["english"] = "Checks for the presence of passwd.txt";
 
 script_summary(english:summary["english"]);
 
 script_category(ACT_ATTACK);
 
 
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 family["english"] = "CGI abuses";
 script_family(english:family["english"]);
 script_dependencie("http_version.nasl", "find_service1.nasl", "no404.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# Loop through directories.
if (thorough_tests) dirs = list_uniq(make_list("/guestbook", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  # Make sure we're looking at Guestbook tr3.a.
  url = string(dir, "/guestbook.php");

  w = http_send_recv3(method:"GET", item:url, port:port);
  if (isnull(w)) exit(1, "the web server did answer");
  res = w[2];

  # If so...
  if (
    "PHP script by Bernd Moon" >< res ||
    ">Find all message here" >< res
  )
  {
    # Try the exploit.
    url2 = string(dir, "/files/passwd.txt");

    w = http_send_recv3(method:"GET", item:url2, port:port);
    if (isnull(w)) exit(1, "the web did not answer");
    res2 = w[2];

    # There's a problem if we get something.
    if (strlen(res2))
    {
      if (report_verbosity)
      {
        report = string(
          "\n",
          "Nessus was able to exploit the issue to retrieve the contents of\n",
          "the application's password file using the following URL :\n",
          "\n",
          "  ", build_url(port:port, qs:url2), "\n"
        );
        if (report_verbosity > 1)
        {
          report += string(
            "\n",
            "Here are the contents :\n",
            "\n",
            "  ", str_replace(find:'\n', replace:'\n  ', string:res2), "\n"
          );
        }
        security_hole(port:port, extra:report);
      }
      else security_hole(port);

      exit(0);
    }
  }
}
