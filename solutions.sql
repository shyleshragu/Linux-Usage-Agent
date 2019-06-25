##1)
SELECT
 host_info.cpu_number,
 host_usage.host_id,
 host_info.total_mem
FROM host_info
 INNER JOIN host_usage ON host_usage.host_id=host_info.id
 ORDER BY host_info.total_mem DESC;



##2)
SELECT host_usage.host_id, host_info.hostname, host_info.total_mem, host_usage.memory_free, CAST((host_info.total_mem - host_usage.memory_free)/host_info.total_mem*100.0000000 as FLOAT(53))
FROM host_info INNER JOIN host_usage ON host_usage.host_id=host_info.id;


