##1)
SELECT 
cpu_number,
host_id,
total_mem OVER (
PARTITION BY cpu_number
)
FROM
host_usage
INNER JOIN
host_info USING (cpu_number);
ORDER BY cpu_number
GROUP BY cpu_number




##2)
SELECT
host_id,
host_name,
total_mem,
used_memory_percentage=(total_mem - memory_free)/total_mem OVER (
PARTITION BY host_name, total_mem
)
FROM
host_info
INNER JOIN
host_usage USING (host_name, total_mem);
