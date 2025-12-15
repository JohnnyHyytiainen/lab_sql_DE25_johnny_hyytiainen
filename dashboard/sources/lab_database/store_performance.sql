/* 
Task 1:
Question: F.3
Query:
 */
select
    'Store ' || s.store_id as store_name,
    sum(p.amount) as total_revenue
from
    staging.store s
    join staging.staff st on s.store_id = st.store_id
    join staging.payment p on st.staff_id = p.staff_id
group by
    s.store_id
order by
    total_revenue desc