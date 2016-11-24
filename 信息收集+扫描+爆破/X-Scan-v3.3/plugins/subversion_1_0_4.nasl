#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if(description)
{
  script_id(12261);
  script_version ("$Revision: 1.11 $");
  script_cve_id("CVE-2004-0397");
  script_bugtraq_id(10386);
  script_xref(name:"OSVDB", value:"6301");

  script_name(english:"Subversion < 1.0.3 apr_time_t data Conversion Remote Overflow");
  script_summary(english:"Subversion remote Buffer Overflow");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote service is vulnerable to a buffer overflow.'
  );

  script_set_attribute(
    attribute:'description',
    value:'The remote host is vulnerable to a remote stack-based
overflow.  An attacker, exploiting this hole, would be
given full access to the target machine.  Versions of
Subversion less than 1.0.3 are vulnerable to this attack.
This vulnerability was discovered by Stefan Esser and posted
to public mailing lists.'
  );

  script_set_attribute(
    attribute:'solution',
    value:'Upgrade to version 1.0.3 or higher'
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://archives.neohapsis.com/archives/bugtraq/2004-05/0203.html'
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://subversion.tigris.org/svn-sscanf-advisory.txt'
  );


  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P'
  );

  script_end_attributes();
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
  script_family(english:"Misc.");
  script_dependencie("subversion_detection.nasl");
  script_require_ports("Services/subversion");
  exit(0);
}



# start check
# mostly horked from MetaSploit Framework subversion overflow check

port = get_kb_item("Services/subversion");
if ( ! port ) port = 3690;

if (! get_tcp_port_state(port))
	exit(0);

dat = string("( 2 ( edit-pipeline ) 24:svn://host/svn/nessusr0x ) ");

soc = open_sock_tcp(port);
if (!soc)
        exit(0);

r = recv_line(socket:soc, length:1024);

if (! r)
	exit(0);

send(socket:soc, data:dat);
r = recv_line(socket:soc, length:256);

if (! r)
	exit(0);

#display(r);

if (egrep(string:r, pattern:".*subversion-1\.0\.[0-2][^0-9].*"))
{
	security_hole(port);
}

close(soc);
exit(0);
