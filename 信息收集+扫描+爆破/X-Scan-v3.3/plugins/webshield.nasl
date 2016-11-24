#
# (C) Tenable Network Security, Inc.
#

# This script was written by Renaud Deraison <deraison@cvs.nessus.org>
# Thanks to Jari Helenius <jari.helenius@mawaron.com>

include( 'compat.inc' );

if(description)
{
  script_id(10557);
  script_version ("$Revision: 1.18 $");
  script_cve_id("CVE-2000-0738", "CVE-2000-1130");
  script_bugtraq_id(1589, 1993);
  script_xref(name:"OSVDB", value:"456");
  script_xref(name:"OSVDB", value:"4740");

  script_name(english:"McAfee WebShield SMTP 4.5 Multiple Vulnerabilities");
  script_summary(english:"Checks the remote banner");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote service is vulnerable to multiple issues.'
  );

  script_set_attribute(
    attribute:'description',
    value:"The remote WebShield server is subject to two flaws :

	- It may let mail pass against some filter rules if the
	  attached files names have some strange chars in them
	- It is possible for an outsider to crash this program
	  and force its reinstallation

*** Nessus did not actually test for these flaws - it just relied
*** on the banner to identify them. Therefore, this warning may be
*** a false positive"
  );

  script_set_attribute(
    attribute:'solution',
    value: 'Contact the vendor for the fixed version of WebShield (later than 4.5).'
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://archives.neohapsis.com/archives/bugtraq/2000-11/0324.html'
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://archives.neohapsis.com/archives/ntbugtraq/2000-q3/0101.html'
  );

  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
  script_family(english:"SMTP problems");
  script_dependencie("smtpserver_detect.nasl", "sendmail_expn.nasl");
  script_exclude_keys("SMTP/wrapped");
  script_require_ports("Services/smtp", 25);
  exit(0);
}


include("smtp_func.inc");

port = get_kb_item("Services/smtp");
if(!port)port = 25;
if (get_kb_item('SMTP/'+port+'/broken')) exit(0);

if(get_port_state(port))
{
 soc = open_sock_tcp(port);
 if(soc)
 {
  r = smtp_recv_banner(socket:soc);

# MR1 not vulnerable
# http://www.nai.com/common/media/mcafeeb2b/support/WSHSMTP-MR1readme.txt


  if(egrep(string:r, pattern:"^220.*WebShield.*V4\.5 MR1[a-z] .*"))exit(0);

  if(egrep(string:r,
	pattern:"^220 .* WebShield SMTP V(([1-3]\..*)|(4\.[0-5])) .*$"))
		security_hole(port);
  }
}
