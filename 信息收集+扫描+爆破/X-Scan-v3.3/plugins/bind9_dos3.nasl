#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(40422);
  script_version("$Revision: 1.1 $");

  script_cve_id("CVE-2009-0696");
  script_bugtraq_id(35848);
  script_xref(name:"OSVDB", value:"56584");

  script_name(english:"ISC BIND Dynamic Update Message Handling Remote DoS");
  script_summary(english:"Checks version of BIND");

  script_set_attribute(attribute:"synopsis", value:
"The remote name server may be affected by a denial of service
vulnerability." );
  script_set_attribute(attribute:"description", value:

"The version of BIND installed on the remote host suggests that it
suffers from a denial of service vulnerability, which may be triggered
by sending a malicious dynamic update message to a zone for which the
server is the master, even if that server is not configured to allow
dynamic updates. 

Note that Nessus obtained the version by sending a special DNS request
for the text 'version.bind' in the domain 'chaos', the value of which
can be and sometimes is tweaked by DNS administrators." );
  script_set_attribute(attribute:"see_also", value:"https://www.isc.org/node/474" );
  script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/725188" );
  script_set_attribute(attribute:"solution", value:
"Upgrade to BIND 9.4.3-P3 / 9.5.1-P3 / 9.6.1-P3 or later." );
  script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );
  script_set_attribute(attribute:"vuln_publication_date", value: "2009/07/28");
  script_set_attribute(attribute:"patch_publication_date", value: "2009/07/28");
  script_set_attribute(attribute:"plugin_publication_date", value: "2009/07/29");
  script_end_attributes();
 
  script_category(ACT_GATHER_INFO);
  script_family(english: "DNS");
  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
  script_dependencies("bind_version.nasl");
  script_require_keys("bind/version");

  exit(0);
}


include("global_settings.inc");

# Banner checks of BIND are prone to false-positives so we only
# run the check if reporting is paranoid.
if (report_paranoia <= 1) exit(0);


ver = get_kb_item("bind/version");
if (!ver) exit(0);

if (ver =~ "^9\.(4\.([0-2]|3-P[0-2])|5\.(0|1-P[0-2])|6\.(0|1-P[0-2]))$")
  security_warning(port:53, proto:"udp");
