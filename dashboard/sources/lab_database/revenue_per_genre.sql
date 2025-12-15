/* 
Task 1:
Question: F.1
Query:
 */
select
    c.name as genre,
    sum(p.amount) as total_revenue
from
    staging.category c
    join staging.film_category fc on c.category_id = fc.category_id
    join staging.film f on fc.film_id = f.film_id
    join staging.inventory i on f.film_id = i.film_id
    join staging.rental r on i.inventory_id = r.inventory_id
    join staging.payment p on r.rental_id = p.rental_id
group by
    c.name
order by
    total_revenue desc
limit
    5