#
# (C) Tenable Network Security, Inc.
#

# Script audit and contributions from Carmichael Security
#      Erik Anderson <eanders@carmichaelsecurity.com> (nb: domain no longer exists)
#      Added BugtraqID
#
# MA added an Apache2 vulnerability
# http://secunia.com/advisories/10064/
#


include("compat.inc");

if(description)
{
 script_id(10294);
 script_version ("$Revision: 1.37 $");
 script_cve_id("CVE-1999-0174");
 script_bugtraq_id(2251);
 script_xref(name:"OSVDB", value:"230");
 
 script_name(english:"Multiple Vendor view_source CGI Traversal Arbitrary File Access");
 
 script_set_attribute(attribute:"synopsis", value:
"It is possible to access arbitrary files from the remote 
system." );
 script_set_attribute(attribute:"description", value:
"The 'view_source' CGI is installed. This CGI has a well 
known security flaw that lets an attacker read arbitrary
files with the privileges of the http daemon (usually root 
or nobody)." );
 script_set_attribute(attribute:"solution", value:
"remove it from /cgi-bin." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:N/A:N" );

script_end_attributes();

 
 script_summary(english:"Checks for the presence of /cgi-bin/view_source");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
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

if( report_paranoia < 2 ) exit(0);
port = get_http_port(default:80);
no404 = get_kb_item(string("www/no404/", port));
if (no404) exit(0);


i = 0;
pat[i++] = "filename=";
pat[i++] = "";

i = 0;
rel[i++] = "../../../../../../../../..";
rel[i++] = "";

foreach dir (cgi_dirs())
 foreach r (rel)
  foreach p (pat)
  {
    res = http_send_recv3(method:"GET", item:string(dir, "/view_source?", p, r, "/etc/passwd"), port:port);
   if(isnull(res)) exit(1,"Null response to view_source request.");

   if(egrep(pattern:"root:.*:0:[01]:.*", string:res[2]))
   {
     security_hole(port);
     exit(0);
   }
  }
