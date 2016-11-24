#
# (C) Tenable Network Security, Inc.
#

account = "public";
password = "public";

include("compat.inc");

if(description)
{
 script_id(17290);
 script_version ("$Revision: 1.15 $");

 script_cve_id("CVE-1999-0383");
 script_bugtraq_id(183);
 script_xref(name:"OSVDB", value:"267");
 
 script_name(english:"Default Password (public) for 'public' Account");

 script_set_attribute(attribute:"synopsis", value:
"The remote system can be accessed with a default user account." );
 script_set_attribute(attribute:"description", value:
"The account 'public' on the remote host has the password 'public'.  An
attacker may use it to gain further privileges on this system." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/1999_1/0023.html" );
 script_set_attribute(attribute:"solution", value:
"Set a password for this account or disable it." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

 script_end_attributes();

 script_summary(english:"Logs into the remote host");
 script_category(ACT_GATHER_INFO);

 script_family(english:"Default Unix Accounts");
 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 
 script_dependencie("find_service1.nasl", "ssh_detect.nasl");
 script_require_ports("Services/telnet", 23, "Services/ssh", 22);
 exit(0);
}

#
include("default_account.inc");
include("global_settings.inc");

if ( ! thorough_tests && ! get_kb_item("Settings/test_all_accounts")) exit(0);

port = check_account(login:account, password:password);
if(port)security_hole(port);
