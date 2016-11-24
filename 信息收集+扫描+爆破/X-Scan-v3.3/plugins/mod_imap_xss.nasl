#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(31647);
 script_version ("$Revision: 1.9 $");
 script_cve_id("CVE-2005-3352");
 script_bugtraq_id(15834);
 script_xref(name:"OSVDB", value:"21705");

 script_name(english: "Apache mod_imap Image Map Referer XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a module vulnerable to a cross-site
scripting attack." );
 script_set_attribute(attribute:"description", value:
"The remote Apache web server has the module 'mod_imap' (or
'mod_imagemap') installed.  The remote version of this module is
vulnerable to a cross-site scripting issue related to the handling of
the 'referrer' field of the remote server." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Apache 1.3.35, 2.0.56 or 2.2.6." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );

script_end_attributes();

 script_summary(english: "Uses the results of webmirror.nasl");
 script_category(ACT_GATHER_INFO); 
 script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");
 script_family(english: "Web Servers");
 script_dependencie("webmirror.nasl");
 script_require_ports("Services/www",80);
 exit(0);
}

#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

banner = get_http_banner(port:port);
if ( "Apache" >!< banner ) exit(0);
list = get_kb_list("www/" + port + "/content/extensions/map");
if ( isnull(list) ) exit(0);
list = make_list(list);
foreach item ( list )
{
  w = http_send_recv3(method:"GET", item:item + "?0,0", port: port, add_headers:
  make_array("Referer", "<script>window.alert(bar)</script>"));
  if (isnull(w)) exit(1, "the web server did not answer");
  res = w[2];
  if ( '<a href="<script>window.alert(bar)' >< res )
	{
	 security_warning(port:port, extra:'\nSending a malformed request to ' + item + ' yields :\n\n' + res);
	 set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
	 exit(0);
	}

}
