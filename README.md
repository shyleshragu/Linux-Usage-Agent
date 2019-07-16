##INTRODUCTION
The objective of this project was to develope a Cluster Monitor Agent, that is, program a centralized and streamlined approach in collecting data. This approach helps in alleviating server load and relays data to specific agents allowing them to enrich the locally collected data.


##ARCHITECTURE AND DESIGN

1) 
![Capture](https://user-images.githubusercontent.com/51927842/60114751-75b5df80-9742-11e9-9ca9-aa9ba468b395.JPG)

2) 
Using psql, a database is created under the name "host_agent". Within the database, two tables were created named host_info and host_usage.
The purpose of "host_info" table was to collect and store information such as id, hostname, cpu number, cpu architecture, cpu model, cpu mhz, L2 cache, timestamp, and total memory.
The puspose of "host_usage" table was to collect and store information such as timestamp, host id, free memory, cpu idel, cpu kernel, disk io, available disk space.

3)
Using bash, two scripts were created named "host_info.sh" and "host_usage.sh".
The purpose of the "host_info.sh" script was to  collect information from the execution command prompt specifically psql_host, psql_port, db_name, psql_user and psql_password. Using these information, the program was to collect id, hostname, cpu number, cpu architecture, cpu model, cpu mhz, l2 cache, timestamp, and total memory space. The program was then supposed to insert the data into the host_info table.
The purpose of the "host_.sh" script was to  collect information from the execution command prompt specifically psql_name, psql_port, db_name, psql_user and psql_password. Using these information, the program was to collect timestamp, host id, free memory available, cpu idel, cpu kernel, disk io, and available disk space. The program was then supposed to insert the data into the host_usage table. It also gets the host_id from host_info table.


##USAGE
1)
Get into postgres database using command prompt. 
Create the database using sql:
"CREATE DATABASE host_agent;"

Create tables using sql:

host_info table

CREATE TABLE PUBLIC.host_info 
(
id	SERIAL NOT NULL,
hostname	VARCHAR NOT NULL,
cpu_number	INT2 NOT NULL,
cpu_architecture	VARCHAR NOT NULL,
cpu_model	VARCHAR NOT NULL,
cpu_mhz	FLOAT8 NOT NULL,
l2_cache	INT4 NOT NULL,
"timestamp"	TIMESTAMP NULL,
total_mem	INT4 NULL,
CONSTRAINT host_info_pk PRIMARY KEY (id),
CONSTRAINT host_info_un UNIQUE (hostname)
);


host_usage table

CREATE TABLE PUBLIC.host_usage
(
"timestamp"	TIMESTAMP NOT NULL,
host_id	SERIAL NOT NULL,
memory_free	INT4 NOT NULL,
cpu_idel	INT2 NOT NULL,
cpu_kernel	INT2 NOT NULL,
disk_io	INT4 NOT NULL,
disk_available	INT4 NOT NULL,
CONSTRAINT host_usage_host_fk FOREIGN KEY (host_id) REFERENCES host_info(id)
);


2)
To execute host_info.sh
bash ./host_info.sh localhost 5432 host_agent postgres password

3)
To execute host_usage.sh
bash ./host_usage.sh localhost 5432 host_agent postgres password

4)
enter crontab by typing "crontab -e" in cmd prompt
* * * * * bash /...directory/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log

host_usage.sh is executed every minite and stored in database and /tmp/host_usage.log


##IMPROVEMENTS 
1) handle hardware update
2) script run-time minimization
3) bash scripting needs improvement
