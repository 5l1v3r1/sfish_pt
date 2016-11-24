#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(34849);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2008-6967");
  script_bugtraq_id(32355);
  script_xref(name:"OSVDB", value:"50011");
  script_xref(name:"Secunia", value:"32142");

  script_name(english:"MDaemon WorldClient < 10.0.2 Email Handling XSS");
  script_summary(english:"Checks version of MDaemon");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote mail server is prone to a script injection attack." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Alt-N MDaemon, a mail server for Windows. 

According to its banner, a version of MDaemon mail server older than
10.0.2 is installed on the remote host.  Such versions ship with a
version of WorldClient (a webmail client) that is affected by a script
injection vulnerability.  By tricking a user into opening a specially
crafted email, an attacker can exploit this issue to execute script
code in the user's browser in the security context of the affected
application and thereby steal cookie based credentials or launch other
attacks." );
 script_set_attribute(attribute:"see_also", value:"http://files.altn.com/MDaemon/Release/RelNotes_en.txt" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to MDaemon 10.0.2 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N" );
script_end_attributes();


  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses : XSS");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");
  script_dependencies("http_version.nasl");
  script_require_ports("Services/www", 3000);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


# Try to get the version number from login page

ver = NULL;

port = get_http_port(default:3000);
if (!get_port_state(port)) exit(0);
    
res = http_get_cache(item:"/", port:port); 
if (isnull(res)) exit(0);

if (
  'form action="/WorldClient.dll' >< res && 
  "Email Address:"      >< res 	      &&
  "Password"            >< res 	      && 
  "MDaemon/WorldClient" >< res        &&
  " &copy; " >< res
)
{
  ver = strstr(res, "MDaemon/WorldClient");
  ver = ver - strstr(ver, " &copy; ");
  ver = strstr(ver, " v");
} 


# There's a problem if the version is < 10.0.2.
if (ver && ver =~ "^ v[0-9]+[0-9.]+$")
{
  ver = substr(ver, 2);
  iver = split(ver, sep:'.', keep:FALSE);
  for (i=0; i<max_index(iver); i++)
    iver[i] = int(iver[i]);

  fix = split("10.0.2", sep:'.', keep:FALSE);
  for (i=0; i<max_index(fix); i++)
    fix[i] = int(fix[i]);

  for (i=0; i<max_index(iver); i++)
    if ((iver[i] < fix[i]))
    {
     if(report_verbosity > 0)
      {
        report = string(
          "\n",
          "The banner reports itself as MDaemon/WorldClient version ", ver, ".",
          "\n"
        );
       security_warning(port:port, extra:report);
      } 
      else
       security_warning(port);
      break;
    }
    else if (iver[i] > fix[i])
      break;
}
