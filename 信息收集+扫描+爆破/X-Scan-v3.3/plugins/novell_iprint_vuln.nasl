#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(33227);
  script_cve_id("CVE-2008-2908");
  script_bugtraq_id(29736);
  script_xref(name:"OSVDB", value:"46194");
  script_version("$Revision: 1.4 $");

  script_name(english:"Novell iPrint Client for Windows ienipp.ocx ActiveX Multiple Variable Overflow");
  script_summary(english:"Checks for vulnerable version of Novell iPrint Client"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host contains an application that is affected by an
unspecified vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host has Novell iPrint Client installed.

The installed version of Novell iPrint is affected by an unspecified
vulnerability." );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?57976ae6" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Novell iPrint Client 4.36." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}

include("smb_func.inc");
include("smb_hotfixes.inc");

# nb: Since the issue is unspecified, cvss2 score is based on 
#     the following assumption (assuming the worst).
#
#    - Local issue with the possibility of arbitrary code execution.
#

rootfile = hotfix_get_systemroot();
if ( ! rootfile  ) exit(0);

share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:rootfile);
dll =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1\System32\nippcl32.dll", string:rootfile);

name    =  kb_smb_name();
port    =  kb_smb_transport();
login   =  kb_smb_login();
pass    =  kb_smb_password();
domain  =  kb_smb_domain();

if (!get_port_state(port)) exit(0);

soc = open_sock_tcp(port);
if (!soc) exit(0);

session_init(socket:soc, hostname:name);

rc = NetUseAdd(login:login, password:pass, domain:domain, share:share);
if (rc != 1)
{
 NetUseDel();
 exit(0);
}

fh = CreateFile(file:dll, 
	desired_access:GENERIC_READ, 
	file_attributes:FILE_ATTRIBUTE_NORMAL, 
	share_mode:FILE_SHARE_READ, 
	create_disposition:OPEN_EXISTING);

ver = NULL;

if (!isnull(fh))
{
  ver = GetFileVersion(handle:fh);
  CloseFile(handle:fh);
}
NetUseDel();

# Check the version number.
if (!isnull(ver))
{
  # Version that is not vulnerable.
  fix = split("4.3.6.0", sep:'.', keep:FALSE);
  for (i=0; i<max_index(fix); i++)
    fix[i] = int(fix[i]);

  for (i=0; i<max_index(ver); i++)
    if ((ver[i] < fix[i]))
    {
      if (report_verbosity)
      {
        version = string(ver[0], ".", ver[1], ".", ver[2], ".", ver[3]);
        report = string(
          "\n",
          "Version ", version, " of Novell iPrint is installed on the\n",
	  " remote host.\n"
        );
        security_hole(port:port, extra:report);
      }
      else security_hole(port);
      break;
    }
    else if (ver[i] > fix[i])
      break;
}       
