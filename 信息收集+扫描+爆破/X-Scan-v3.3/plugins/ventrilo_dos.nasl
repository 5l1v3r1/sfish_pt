#
# Josh Zlatin-Amishav and Boaz Shatz
# GPLv2
#


include("compat.inc");

if(description)
{
 script_id(19757);
 script_version ("$Revision: 1.10 $");

 script_cve_id("CVE-2005-2719");
 script_bugtraq_id(14644);
 script_xref(name:"OSVDB", value:"18946");

 name["english"] = "Ventrilo Server Malformed Status Query Remote DoS";
 script_name(english:name["english"]);

 script_set_attribute(attribute:"synopsis", value:
"The remote Ventrilo service can be disabled remotely." );
 script_set_attribute(attribute:"description", value:
"A malicious user can crash the remote version of Ventrilo due to a 
vulnerability in the way the server handles malformed status queries." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2005-08/0763.html" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );
script_end_attributes();


 summary["english"] = "Sends malformed status query requests";
 script_summary(english:summary["english"]);

 script_category(ACT_GATHER_INFO);

 script_copyright(english:"Copyright (C) 2005-2009 Josh Zlatin-Amishav");
 family["english"] = "Denial of Service";
 script_family(english:family["english"]);
 script_dependencie("ventrilo_detect.nasl");
 script_require_keys("Ventrilo/version");
 script_require_ports("Services/ventrilo");

 exit(0);
}

# Make sure we're really looking at a Ventrilo server.
version = get_kb_item("Ventrilo/version");
if ( ! version ) exit(0);

port = get_kb_item("Services/ventrilo");
if (!port) exit(0);

if ( ereg(pattern:"^2\.(1\.[2-9]|2\.|3\.0($|[^0-9.]))", string:version) )
{
    security_warning(port:port, proto:"udp");
}
