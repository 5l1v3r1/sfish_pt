#
# (C) Tenable Network Security
#


include("compat.inc");

if (description) {
  script_id(18587);
  script_version("$Revision: 1.7 $");

  script_cve_id("CVE-2005-2085");
  script_bugtraq_id(14077);
  script_xref(name:"OSVDB", value:"17608");
 
  script_name(english:"Inframail FTP Server NLST Command Remote Overflow");

 script_set_attribute(attribute:"synopsis", value:
"The remote FTP server is vulnerable to a buffer overflow attack." );
 script_set_attribute(attribute:"description", value:
"The remote host is running the FTP server component of Inframail, a
commercial suite of network servers from Infradig Systems. 

According to its banner, the installed version of Inframail suffers
from a buffer overflow vulnerability that arises when the FTP server
component processes an NLST command with an excessively long argument
(around 102400 bytes).  Successful exploitation will cause the service
to crash and may allow arbitrary code execution." );
 script_set_attribute(attribute:"see_also", value:"http://reedarvin.thearvins.com/20050627-01.html" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2005-06/0348.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Inframail 7.12 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:S/C:C/I:C/A:C" );
script_end_attributes();

 
  summary["english"] = "Checks for remote buffer overflow vulnerability in Inframail FTP Server";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_family(english:"FTP");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencies("ftpserver_detect_type_nd_version.nasl", "ftp_overflow.nasl");
  script_exclude_keys("ftp/false_ftp", "ftp/msftpd", "ftp/ncftpd", "ftp/fw1ftpd", "ftp/vxftpd");
  script_require_ports("Services/ftp", 21);

  exit(0);
}


include("ftp_func.inc");


port = get_kb_item("Services/ftp");
if (!port) port = 21;
if (!get_port_state(port)) exit(0);


# Do a banner check for the vulnerability.
banner = get_ftp_banner(port:port);
if (
  banner && 
  egrep(string:banner, pattern:"InfradigServers-FTP \(([0-5]\..*|6.([0-2].*|3[0-7]))\)")
) {
  security_hole(port);
}
