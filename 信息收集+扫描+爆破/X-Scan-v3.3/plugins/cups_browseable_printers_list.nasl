#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(11754);
 script_version("$Revision: 1.6 $");
 
 script_name(english:"CUPS Printer List Disclosure");
 script_summary(english:"Obtains the list of printers on the remote host");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote printer service is leaking information."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The remote host is running CUPS (Common Unix Printing System).\n\n",
     "It is possible to connect to this port and browse '/printers' to\n",
     "obtain the list of printers this host can access.  A remote attacker\n",
     "could use this information to mount further attacks."
   )
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Filter incoming traffic to this port."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Misc.");

 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");

 script_dependencie("http_version.nasl");
 script_require_ports("Services/www",631);
 script_require_keys("www/cups");
 exit(0);
}

#

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


ports = add_port_in_list(list:get_kb_list("Services/www"), port:631);

foreach port (ports)
{
 res = http_send_recv3(method:"GET", item:"/printers", port:port);
 if("CUPS" >< res[2] )
 {
 default = egrep(pattern:"Default Destination:", string:res[2]);
 if( default )
 {
 default = ereg_replace(pattern:".*Default Destination:</B> <.*>(.*)</A>",
 			replace:"\1",
			string:default);
 
 
 printers = split(egrep(pattern:"Description:.*<BR>", string:res[2]));
 ps = NULL;
 foreach p (printers)
 {
  ps += ereg_replace(pattern:".*Description: (.*)<BR>", string:p,
 			 replace:"  . \1") ;
 
 }	
  	
 report = "
The following list of printers has been obtained :
 
" + ps + "
The remote host default printer is " + default + "
";
 security_warning(port:port, extra:report);
 exit(0);
 }
 }
}
