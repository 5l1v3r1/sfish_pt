#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description) {
  script_id(18202);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2005-1409", "CVE-2005-1410");
  script_bugtraq_id(13475, 13476);
  script_xref(name:"OSVDB", value:"16323");
  script_xref(name:"OSVDB", value:"16324");

  script_name(english:"PostgreSQL < 8.0.3 Multiple Vulnerabilities");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote database server is affected by multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the version of PostgreSQL installed on the
remote host may suffer from the following vulnerabilities :

  - Character Conversion Vulnerability
    Unprivileged users can call functions supporting client-
    server character set conversion from SQL commands even
    though those functions do not validate their arguments.

  - tsearch2 Vulnerability
    If installed, the 'contrib/tsearch2' module permits users
    to at a minimum crash the backend because it misdeclares 
    several functions as returning type 'internal' when in 
    fact they do not have any 'internal' argument." );
 script_set_attribute(attribute:"see_also", value:"http://www.postgresql.org/about/news.315" );
 script_set_attribute(attribute:"see_also", value:"http://developer.postgresql.org/docs/postgres/release-8-0-3.html" );
 script_set_attribute(attribute:"solution", value:
"Implement the changes described in the PostgreSQL advisory
or upgrade to 8.0.3." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:S/C:P/I:P/A:P" );
script_end_attributes();

 
  script_summary(english:"Checks for character conversion and tsearch2 module vulnerabilities in PostgreSQL");
  script_category(ACT_GATHER_INFO);
  script_family(english:"Databases");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("find_service2.nasl");
  script_require_ports("Services/postgres", 5432);

  exit(0);
}


include("global_settings.inc");


port = get_kb_item("Services/postgres");
if (!port) port = 5432;
if (!get_port_state(port)) exit(0);


# Request the database 'template1' as the user 'postgres' or 'pgsql'.
zero = raw_string(0x00);
user[0] = "postgres";
user[1] = "pgsql";

for (i=0; i<2; i=i+1) {
  soc = open_sock_tcp(port);
  if(!soc) exit(0);

  usr = user[i];
  len = 224 - strlen(usr);
  req = raw_string(
          0x00, 0x00, 0x01, 0x28, 0x00, 0x02,
          0x00, 0x00, 0x74, 0x65, 0x6D, 0x70, 0x6C, 0x61,
          0x74, 0x65, 0x31
        ) + 
        crap(data:zero, length:55) +
        usr +
        crap(data:zero, length:len);

  send(socket:soc, data:req);
  res = recv(socket:soc, length:5);
  res2 = recv(socket:soc, length:1024);
  if ((res[0]=="R") && (strlen(res2) == 10)) {
    req = raw_string(0x51) + 
          "select version();" + 
    	  raw_string(0x00);
    send(socket:soc, data:req);
    res = recv(socket:soc, length:65535);
    res = strstr(res, "PostgreSQL");

    if (res != NULL) {
      for (i=0; i<strlen(res); i++) {
        if (ord(res[i]) == 0) break;
      }
      res = substr(res, 0, i-1);
      # nb: the vulnerabilities affect 7.3.0 - 8.0.2.
      if (ereg(string:res, pattern:"PostgreSQL (7\.[34]|8\.0\.[0-2][^0-9])")){
     	security_warning(port);
      }
    }
    else if ("ERROR: function version()" >< res && report_paranoia > 1) security_warning(port);
    exit(0);
  }
}
