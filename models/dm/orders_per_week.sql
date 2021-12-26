SELECT date_trunc('week', order_date) as week_start,
	status,
	count(*) as orders_count
FROM {{ref('sat_order_details')}}
group by date_trunc('week', order_date),
	status
order by week_start