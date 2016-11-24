#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(16224);
 script_version ("$Revision: 1.6 $");
 script_bugtraq_id(12321);
 script_xref(name:"OSVDB", value:"13202");

 script_name(english:"FKey Arbitrary Remote File Disclosure");
 script_summary(english:"fkey file disclosure");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote finger daemon has an information disclosure vulnerability."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The remote finger daemon (possibly 'fkey') allows users to read\n",
     "arbitrary files by supplying a file name that is 10 characters\n",
     "or shorter.  A remote attacker could exploit this to read sensitive\n",
     "information, which could be used to mount further attacks."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://archives.neohapsis.com/archives/bugtraq/2005-01/0224.html"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"There is no known fix at this time.  Disable this service."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Misc.");

 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc."); 

 script_dependencie("find_service1.nasl");
 script_require_ports("Services/finger", 79);

 exit(0);
}

#
# The script code starts here
#

port = get_kb_item("Services/finger");
if(!port)port = 79;
if(get_port_state(port))
{
 soc = open_sock_tcp(port);
 if(soc)
 {
  buf = string("/etc/group\r\n");

  send(socket:soc, data:buf);
  data = recv(socket:soc, length:2048);
  close(soc);
  if ( egrep(pattern:"^bin:.:", string:data)  &&
       egrep(pattern:"^tty:.:", string:data)  &&
       egrep(pattern:"^nobody:.:", string:data)  )
	{
	report = "
Requesting the file /etc/group yielded : 

" + data +  "
";
	security_warning(port:port, extra:report);
 	}
   } 
}
