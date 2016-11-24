#  
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(11947);
 script_version ("$Revision: 1.11 $");
 script_cve_id("CVE-2003-0977");
 script_bugtraq_id(9178);
 script_xref(name:"OSVDB", value:"2941");
 script_xref(name:"MDKSA", value:"MDKSA-2003:112-1");
 
 script_name(english:"CVS pserver Crafted Module Request Arbitrary File / Directory Creation");
 script_summary(english:"Logs into the remote CVS server and asks the version");
 
 script_set_attribute(
   attribute:"synopsis",
   value:string(
     "The revision control service running on the remote host has an\n",
     "arbitrary file creation vulnerability."
   )
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "According to its version number, the CVS server running on the remote\n",
     "remote host may allow an attacker to create directories (and possibly\n",
     "files) at the root of the filesystem where the CVS repository is located."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://archives.neohapsis.com/archives/bugtraq/2003-12/0188.html"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Upgrade to CVS 1.11.10 or later."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Misc.");

 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");

 script_require_ports("Services/cvspserver", 2401);
 script_dependencies("find_service1.nasl", "cvs_pserver_heap_overflow.nasl");

 exit(0);
}

include('global_settings.inc');

port = get_kb_item("Services/cvspserver");
if(!port)port = 2401;
version =  get_kb_item(string("cvs/", port, "/version"));
if ( ! version ) exit(0);

if(ereg(pattern:".* 1\.([0-9]\.|10\.|11\.[0-9][^0-9]).*", string:version))
     	security_warning(port);
