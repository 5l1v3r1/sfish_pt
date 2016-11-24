#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(40564);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2009-1923", "CVE-2009-1924");
  script_bugtraq_id(35980, 35981);
  script_xref(name:"OSVDB", value:"56899");
  script_xref(name:"OSVDB", value:"56900");

  script_name(english: "MS09-039: Vulnerabilities in WINS Could Allow Remote Code Execution (969883) (uncredentialed check)");
  script_summary(english:"Determines the presence of update 969883");

  script_set_attribute(
    attribute:"synopsis",
    value:"Arbitrary code can be executed on the remote host through the WINS service"
  );
  script_set_attribute(
    attribute:"description", 
    value:string(
      "The remote host has a Windows WINS server installed.\n",
      "\n",
      "The remote version of this server has two vulnerabilities that may allow an\n",
      "attacker to execute arbitrary code on the remote system:\n",
      "\n",
      "  - One heap overflow vulnerability can be exploited by any attacker\n",
      "\n",
      "  - One integer overflow vulnerability can be exploited by a WINS replication\n",
      "partner.\n",
      "\n",
      "An attacker may use these flaws to execute arbitrary code on the remote system with\n",
      "SYSTEM privileges.\n"
    )
  );
  script_set_attribute(
    attribute:"solution", 
    value:string(
      "Microsoft has released a set of patches for Windows 2000 and 2003 :\n",
      "\n",
      "http://www.microsoft.com/technet/security/Bulletin/MS09-039.mspx"
    )
  );
  script_set_attribute(
    attribute:"cvss_vector", 
    value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
  );
  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");
  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
  script_dependencies("netbios_name_get.nasl");
  script_require_ports(42);
  exit(0);
}

#

include('byte_func.inc');

port = 42;
if ( ! get_port_state(port) ) exit(0, "Port 42 is closed");

soc = open_sock_tcp(port);
if ( ! soc ) exit(0, "Port 42 is closed");

request = raw_string (0x00,0x00,0x00,0x29,0x00,0x00,0x78,0x00,0x00,0x00,0x00,0x00,
		      0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0x00,0x02,0x00,0x05,
	    	      0x00,0x00,0x00,0x00,0x60,0x56,0x02,0x01,0x00,0x1F,0x6E,0x03,
	    	      0x00,0x1F,0x6E,0x03,0x08,0xFE,0x66,0x03,0x00);

send(socket:soc, data:request);

r = recv(socket:soc, length:4);
if (!r || strlen(r) != 4 ) exit (0, "WINS server shut the connection down");
len = getdword(blob:r, pos:0);
if ( len > 256 ) exit(1, "Invalid WINS reply");
r += recv(socket:soc, length:len);


if (strlen(r) < 20) exit (1, "Invalid WINS reply");

if (ord(r[6]) != 0x78) exit (1, "Invalid WINS reply");

pointer = substr(r,16,19);

request = raw_string (0x00,0x00,0x00,0x09,0xC7,0xF5,0xEC,0xE1) + pointer + raw_string(
		      0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00);

send(socket:soc, data:request);
r = recv(socket:soc, length:4);
if (!r || strlen(r) != 4 ) exit (0, "Server is patched");
len = getdword(blob:r, pos:0);
if ( len > 256 ) exit(1, "Invalid WINS reply");
r += recv(socket:soc, length:len);
close(soc);


if (ord(r[6]) == 0x78)
  security_hole(port);
else exit(0, "Server is patched");
