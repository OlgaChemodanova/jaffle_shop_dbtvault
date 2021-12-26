with actual_record as (
	SELECT sat.CUSTOMER_PK,
		max(EFFECTIVE_FROM) as EFFECTIVE_FROM
	FROM {{ref('sat_customer_details')}} sat
	WHERE EFFECTIVE_FROM < {{var('date')}}::timestamp
	group by sat.CUSTOMER_PK
)


SELECT ar.CUSTOMER_PK,
	sat.first_name,
	sat.last_name,
	sat.email,
	ar.EFFECTIVE_FROM
FROM actual_record ar
INNER JOIN {{ref('sat_customer_details')}} sat
ON sat.EFFECTIVE_FROM = ar.EFFECTIVE_FROM
	and sat.CUSTOMER_PK  = ar.CUSTOMER_PK

