#
# (C) Tenable Network Security
#


include("compat.inc");

if(description)
{
 script_id(11414);
 script_version ("$Revision: 1.7 $");
 
 script_name(english:"IMAP Service Banner Retrieval");
 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

 script_set_attribute(attribute:"synopsis", value:
"An IMAP server is running on the remote host." );
 script_set_attribute(attribute:"description", value:
"An IMAP (Internet Message Access Protocol) server is
installed and running on the remote host." );
 script_set_attribute(attribute:"risk_factor", value:
"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );
script_end_attributes();

 summary["english"] = "Grab and display the IMAP banner";
 script_summary(english:summary["english"]);
 script_category(ACT_GATHER_INFO);
 script_family(english:"Service detection");

 script_dependencie("find_service1.nasl");
 script_require_ports("Services/imap", 143);
 exit(0);
}

include ("imap_func.inc");

port = get_kb_item("Services/imap");
if(!port) port = 143;

banner = get_imap_banner (port:port);
if(banner)
{
 report = string (
 	  	"The remote imap server banner is :\n\n",
		banner);

 security_note(port:port, extra:report);
}

