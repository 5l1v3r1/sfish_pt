#
#  This script was written by David Maciejak <david dot maciejak at kyxar dot fr>
#
# Ref: James Bercegay of the GulfTech Security Research Team
# This script is released under the GNU GPLv2


include("compat.inc");

if(description)
{
  script_id(14644);
  script_version("$Revision: 1.13 $");

  script_name(english:"Xedus Detection");
 
 script_set_attribute(attribute:"synopsis", value:
"A web server is running on the remote host." );
 script_set_attribute(attribute:"description", value:
"The remote host runs Xedus Peer to Peer webserver, it provides
the ability to share files, music, and any other media, as well 
as create robust and dynamic web sites, which can feature 
database access, file system access, with full .NET support." );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );
script_end_attributes();


  script_summary(english:"Checks for presence of Xedus");
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004-2009 David Maciejak");
  script_family(english:"Peer-To-Peer File Sharing");
  script_require_ports("Services/www", 4274);
  script_dependencies("httpver.nasl");
  exit(0);
}


include("http_func.inc");
include("http_keepalive.inc");

exit(0); # FP-prone
port = 4274;
if(!get_port_state(port))exit(0);

 soc = http_open_socket(port);
 if(soc)
 {
  buf = http_get(item:"/testgetrequest.x?param='free%20nessus'", port:port);
  send(socket:soc, data:buf);
  rep = http_recv(socket:soc);
  if(egrep(pattern:"free nessus", string:rep))
  {
    set_kb_item(name:string("xedus/",port,"/running"),value: TRUE);
    set_kb_item(name:"Services/www/" + port + "/embedded", value:TRUE);
    security_note(port);
  }
  http_close_socket(soc);
 }
exit(0);
