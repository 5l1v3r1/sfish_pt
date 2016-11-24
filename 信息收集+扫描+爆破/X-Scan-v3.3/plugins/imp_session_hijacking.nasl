#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10801);
 script_version ("$Revision: 1.22 $");
 script_cve_id("CVE-2001-0857");
 script_bugtraq_id(3525);
 script_xref(name:"OSVDB", value:"668");
 
 script_name(english:"Horde Imp Webmail status.php3 message Parameter XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server is hosting a PHP application that is affected by
a cross-site scripting vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote server is running IMP < 2.2.7.  Such versions are
potentially affected by a cross-site scripting attack which can be
used by an attacker to hijack a victim's IMP session.

*** Nessus solely relied on the version number of your
*** installation, so if you applied the hotfix already,
*** consider this alert as a false positive" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to IMP 2.2.7 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

 script_end_attributes();

 script_summary(english:"Checks IMP version");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2001-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}


include("http.inc");
include("misc_func.inc");
include("global_settings.inc");

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);
if(!can_host_php(port:port))exit(0);

dir[0] = "/";
dir[1] = "/imp/";
dir[2] = "/horde/imp/";

for(i=0;dir[i];i=i+1)
{
  res = http_send_recv3(method:"GET", item:string(dir[i],"status.php3"), port:port);
  if (isnull(res)) exit(1, "The remote web server did not respond.");

  res[2] = strstr(res[2], "IMP, Version");
  if (res[2])
  {
    r2 = strstr(res[2], "</font>");
    version = res[2] - r2;
    if (ereg(pattern:"IMP, Version ([0-1]\..*)|(2\.([0-1]\..*|2\.[0-6][^0-9]))", string:version))
    {
      security_hole(port);
      set_kb_item(name:'www/'+port+'/XSS', value:TRUE);
      exit(0);
    }
  }
}
