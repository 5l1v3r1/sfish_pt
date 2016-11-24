#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(14255);
 script_version ("$Revision: 1.10 $");
 
 script_name(english:"Microsoft Outlook Web Access (OWA) Version Detection");
 
 script_set_attribute(attribute:"synopsis", value:
"It is possible to extract the version of Microsoft Exchange
server installed on the remote host." );
 script_set_attribute(attribute:"description", value:
"Microsoft Exchange Server with Outlook Web Access (OWA) embeds the 
Exchange version number inside the default HTML web page. By 
requesting the default HTML page, Nessus was able to extract the
Microsoft Exchange server version." );
 script_set_attribute(attribute:"solution", value:
"n/a" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
	
script_end_attributes();

 
 script_summary(english:"Outlook Web Access version check");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("find_service1.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#

include("http_func.inc");
include("http_keepalive.inc");

function newloc(ban)
{
	local_var location, newloc;

	location = egrep(pattern:"^Location:", string:ban);
	if (strstr(ban, "Location: http://"))
	{
        	newloc = ereg_replace(pattern:"^Location: http://[^/]*(/.*)$",
                       string:location,
                       replace:"\1");
	}
	else
	{
		newloc = ereg_replace(pattern:"^Location: (/.*)$",
			string:location,
			replace:"\1");
	}	
	return(chomp(newloc));
}



# so, default Microsoft Exchange with OWA embeds version number inside HTML comments like:
# size=2><BR>Microsoft Exchange Server </FONT><FONT color=black size=2>Version 5.5 
#      SP4<BR><!-- 2653.23 -->Microsoft (R) Outlook (TM) Web Access <snip>
#
# go out on google and you'll see that most sites keep at least one of sigs[]
# or text[] 

sigs[0] = "1457." ;  xchange[0] = "5.0 SP 0";  text[0] = "Version 5.0 SP0";
sigs[1] = "1458." ;  xchange[1] = "5.0 SP 1";  text[1] = "Version 5.0 SP1";
sigs[2] = "1460.13"; xchange[2] = "5.0 SP 2";  text[2] = "Version 5.0 SP2";
sigs[3] = "1960.4";  xchange[3] = "5.5 SP 0";  text[3] = "Version 5.5 SP0";
sigs[4] = "2232.5";  xchange[4] = "5.5 SP 1";  text[4] = "Version 5.5 SP1";
sigs[5] = "2448.4";  xchange[5] = "5.5 SP 2";  text[5] = "Version 5.5 SP2";
sigs[6] = "2650.24"; xchange[6] = "5.5 SP 3";  text[6] = "Version 5.5 SP3";
sigs[7] = "2653.23"; xchange[7] = "5.5 SP 4";  text[7] = "Version 5.5 SP4";
sigs[8] = "4417.";   xchange[8] = "2000 SP 0"; text[8] = "Version 2000 SP0";


port = get_http_port(default:80);

if ( ! can_host_asp(port:port) ) 
	exit(0);

cgi = "/exchange/logon.asp";

soc = http_open_socket(port);
if ( ! soc ) exit(0);
req = http_get(item:cgi, port:port);
send(socket:soc, data:req);
r = http_recv(socket:soc);
http_close_socket(soc);
if (! egrep(pattern:"^HTTP/1\.[01] (200|302|403)", string:r) )
	exit(0);

# permutations that I thought of
# 200 OK -> sigmatch
# 302 redirect -> 200 OK -> sigmatch
# 403 Req SSL -> 200 OK -> sigmatch
# 302 redirect -> 403 Req SSL -> 200 OK -> sigmatch


if (egrep(pattern:"^HTTP/1\.[01] 302.*", string:r))
{
	goto = newloc(ban:r);
	soc = http_open_socket(port);
	if ( ! soc ) exit(0);
	req = http_get(item:goto, port:port);
	send(socket:soc, data:req);
	r = http_recv(socket:soc);
}



if (egrep(pattern:"HTTP/1\.[0-9] 403 Access Forbidden", string:r))
{
	#display("ROCKING AND ROLLIN AND WHATNOT OVER SSL\n");       
        port = 443;
        soc = open_sock_tcp(port, transport:ENCAPS_SSLv23);
	if ( ! soc ) exit(0);
	req = string("GET ", cgi, " HTTP/1.1\r\nHost: ", get_host_ip(), "\r\n\r\n");
        send(socket:soc, data:req);
        r = http_recv(socket:soc);
	if (egrep(pattern:"^HTTP/1\.[01] 302.*", string:r))
	{
		close(soc);
		goto = newloc(ban:r);
		req = string("GET ", goto, " HTTP/1.1\r\nHost: ", get_host_ip(), "\r\n\r\n");
		soc = open_sock_tcp(port, transport:ENCAPS_SSLv23);
		if ( ! soc ) exit(0);
		send(socket:soc, data:req);
		r = http_recv(socket:soc);
	}
		
}


if ( ("L_strMailboxPlease_Message" >< r) || ("Outlook (TM) Web Access" >< r) )
{
        for (i=0; sigs[i]; i++)
        {
                if ( (sigs[i] >< r) || (text[i] >< r) )
                {
		    set_kb_item(name:'www/'+port+'/Exchange/default_page', value:r);
                    myrep = string("The remote host is running Outlook Web Access on Exchange version ", xchange[i], 
			".\nOWA is a web-based interface to Microsoft Exchange Server and allows remote users",
			"\nto access email, calendar, and folders over the Internet\n");
		    
                        security_note(port:port, extra:myrep);
                        exit(0);
                }
        }
}
