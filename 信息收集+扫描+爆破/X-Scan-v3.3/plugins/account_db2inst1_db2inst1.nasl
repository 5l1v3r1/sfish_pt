#
# This script was written by Chris Foster
#
#
# See the Nessus Scripts License for details
#

account = "db2inst1";
password = "db2inst1";


include("compat.inc");

if(description)
{
 script_id(11862);
 script_version ("$Revision: 1.14 $");
 script_cve_id("CVE-2001-0051");
 script_name(english:"Default Password (db2inst) for 'db2inst1' Account");
 script_summary(english:"Logs into the remote host");

 script_set_attribute(attribute:"synopsis", value:
"The remote host has an account with a default password set." );
 script_set_attribute(attribute:"description", value:
"The account 'db2inst1' has the password 'db2inst1'.
An attacker may use it to gain further privileges on this system." );
 script_set_attribute(attribute:"solution", value:
"Set a strong password for this account or disable it.
This may disable dependent applications so beware." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();


 script_copyright(english:"This script is Copyright (C) 2003-2009 Chris Foster");

 script_category(ACT_GATHER_INFO);

 script_family(english:"Default Unix Accounts");
 
 script_dependencie("find_service1.nasl", "ssh_detect.nasl");
 script_require_ports("Services/telnet", 23, "Services/ssh", 22);
 exit(0);
}

#
# The script code starts here : 
#
include("default_account.inc");
include("global_settings.inc");

if ( ! thorough_tests && ! get_kb_item("Settings/test_all_accounts")) exit(0);

port = check_account(login:account, password:password);
if(port)security_hole(port);
