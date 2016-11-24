#
# This script was written by Josh Zlatin-Amishav <josh at ramat dot cc>
#
# This script is released under the GNU GPLv2

# Changes by Tenable:
# - Revised plugin title (6/4/09)

include("compat.inc");

if(description)
{
 script_id(19679);
 script_version ("$Revision: 1.10 $");

 script_cve_id("CVE-2005-2595");
 script_bugtraq_id(14573);
 script_xref(name:"OSVDB", value:"18772");
 script_xref(name:"Secunia", value:"16435");

 script_name(english:"Dada Mail Archived Message XSS");
 script_summary(english:"Checks Dada Mail version");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PERL script that is affected by a
cross-site scripting vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote web server is running Dada Mail, a free, e-mail list
management system written in Perl. 

According to its banner, the version of this software installed on the
remote host does not properly validate user-written content before
submitting that data to the archiving system.  A malicious user could
embed arbitrary JavaScript in archived messages to later be executed
in a user's browser within the context of the affected web site."
 );
 script_set_attribute(attribute:"see_also", value:"http://mojo.skazat.com/download/testing_2_10_0_alpha1.html");
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 2.10 alpha 1 or higher."
 );
 script_set_attribute(attribute:"cvss_vector", value:"CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N");
 script_set_attribute(attribute:"plugin_publication_date", value:"2005/09/12");
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"CGI abuses : XSS");
 script_copyright(english:"Copyright (C) 2005-2009 Josh Zlatin-Amishav");
 script_dependencies("http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
include("global_settings.inc");
include("misc_func.inc");

port = get_http_port(default:80);
if(!get_port_state(port))exit(0);

if (thorough_tests) dirs = list_uniq(make_list("/cgi-bin/dada", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
 req = http_get(
   item:string(
     dir, "/mail.cgi"
   ), 
   port:port
 );
 res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
 if (isnull(res)) exit(0);

 # versions 2.9.x are vulnerable
 if(egrep(pattern:"Powered by.*Dada Mail 2\.9", string:res))
 {
        security_warning(port);
	set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
        exit(0);
 }
}
