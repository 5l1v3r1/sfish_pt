#

# Changes by Tenable:
# - Revised plugin title (4/15/009)

include("compat.inc");

if (description)
{
  script_id(33926);
  script_version("$Revision: 1.6 $");

  script_xref(name:"OSVDB", value:"50012");

  script_name(english:"Adobe Dreamweaver dwsync.xml Remote Information Disclosure");
  script_summary(english:"Checks for ./_notes/dwsync.xml files which can lead to enumeration of files and directories." );

  script_set_attribute(attribute:"synopsis", value:
"The remote web server discloses the location of files and directories.");
  script_set_attribute(attribute:"description", value:
"Adobe's Dreamweaver is known to produce 'dwsync.xml' files.  These
contain synchronization information that may include the list of files
and directories synchronised.  This can lead to information
disclosure.");
  script_set_attribute(attribute:"see_also", value:
"http://kb.adobe.com/selfservice/viewContent.do?externalId=91b33859&sliceId=1");
  script_set_attribute(attribute:"solution", value:
"Disable the 'Maintain synchronization information' option from the
Remote Info category of the advanced view of the Site Definition
dialog box.  In addition, remove the offending files if already
created by the system.");
  script_set_attribute(attribute:"cvss_vector", value:
"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N");
  script_set_attribute(attribute:"plugin_publication_date", value:
"2008/08/18");
  script_end_attributes();

  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");
  script_copyright(english:"This script is Copyright (C) 2008-2009 Westpoint Ltd");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_dependencies("http_version.nasl", "no404.nasl", "webmirror.nasl") ; 
  exit(0);
}
include("http_func.inc");
include("http_keepalive.inc");
include("global_settings.inc");


if ( get_kb_item("www/" + port + "/no404") ) exit(0);


file = string("dwsync.xml");
default_dir = ("_notes");

port = get_http_port(default:80);
warning ="";

if (thorough_tests)
   dirs = get_kb_list(string("www/", port, "/content/directories"));
if (isnull(dirs)) dirs = make_list("");   # The root directory

function check_dir(dir)
{
   if (!ereg(string:dir, pattern:string(default_dir+"$")))
   {
     check_dir(dir:string(dir, "/", default_dir));
   }

  if( is_cgi_installed_ka(item:string(dir,"/",file), port:port))
  {
     parse_file(url:string(dir,"/",file)); 
  }
}

# Quick and dirty attempt, will only understand xml in the exact format generated by dreamweaver.

function parse_file(url)
{
  local_var line, matchinglines, req, res;
  global_var warning;

  req = http_get(port:port, item:url); 
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:1);
  if (res)
  {
   matchinglines = egrep(pattern:'<file *name="', string:res, icase:1);
   if (matchinglines)
   {
    matchinglines = split(matchinglines, keep:0);
    warning = string(warning,build_url(port:port, qs:url) ,':','\n'); 
    # We should add these to the knowledge base.

    foreach line (matchinglines)
    { 
      line = ereg_replace(pattern:'<file *name="([^"]+)".*', replace:"\1", string:line, icase:1); 
      warning = string(warning, "\t",line,"\n"); 
    }
   }
 }
}


foreach path (dirs)
{
    
  check_dir(dir:path);
}

if (warning)
{
  security_warning(port:port, extra:string("\nThe following dwsync.xml files where discovered :\n\n",warning));
}


