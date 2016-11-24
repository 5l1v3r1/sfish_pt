#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 
 script_id(10483);  
 script_version ("$Revision: 1.17 $");

 script_cve_id("CVE-1999-0508");
 script_xref(name:"OSVDB", value:"382");

 script_name(english:"PostgreSQL Default Unpassworded Account");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote database server can be accessed without a password." );
 script_set_attribute(attribute:"description", value:
"It is possible to connect to the remote PostgreSQL database server
using an unpassworded account.  This may allow an attacker to launch
further attacks against the database." );
 script_set_attribute(attribute:"solution", value:
"Log into this host and set a password for any affected accounts using
the 'ALTER USER' command. 

In addition, configure the service by editing the file 'pg_hba.conf'
to require a password (or Kerberos) authentication for all remote
hosts that have legitimate access to this service and to require a
password locally using the line 'local all password'." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
 script_summary(english:"Attempts to log into the remote PostgreSQL daemon");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 script_family(english:"Databases");
 script_dependencie("find_service1.nasl");
 script_require_ports("Services/postgres", 5432);
 exit(0);
}


port = get_kb_item("Services/postgres");
if(!port)port = 5432;
if(!get_port_state(port))exit(0);

#
# Request the database 'template1' as the user 'postgres' or 'pgsql'
# 
zero = raw_string(0x00);

user[0] = "postgres";
user[1] = "pgsql";

for(i=0;i<2;i=i+1)
{
 soc = open_sock_tcp(port);
 if(!soc)exit(0);
 usr = user[i];
 len = 224 - strlen(usr);

 req = raw_string(0x00, 0x00, 0x01, 0x28, 0x00, 0x02,
    	         0x00, 0x00, 0x74, 0x65, 0x6D, 0x70, 0x6C, 0x61,
		 0x74, 0x65, 0x31) + crap(data:zero, length:55) +
        usr +
       crap(data:zero, length:len);


 send(socket:soc, data:req);
 r = recv(socket:soc, length:5);
 r2 = recv(socket:soc, length:1024);
 
 if((r[0]=="R") && (strlen(r2) == 10))
  {
    dbs = "";
    req = raw_string(0x51) + "select * from pg_database;" + 
    	  raw_string(0x00);
    send(socket:soc, data:req);
    
    r = recv(socket:soc, length:65535);
    #display(r);
    close(soc);
    skip = 87;
    ok = 1;
    while(ok)
    {
     db = "";
 
     len = ord(r[skip]);
     len_r = strlen(r);
     lenskip = len + skip;
  
     if(lenskip > len_r)ok = 0;
     else
     {
      len = ord(r[skip]) - 4;
      for(i=0;i<len;i=i+1)
       db = db + r[skip+i+1];
    
      dbs = dbs + ". " + db + string("\n");
      skip = skip + len + 21 + len;
      if(skip > strlen(r))ok=0;
     }
   }
    
    report = string(
      "\n",
      "Nessus was able to log in as the user '", usr, "'.\n",
      "\n",
      "Here is the list of the databases on the remote host :\n",
      "\n",
      dbs, "\n"
    );
    security_hole(port:port, extra:report);
    set_kb_item(name: 'postgresql/no_pass/'+port, value: TRUE);
    exit(0);
  }
  close(soc);
}
