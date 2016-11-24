#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(22016);
  script_version("$Revision: 1.9 $");

  script_name(english:"DB2 Administration Server Detection");
  script_summary(english:"Detects a DB2 Administration Server");

 script_set_attribute(attribute:"synopsis", value:
"A DB2 Administration Server is listening on the remote host." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a DB2 Administration Server.  DB2 is a
commercial database from IBM, and the Administration Server is used by
DB2 to administer databases across a network." );
 script_set_attribute(attribute:"see_also", value:"http://www.ibm.com/software/data/db2/udb/" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value: "n/a" );
 script_end_attributes();


  script_category(ACT_GATHER_INFO);
  script_family(english:"Databases");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("find_service1.nasl");
  script_require_ports("Services/unknown", 523);

  exit(0);
}


include("global_settings.inc");
include("byte_func.inc");
include("misc_func.inc");


if (thorough_tests && ! get_kb_item("global_settings/disable_service_discovery") ) {
  port = get_unknown_svc(523);
  if ( ! port ) exit(0);
}
else port = 523;
if (!get_tcp_port_state(port)) exit(0);


# Platform info.
platforms[5]  = "Windows, x86";
platforms[18] = "Linux, x86, 2.6 kernel";


function get_null_string(blob, pos)
{
  local_var i, tmp;

  if (isnull(pos)) pos = 0;

  tmp = NULL;
  for (i=pos; i<strlen(blob); i++)
  {
    if (ord(blob[i]) != 0)
      tmp += blob[i];
    else
      break;
  }
  return tmp;
}


function db2_send_recv(blob1, blob2)
{
  global_var platform, soc;
  local_var iter, len, res1, res2;

  if (isnull(blob1) || isnull(blob2)) return NULL;

  # nb: the last 4 bytes of blob1 usually but not always represent
  #     the length of blob2.
  send(socket:soc, data:blob1);
  send(socket:soc, data:blob2);

  # Work around occasional timeout issues.
  for (iter=1; iter<=5; iter++)
  {
    res1 = recv(socket:soc, length:41);
    # If it looks like DB2...
    if (
      strlen(res1) == 41 &&
      stridx(res1, raw_string(0, 0, 0, 0, "DB2DAS")) == 0
    )
    {
      set_byte_order(BYTE_ORDER_LITTLE_ENDIAN);

      if (isnull(platform)) platform = getbyte(blob:res1, pos:0x19);

      len = getdword(blob:res1, pos:0x25);
      for (iter=1; iter<=5; iter++)
      {
        res2 = recv(socket:soc, length:len);
        if (strlen(res2) == len) break;
        sleep(1);
      }
      break;
    }
  }
  return res2;
}


