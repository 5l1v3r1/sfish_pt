#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(34209);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2008-6971");
  script_bugtraq_id(31053);
  script_xref(name:"milw0rm", value:"6392");
  script_xref(name:"OSVDB", value:"47945");
  script_xref(name:"Secunia", value:"31750");

  script_name(english:"Simple Machines Forum Validation Code Prediction Arbitrary Password Reset");
  script_summary(english:"Tries to recover value of rand()");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by a
password reset vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Simple Machines Forum (SMF), an open-source
web forum application written in PHP. 

The version of Simple Machines Forum installed on the remote host
generates validation codes for its password reset functionality with
'rand()', which on Windows platforms has a maximum value of 32767
currently and is used as the seed for the next random number.  An
unauthenticated remote attacker can leverage this issue to predict
random numbers generated by 'rand()' and thus the validation codes for
the password reset form, which could in turn enable him to reset the
password for arbitrary users of the affected application, such as the
administrator." );
 script_set_attribute(attribute:"see_also", value:"http://www.simplemachines.org/community/index.php?topic=260145.0" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to SMF 1.1.6 / 2.0 beta 4 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl", "os_fingerprint.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


# Unless we're paranoid, don't bother if we know the OS and it's not Windows.
if (report_paranoia < 2)
{
  os = get_kb_item("Host/OS");
  if (os && "Windows" >!< os) exit(0);
}

port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# Loop through directories.
if (thorough_tests) dirs = list_uniq(make_list("/smf", "/forum", "/forums", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  init_cookiejar();
  # Call up the password reset form.
  url = string(
    dir, "/index.php?",
    "action=reminder"
  );

  r = http_send_recv3(method: "GET", item:url, port:port);
  if (isnull(r)) exit(0);

  # Pull out the session cookie and the 'sc' parameter value.
  if ('type="hidden" name="sc" value="' >< r[2])
  {
    cookie = "";
    sc = "";

    cookie = get_http_cookie(name: "PHPSESSID");
    pat = 'hidden" name="sc" value="([0-9a-fA-F]{32})" />';
    matches = egrep(pattern:pat, string: r[2]);
    if (matches)
    {
      foreach match (split(matches))
      {
        match = chomp(match);
        item = eregmatch(pattern:pat, string:match);
        if (!isnull(item))
        {
          sc = item[1];
          break;
        }
      }
    }

    # Check if we can generate the sc parameter value.
    if (cookie && sc)
    {
      for (i=0; i<=32767; i++)
      {
        if (hexstr(MD5(string(cookie, i))) == sc)
        {
          security_hole(port);
          if (!thorough_tests) exit(0);
        }
      }
    }
    else if (!cookie)
    {
      debug_print("couldn't find the session cookie!");
    }
    else if (!sc)
    {
      debug_print("couldn't find the hidden 'sc' parameter value!");
    }
  }
}
