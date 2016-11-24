#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10172);
 script_version ("$Revision: 1.24 $");
 script_cve_id("CVE-1999-1061");
 script_xref(name:"OSVDB", value:"132");

 script_name(english:"HP LaserJet Printer Unauthenticated Access");

 script_set_attribute(attribute:"synopsis", value:
"The remote printer has no password set." );
 script_set_attribute(attribute:"description", value:
"The remote printer has no password set.  This allows anyone to change
its IP or potentially to intercept print jobs sent to it." );
 script_set_attribute(attribute:"solution", value:
"Telnet to this printer and set a password." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:C" );

script_end_attributes();

 script_summary(english:"Notifies that the remote printer has no password");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");
 script_family(english:"Misc.");
 script_dependencie("telnetserver_detect_type_nd_version.nasl");
 script_require_ports(23);
 exit(0);
}

#
# The script code starts here
#

include('telnet_func.inc');
passwordless = 0;
port = 23;

banner = get_telnet_banner(port:port);
if ( "JetDirect" >!< banner ) exit(0);
 
if(get_port_state(port))
{
 soc = open_sock_tcp(port);
 if(soc)
 {
  buf = telnet_negotiate(socket:soc);
  if("JetDirect" >< buf){
  	set_kb_item(name:"devices/hp_printer", value:TRUE);
  	buf += recv(socket:soc, length:1024);
	buf = tolower(buf);
	if("password" >!< buf && "username" >!< buf)  passwordless = 1;
	}
 else {
  	buf += recv(socket:soc, length:1024, timeout:2);
	if("JetDirect" >< buf)
	{
	 set_kb_item(name:"devices/hp_printer", value:TRUE);
	 if("password" >!< buf && "username" >!< buf) passwordless = 1;
 	}
      }
   if ( passwordless ) {
# Send '/' to retrieve the current settings
        request = '/\r\n';
	send(socket:soc, data:request);
	info = recv(socket:soc, length: 1024);
	if ( "JetDirect" >< info ) {
		report = '\nIt was possible to obtain the remote printer configuration : ' + info;
	} else {
		report = NULL;
        }
	security_hole(port:port, extra:report);
  }
  close(soc);
 }
}