# Try to get some interesting information.
#
# - level (ie, version).
soc = open_sock_tcp(port);
if (soc)
{
  platform = NULL;
  level = NULL;

  req_1 = raw_string(
    0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 0x32, 0x44, 
    0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
    0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 0x39, 0x7a, 
    0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
    0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00, 0x00, 
    0x00
  );
  req_2 = raw_string(
    0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
    0x0c, 0x00, 0x00, 0x00, 0x04
  );
  res = db2_send_recv(blob1:req_1, blob2:req_2);
  close(soc);
  if (isnull(res)) exit(0);

  if (strlen(res) > 0xeb)
  {
    set_byte_order(BYTE_ORDER_BIG_ENDIAN);
    level = getword(blob:res, pos:0xb5) + "." +
            getword(blob:res, pos:0xc5) + "." + 
            getword(blob:res, pos:0xd5) + "." +
            getword(blob:res, pos:0xe5);
  }
}
# - server's Database Access Profile.
soc = open_sock_tcp(port);
if (soc)
{
  req_1 = raw_string(
    0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 0x32, 0x44, 
    0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
    0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 0x39, 0x7a, 
    0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
    0x00, 0x00, 0x00, 0x00, 0x02, 0x0d, 0x00, 0x00, 
    0x00
  );
  req_2 = raw_string(
    0x00, 0x00, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x0c, 
    0x00, 0x00, 0x00, 0x4a, 0x00
  );
  res = db2_send_recv(blob1:req_1, blob2:req_2);

  if (strlen(res))
  {
    req_1 = raw_string(
      0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 0x32, 0x44, 
      0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
      0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 0x39, 0x7a, 
      0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x05, 0x2c, 0x00, 0x00, 
      0x00
    );
    req_2 = raw_string(
      0x00, 0x00, 0x00, 0x2c, 0x00, 0x00, 0x00, 0x0c, 
      0x00, 0x00, 0x00, 0x08, 0x5e, 0x00, 0x4d, 0x66, 
      0xca, 0x5c, 0xea, 0x0a, 0xb7, 0x92, 0xcc, 0x5b, 
      0x15, 0x32, 0x19, 0x0d, 0x75, 0x4c, 0xbc, 0xf8, 
      0xdf, 0x02, 0x95, 0x8a, 0xe2, 0xb1, 0xed, 0xe1, 
      0x24, 0x6d, 0xfe, 0xee 
    );
    res = db2_send_recv(blob1:req_1, blob2:req_2);
  }

  if (strlen(res))
  {
    req_1 = raw_string(
      0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 0x32, 0x44, 
      0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
      0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 0x39, 0x7a, 
      0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x03, 0x34, 0x00, 0x00, 
      0x00
    );
    req_2 = raw_string(
      0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x0c, 
      0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0c, 
      0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x08, 
      0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x0c, 
      0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x10, 
      0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x4c, 
      0x00, 0x00, 0x04, 0xb8
    );
    res = db2_send_recv(blob1:req_1, blob2:req_2);
  }

  if (strlen(res))
  {
    req_1 = raw_string(
      0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 0x32, 0x44, 
      0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
      0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 0x39, 0x7a, 
      0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x0a, 0x5d, 0x00, 0x00, 
      0x00
    );
    req_2 = raw_string(
      0x00, 0x00, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x0c, 
      0x00, 0x00, 0x00, 0x4a, 0x01, 0x00, 0x00, 0x00, 
      0x10, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x4c, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 
      0x20, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x04, 0x00, 0x00, 0x04, 0xb8, 0x64, 0x62, 0x32, 
      0x64, 0x61, 0x73, 0x4b, 0x6e, 0x6f, 0x77, 0x6e, 
      0x44, 0x73, 0x63, 0x76, 0x00, 0x00, 0x00, 0x00, 
      0x20, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x04, 0x00, 0x00, 0x04, 0xb8, 0x64, 0x62, 0x32, 
      0x4b, 0x6e, 0x6f, 0x77, 0x6e, 0x44, 0x73, 0x63, 
      0x76, 0x53, 0x72, 0x76, 0x00
    );
    res = db2_send_recv(blob1:req_1, blob2:req_2);
  }

  if (strlen(res))
  {
    req_1 = raw_string(
      0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 0x32, 0x44, 
      0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
      0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 0x39, 0x7a, 
      0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x06, 0xca, 0x00, 0x00, 
      0x00
    );
    myip = split(this_host(), sep:".", keep:FALSE);
    req_2 = raw_string(
      0x00, 0x00, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x0c, 
      0x00, 0x00, 0x00, 0x4a, 0x01, 0x00, 0x00, 0x00, 
      0x20, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 
      0xa8, 0x00, 0x00, 0x00, 0x00, 0x44, 0xae, 0xb3, 
      0xd5, 
            int(myip[0]), int(myip[1]), int(myip[2]), int(myip[3]),
                                    0x00, 0x00, 0x00, 
      0x10, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x4c, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 
      0x10, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x4c, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 
      0x20, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x04, 0x00, 0x00, 0x04, 0xb8, 0x64, 0x62, 0x32, 
      0x4b, 0x6e, 0x6f, 0x77, 0x6e, 0x44, 0x73, 0x63, 
      0x76, 0x53, 0x72, 0x76, 0x00, 0x00, 0x00, 0x00, 
      0x20, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x04, 0x00, 0x00, 0x04, 0xb8, 0x64, 0x62, 0x32, 
      0x64, 0x61, 0x73, 0x4b, 0x6e, 0x6f, 0x77, 0x6e, 
      0x44, 0x73, 0x63, 0x76, 0x00, 0x00, 0x00, 0x00, 
      0x0c, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 
      0x04, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 
      0x0c, 0x00, 0x00, 0x00, 0x4c, 0xff, 0xff, 0xff, 
      0xff, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 
      0x0c, 0x00, 0x00, 0x00, 0x4c, 0xff, 0xff, 0xff, 
      0xff, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 
      0x0c, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x04, 
      0xb8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x42, 
      0x32, 0x44, 0x41, 0x53, 0x20, 0x20, 0x20, 0x20, 
      0x20, 0x20, 0x01, 0x04, 0x00, 0x00, 0x00, 0x10, 
      0x39, 0x7a, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xa4, 
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x04, 0x00, 
      0x00, 0x04, 0xb8, 0x64, 0x62, 0x32, 0x64, 0x61, 
      0x73, 0x4b, 0x6e, 0x6f, 0x77, 0x6e, 0x44, 0x73, 
      0x63, 0x76, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x04, 0x00, 
      0x00, 0x04, 0xb8, 0x64, 0x62, 0x32, 0x4b, 0x6e, 
      0x6f, 0x77, 0x6e, 0x44, 0x73, 0x63, 0x76, 0x53, 
      0x72, 0x76, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x4c, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x4c, 0x00, 
      0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x10, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x4c, 0x00, 
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x08, 0x00, 
      0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x0c, 0x00, 
      0x00, 0x00, 0x4c, 0x00, 0x00, 0x00, 0x01, 0x00, 
      0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x0c, 0x00, 
      0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0c, 0x00, 
      0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x18 
    );
    res = db2_send_recv(blob1:req_1, blob2:req_2);
  }
  close(soc);
}


# If we got some info from the remote host...
if (
  !isnull(level) ||
  (
    strlen(res) >= 0xE7 &&
    "DB2 Server Database Access Profile" >< res
  )
)
{
  # Register and report the service.
  register_service(port:port, ipproto:"tcp", proto:"db2das");

  info = "";
  if (!isnull(platform)) 
  {
    set_kb_item(name:"DB2/"+port+"/Platform", value:platform);
    if (isnull(platforms[platform]))
      info += "Platform : " + platform + '\n' +
              '           To help us better identify this platform, please send\n' +
              '           the platform number above along with details about the\n' +
              '           platform, including the operating system version and\n' +
              '           CPU architecture to db2-platform-info@nessus.org\n';
    else 
      info += "Platform : " + platforms[platform] + '\n';
  }
  if (!isnull(level)) 
  {
    set_kb_item(name:"DB2/"+port+"/Level", value:level);
    info += "Level    : " + level + '\n';
  }

  profile = strstr(res, "DB2 Server Database Access Profile");
  if (profile) profile = profile - "DB2 Server Database Access Profile";
  if (profile) info +=
      '\n' +
      'Here is the Database Access Profile that Nessus was able to read\n' +
      'from the remote host :\n' +
      '\n' +
      profile;

  security_note(port:port, extra: info);
}
