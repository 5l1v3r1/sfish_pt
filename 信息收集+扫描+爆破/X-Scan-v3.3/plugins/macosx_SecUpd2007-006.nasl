#
# (C) Tenable Network Security, Inc.
#

if ( ! defined_func("bn_random") ) exit(0);


include("compat.inc");

if(description)
{
 script_id(25566);
 script_version ("$Revision: 1.7 $");
 script_cve_id("CVE-2007-2401", "CVE-2007-2399");
 script_bugtraq_id(24597, 24598);
 script_xref(name:"OSVDB", value:"36130");
 script_xref(name:"OSVDB", value:"36449");
 script_xref(name:"OSVDB", value:"36450");

 script_name(english:"Mac OS X Multiple Vulnerabilities (Security Update 2007-006)");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a Mac OS X update which fixes a security
issue." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of Mac OS X 10.4 or 10.3 which
does not have the security update 2007-006 applied. 

This update fixes security flaws in WebKit and WebCore which might
allow an attacker to execute arbitrary code on the remote host. 

To execute arbitrary code, an attacker would need to lure a user of
the remote host into visiting a malicious website containing a
specially malformed html file which would trigger a buffer overflow." );
 script_set_attribute(attribute:"solution", value:
"Install the security update 2007-006 :

http://www.apple.com/support/downloads/securityupdate2007006universal.html" );
 script_set_attribute(attribute:"see_also", value:"http://docs.info.apple.com/article.html?artnum=305759" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 script_summary(english:"Check for the presence of the SecUpdate 2007-006");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");
 script_family(english:"MacOS X Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/MacOSX/packages");
 exit(0);
}


packages = get_kb_item("Host/MacOSX/packages");
if ( ! packages ) exit(0);



uname = get_kb_item("Host/uname");
if ( egrep(pattern:"Darwin.* (7\.[0-9]\.|8\.[0-9]\.|8\.10\.)", string:uname) )
{
  if (!egrep(pattern:"^SecUpd(Srvr)?(2007-00[6-9]|200[89]-|20[1-9][0-9]-)", string:packages)) 
    security_hole(0);
}
