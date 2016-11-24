#
# This script is copyright � 2001 by EMAZE Networks S.p.A.
# under the General Public License (GPL). All Rights Reserved.
#
# Script audit and contributions from Carmichael Security <http://www.carmichaelsecurity.com>
#      Erik Anderson <eanders@carmichaelsecurity.com>
#      Added BugtraqID

# Changes by Tenable:
# - Updated description, static report [RD]
# - Title update, output formatting, family change (8/18/09)


include("compat.inc");

if(description)
{
 	script_id(10823);
	script_version("$Revision: 1.19 $");

	script_cve_id("CVE-2001-0872");
 	script_bugtraq_id(3614);
	script_xref(name:"IAVA", value:"2001-t-0017");
	script_xref(name:"OSVDB", value:"688");

 	script_name(english:"OpenSSH UseLogin Environment Variable Local Command Execution");
 
 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code may be run on the remote host." );
 script_set_attribute(attribute:"description", value:
"You are running a version of OpenSSH which is older than 3.0.2.

Versions prior than 3.0.2 are vulnerable to an environment variables
export that can allow a local user to execute command with root
privileges.  This problem affect only versions prior than 3.0.2, and
when the UseLogin feature is enabled (usually disabled by default)" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to OpenSSH 3.0.2 or apply the patch for prior
versions. (Available at: ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH)" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C" );
	
script_end_attributes();

 
 	script_summary(english:"Checks for the remote SSH version");
 	script_category(ACT_GATHER_INFO);
 	script_copyright(english:"This script is copyright (C) 2001-2009 by EMAZE Networks S.p.A.");
	script_family(english:"Misc.");
	script_dependencie("ssh_detect.nasl");
 	script_require_ports("Services/ssh", 22);
 
 	exit(0);
}


#
# The script code starts here
#

include("backport.inc");

port = get_kb_item("Services/ssh");
if(!port) port = 22;

banner = get_kb_item("SSH/banner/" + port);
if ( ! banner ) exit(0);

banner = tolower(get_backport_banner(banner:banner));

if(ereg(pattern:"ssh-.*-openssh[-_](1\..*|2\..*|3\.0.[0-1]).*" , string:banner)) 
	{
		security_hole(port);
	}
