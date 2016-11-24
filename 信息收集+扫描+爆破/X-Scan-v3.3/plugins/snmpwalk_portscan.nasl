#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if(description)
{
  script_id(14274);
  script_version ("$Revision: 1.21 $");
  script_name(english:"Nessus SNMP Scanner");
  script_summary(english: "Find open ports by browsing SNMP MIB");

  script_set_attribute(
    attribute:'synopsis',
    value:'SNMP information is enumerated to learn about other open ports.'
  );

  script_set_attribute(
    attribute:'description',
    value:'This plugin runs an SNMP scan against the remote machine to find open ports.
See the section \'plugins options\' to configure it'
  );

  script_set_attribute(
    attribute:'solution',
    value:'n/a'
  );

  script_set_attribute(
    attribute:'risk_factor',
    value:'None'
  );

  script_end_attributes();

  script_category(ACT_SCANNER);

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_family(english: "Port scanners");
  if ( NASL_LEVEL < 3210 )
    script_dependencies("ping_host.nasl","snmp_settings.nasl", "portscanners_settings.nasl");
  else
    script_dependencies("ping_host.nasl","snmp_settings.nasl", "portscanners_settings.nasl", "wmi_netstat.nbin","netstat_portscan.nasl");

  exit(0);
}

include("misc_func.inc");
include("snmp_func.inc");
include("ports.inc");

if ( get_kb_item("Host/full_scan") ) exit(0);

#---------------------------------------------------------#
# Function    : scan                                      #
# Description : do a snmp port scan with get_next_pdu     #
# Notes       : 'ugly' port check is due to solaris       #
#---------------------------------------------------------#

function scan(socket, community, oid, ip, ip2, val, any)
{
 local_var soid, pport_1, pport_2, port, pattern, port2, v, list;
 local_var	seen;
 list = make_list();

 soid = string (oid, ".", ip, ".0");
 pport_1 = -1;
 pport_2 = -1;

 init_snmp ();

 while(1)
 {
  port = snmp_request_next (socket:socket, community:community, oid:soid);
  if (!isnull(port) && issameoid(origoid:oid, oid:port[0]))
  {
   if (seen[port[0]]) break;
   seen[port[0]] = 1;

   # UDP
   pattern = strcat("^",str_replace(string:oid, find:".", replace:"\."),"\.([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\.([0-9]+)$");
   v = eregmatch(string: port[0], pattern: pattern);
   if (! isnull(v))
   {
    if (! any && v[1] != ip && v[1] != ip2 && v[1] != "127.0.0.1")
    {
      break;
    }
   }
   else # TCP
   {
    pattern = strcat("^",str_replace(string:oid, find:".", replace:"\."),"\.([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\.([0-9]+)\.[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\.([0-9]+)");
    v = eregmatch(string: port[0], pattern: pattern);
    if ( isnull(v) ||
        (! any && v[1] != ip && v[1] != ip2 && v[1] != "127.0.0.1" ) )
    {
    pattern = strcat("^",str_replace(string:oid, find:".", replace:"\."),"\.16\.(0\.0\.0\.0\.0\.0\.0\.0\.0\.0\.0\.0\.0\.0\.0\.0)\.([0-9]+)");
    v = eregmatch(string: port[0], pattern: pattern);
    if ( isnull(v) )
     {
      break;
     }
    }
   }

    if (any ||
        ((isnull(val) || port[1] == val) && (v[1] == ip || v[1] == ip2)) )
    {
     list = make_list (list, int(v[2]));
    }

    pport_1 = v[2];
    pport_2 = v[3];
    soid = port[0];
  }
  else
    break;
 }

 return list;
}


#---------------------------------------------------------#
# Function    : scan_tcp                                  #
# Description : do a snmp tcp port scan                   #
#---------------------------------------------------------#

function scan_tcp (socket, community, ip, ip2, any)
{
 return scan (socket:socket, community:community, oid:"1.3.6.1.2.1.6.13.1.1", ip:ip, ip2: ip2, val:2, any: any);
}

