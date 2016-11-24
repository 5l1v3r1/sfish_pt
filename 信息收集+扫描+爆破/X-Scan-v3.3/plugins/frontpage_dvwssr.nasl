#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");


if(description)
{
 script_id(10369);
 script_version ("$Revision: 1.45 $");
 script_cve_id("CVE-2000-0260");
 script_bugtraq_id(1109);
 script_xref(name:"OSVDB", value:"282");
 script_xref(name:"IAVA", value:"2000-t-0002");
 script_xref(name:"IAVA", value:"2000-t-0003");

 script_name(english:"Microsoft FrontPage dvwssr.dll Multiple Vulnerabilities");
 script_summary(english:"Checks for the presence of  /_vti_bin/_vti_aut/dvwssr.dll");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote web server has multiple vulnerabilities."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The version of Microsoft FrontPage running on the remote host has\n",
     "the following vulnerabilities in '/_vti_bin/_vti_aut/dvwssr.dll' :\n\n",
     "  - A security bypass vulnerabilty that allows anyone with\n",
     "    web authoring permissions to alter other users' files.\n\n",
     "  - A remote buffer overflow vulnerability that could allow\n",
     "    a remote attacker to crash the server, or possibly\n",
     "    execute arbitrary code."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://www.nessus.org/u?3772b65c"
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://www.microsoft.com/technet/security/bulletin/MS00-025.mspx"
 );
 script_set_attribute(
   attribute:"solution", 
   value:string(
     "Delete all copies of dvwssr.dll from the server.  Refer to the\n",
     "Microsoft Security Bulletin for further information."
   )
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Web Servers");

 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 script_dependencie("find_service1.nasl", "http_version.nasl", "www_fingerprinting_hmap.nasl");
 script_require_ports("Services/www", 80);

 exit(0);
}

#
# The script code starts here
#

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

banner = get_http_banner(port:port);
if ( ! banner ) exit(0);
if ( ! egrep(pattern:"^Server: .*IIS/[34]", string:banner ) ) exit(0);

w = http_send_recv3(method:"GET", item:"/", port:port);
if (ereg(pattern:"^HTTP/1\.. 40[14] ", string:w[0]))exit(0);

if (!ereg(pattern:"^HTTP/1\.. ", string:w[0]))exit(0);
  
w = http_send_recv3(method:"GET", item:"/_vti_bin/_vti_aut/dvwssr.dll", port:port);
code = w[0];
r = strcat(w[1], '\r\n', w[2]);

  #
  # IIS will return a 500 error for an unknown file,
  # and a 401 error when the file is present.
  #
  # According to http://archives.neohapsis.com/archives/win2ksecadvice/2000-q2/0015.html 
  # Example 3: 
  # $ nc -v -w2 target.system 80 
  # GET /_vti_bin/_vti_aut/dvwssr.dll HTTP/1.0 (hit enter twice) 
  # Connection closed by foreign host. 
  #
  # The connection closed means that you had the rights to run the DLL, but 
  # since no parameters were passed the connection was completed. 
  
  if("WWW-Authenticate:" >< r)exit(0);
  
  is200 = ereg(pattern:"^HTTP/[0-9]\.[0-9] 200 ", string:code);

  if(("HTTP/1.1 401 Access Denied" >< code) ||
      (strlen(r) == 0)  || is200 )  
  {
  if ( is200  && strlen(r))
   {
    no404 = tolower(get_kb_item(string("www/no404/",  port)));
    if(no404)
    {
     if(no404 >< tolower(r))exit(0);
    }
   }
   security_hole(port);
  }


