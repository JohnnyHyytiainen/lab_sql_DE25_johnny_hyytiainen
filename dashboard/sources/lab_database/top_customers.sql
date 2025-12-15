/* 
Task 1:
Question: F.2
Query:
 */
select
    c.customer_id,
    c.first_name || ' ' || c.last_name as full_name,
    count(r.rental_id) as total_rentals,
    sum(p.amount) as lifetime_value
from
    staging.customer c
    join staging.rental r on c.customer_id = r.customer_id
    join staging.payment p on r.rental_id = p.rental_id
group by
    c.customer_id,
    c.first_name,
    c.last_name
order by
    lifetime_value desc
limit
    10