function scan_tcp6 (socket, community, ip, ip2, any)
{
 return scan (socket:socket, community:community, oid:"1.3.6.1.2.1.6.20.1.4.2", ip:ip, ip2: ip2, val:NULL, any: any);
}


#---------------------------------------------------------#
# Function    : scan_udp                                  #
# Description : do a snmp udp port scan                   #
#---------------------------------------------------------#

function scan_udp (socket, community, ip, ip2)
{
 return scan (socket:socket, community:community, oid:"1.3.6.1.2.1.7.5.1.2", ip:ip, ip2: ip2, val:NULL);
}



## Main code ##

check = get_kb_item("PortscannersSettings/probe_TCP_ports");

if (defined_func("get_preference") &&
    "yes" >< get_preference("unscanned_closed"))
 unscanned_closed = TRUE;
else
 unscanned_closed = FALSE;

if (unscanned_closed)
{
  tested_tcp_ports = get_tested_ports(proto: 'tcp');
  tested_udp_ports = get_tested_ports(proto: 'udp');
}
else
{
  tested_tcp_ports = make_list();
  tested_udp_ports = make_list();
}


snmp_comm = get_kb_item("SNMP/community");
if (!snmp_comm) exit (0);

snmp_port = get_kb_item("SNMP/port");
if (! snmp_port) snmp_port = 161;

soc = open_sock_udp(snmp_port);
if (! soc)  exit (0);

# TCP scan
tcp_list = make_list (
   scan_tcp (socket:soc, community:snmp_comm, ip:"0.0.0.0", ip2: get_host_ip(), any: check),
   scan_tcp (socket:soc, community:snmp_comm, ip: get_host_ip(), ip2: "0.0.0.0", any: check),
   scan_tcp6 (socket:soc, community:snmp_comm, ip:"0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0", any: FALSE)
           );

# UDP
udp_list = make_list (
     scan_udp (socket:soc, community:snmp_comm, ip:"0.0.0.0", ip2: get_host_ip()),
     scan_udp (socket:soc, community:snmp_comm, ip:get_host_ip(), ip2: "0.0.0.0")
           );

prev = NULL; n_tcp = 0;
foreach tcp_port (sort(tcp_list))
{
 if (tcp_port == prev) continue;
 prev = tcp_port;
 if (unscanned_closed && ! tested_tcp_ports[tcp_port]) continue;
 if (check)
 {
   s = open_sock_tcp(tcp_port);
   if (! s) continue;
   close(s);
 }
 n_tcp ++;
 scanner_add_port(proto:"tcp", port:tcp_port);
}

prev = NULL; n_udp = 0;
foreach udp_port (sort(udp_list))
{
 if (udp_port == prev) continue;
 prev = udp_port;
 if (unscanned_closed && ! tested_udp_ports[udp_port]) continue;
 n_udp ++;
 scanner_add_port(proto:"udp", port:udp_port);
}

if (n_tcp > 0 || n_udp > 0)
{
 set_kb_item(name: "Host/scanned", value: TRUE);
 set_kb_item(name: "Host/full_scan", value: TRUE);
 set_kb_item(name: "Host/TCP/scanned", value: TRUE);
 set_kb_item(name: "Host/TCP/full_scan", value: TRUE);
 set_kb_item(name: 'Host/scanners/snmp_scanner', value: TRUE);
 security_note(port: snmp_port, proto: "udp",
data: strcat(
'Nessus snmp scanner was able to retrieve the open port list\n',
'with the community name: ', snmp_comm, '\n',
'It found ', n_tcp, ' open TCP ports and ', n_udp, ' open UDP ports\n'));
}

if (max_index(udp_list) > 0)
{
 set_kb_item(name: "Host/udp_scanned", value: TRUE);
 set_kb_item(name: "Host/UDP/full_scan", value: TRUE);
 set_kb_item(name: "Host/UDP/scanned", value: TRUE);
}
