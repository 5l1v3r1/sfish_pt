#
# (C) Tenable Network Security, Inc.
#


account = "root";
password = "alpine";


include("compat.inc");


if (description)
{
  script_id(42367);
  script_version("$Revision: 1.1 $");

  script_cve_id("CVE-1999-0502");

  script_name(english:"Default Password (alpine) for 'root' Account");
  script_summary(english:"Tries to log into the remote host");
     
  script_set_attribute(
    attribute:"synopsis",
    value:"An administrative account on the remote host uses a weak password."
  );
  script_set_attribute(
    attribute:"description",
    value:
"The account 'root' on the remote host has the password 'alpine'.

An attacker may leverage this issue to gain full access to the
affected system.

Note that iPhones are known to use these credentials by default and 
allow access via SSH when jailbroken."
  );
  script_set_attribute(
    attribute:"see_also", 
    value:"http://www.nessus.org/u?5689603a"
  );
  script_set_attribute(
    attribute:"solution", 
    value:"Set a strong password for this account or disable it."
  );
  script_set_attribute(
    attribute:"cvss_vector", 
    value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
  );
  script_set_attribute(
    attribute:"plugin_publication_date", 
    value:"2009/11/04"
  );
  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Default Unix Accounts");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("find_service1.nasl", "ssh_detect.nasl");
  script_require_ports("Services/telnet", 23, "Services/ssh", 22);

  exit(0);
}


include("default_account.inc");
include("global_settings.inc");

port = check_account(login:account, password:password);
if (port) security_hole(port);
