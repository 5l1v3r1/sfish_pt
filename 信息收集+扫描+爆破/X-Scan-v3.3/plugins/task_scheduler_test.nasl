#
# (C) Tenable Network Security, Inc.
#

#
# This script contains code from dcetest.nasl (C) Pavel Kankovsky
#


include("compat.inc");

if(description)
{
  script_id(13852);
  script_version("$Revision: 1.20 $");
  script_cve_id("CVE-2004-0212");
  script_bugtraq_id(10708);
  script_xref(name:"OSVDB", value:"7798");

  script_name(english:"MS04-022: Microsoft Windows Task Scheduler Remote Overflow (841873)");

 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code can be executed on the remote host." );
 script_set_attribute(attribute:"description", value:
"There is a flaw in the Task Scheduler application which could allow a
remote attacker to execute code remotely.  There are many attack vectors
for this flaw.  An attacker, exploiting this flaw, would need to either 
have the ability to connect to the target machine or be able to coerce a
local user to either install a .job file or browse to a malicious website." );
 script_set_attribute(attribute:"solution", value:
"Microsoft has released a set of patches for Windows 2000, XP and 2003 :

http://www.microsoft.com/technet/security/bulletin/ms04-022.mspx" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );

script_end_attributes();

  script_summary(english:"Remote MS Task Scheduler check");
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
  script_family(english:"Windows : Microsoft Bulletins");
  script_dependencie("os_fingerprint.nasl","dcetest.nasl","smb_nativelanman.nasl");
  script_require_ports(135);
  script_require_keys("Services/DCE/378e52b0-c0a9-11cf-822d-00aa0051e40f");
  exit (0);
}

#

include("misc_func.inc");

os = get_kb_item("Host/OS");
if ( os && "Windows 4.0" >< os ) exit(0); # NT not affected

os = get_kb_item ("Host/OS/smb") ;
if ( os && "Windows 4.0" >< os ) exit(0); # NT not affected

bind = raw_string(0x05,0x00,0x0b,0x00,0x10,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x01,0x00,0x00,0x00,
                  0x00,0x10,0x00,0x10,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00,
                  0xb0,0x52,0x8e,0x37,0xa9,0xc0,0xcf,0x11,0x82,0x2d,0x00,0xaa,0x00,0x51,0xe4,0x0f,
                  0x01,0x00,0x00,0x00,0x04,0x5d,0x88,0x8a,0xeb,0x1c,0xc9,0x11,0x9f,0xe8,0x08,0x00,
                  0x2b,0x10,0x48,0x60,0x02,0x00,0x00,0x00);

req = raw_string(0x05,0x00,0x00,0x83,0x10,0x00,0x00,0x00,0x5C,0x01,0x00,0x00,0x01,0x00,0x00,0x00,
0x34,0x01,0x00,0x00,0x00,0x00,0x03,0x00,0xB0,0x52,0x8E,0x37,0xA9,0xC0,0xCF,0x11,
0x82,0x2D,0x00,0xAA,0x00,0x51,0xE4,0x0F);


req2 = raw_string( 0xCC,0xFD,0x12,0x00,0x43,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x43,0x00,0x00,0x00,0x04,0x4e,0x45,0x53,0x53,0x55,0x53,0x03,
0x4e,0x45,0x53,0x53,0x55,0x53,0x4e,0x45,0x53,0x53,0x55,0x53,0x4e,0x45,0x53,0x53,
0x55,0x53,0x4e,0x45,0x53,0x53,0x55,0x53,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x42,0x10,0x40,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x42,0x10,0x42,0x00,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x80,0x10,0x32,0x00,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x42,0x42,0x42,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x08,0x42,0x42,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x00,0x00,0x00,0x00,
0x43,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x43,0x00,0x00,0x00,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x00,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x42,0x10,0x42,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x42,0x10,0x42,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x00,0x10,0x32,0x00,
0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x42,0x00,0x41,0x41,0x41,0x41,
0x41,0x41,0x41,0x41,0x08,0x42,0x00,0x00,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00);


req += req2;


storedport = get_kb_item ("Services/DCE/378e52b0-c0a9-11cf-822d-00aa0051e40f");
if (!storedport)
  exit (0);

soc = open_sock_tcp(storedport);
if (soc)
{
	send(socket:soc, data:bind);
        r = recv(socket:soc, length:64);
        if (r)
        {
        	send(socket:soc, data:req);
                r = recv(socket:soc, length:64);
                if (r)
                {
                	if ( (ord(r[28]) == 13) &&
                           (ord(r[29]) == 19) &&
                           (ord(r[30]) == 4) )
                        {
                        	security_hole(storedport);
				exit(0);
                        }
		}
	}
}
