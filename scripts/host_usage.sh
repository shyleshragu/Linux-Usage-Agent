#! /bin/bash

#arguments declaration
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password1=$5

get_memory_free(){
	memory_free=$(vmstat -t | head -n3 | tail -n1 | awk '{print $4}') 
}

get_cpu_idel(){
	cpu_idel=$( vmstat -t | head -n3 | tail -n1 | awk '{print $15}')
}

get_cpu_kernel(){
	cpu_kernel=$(vmstat -t | head -n3 | tail -n1 | awk '{print $14}')
}

get_disk_io(){
	disk_io=$(vmstat -d | head -n3 | tail -n1 | awk '{print $10}')
}

get_disk_available(){
	disk_available=$(df -BM / | head -n3 | tail -n1 | awk '{print $4}' | sed 's/M//')
}

#STEP1: parse data and setup variables
get_memory_free
get_cpu_idel
get_cpu_kernel
get_disk_io
get_disk_available
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

#STEP2: SAVE HOSTID 
host_id=$(cat ~/host_id)

#STEP3: construct INSERT statement
insert_stmt=$(cat <<-END
INSERT INTO host_usage ("timestamp", host_id, memory_free, cpu_idel, cpu_kernel, disk_io, disk_available) VALUES('${timestamp}', '${host_id}', ${memory_free}, ${cpu_idel}, ${cpu_kernel}, ${disk_io}, ${disk_available});
END
)
echo $insert_stmt

#STEP4: EXECUTE INSERT STATEMENT
export PGPASSWORD=$psql_password1
psql -h $psql_host -p $psql_port -U $psql_user -d $db_name -c "$insert_stmt"
sleep 1
