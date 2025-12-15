select
    f.title,
    f.rental_rate,
    count(i.inventory_id) as copies_in_stock,
    count(r.rental_id) as times_rented
from
    staging.film f
    join staging.inventory i on f.film_id = i.film_id
    left join staging.rental r on i.inventory_id = r.inventory_id
group by
    f.film_id,
    f.title,
    f.rental_rate
having
    times_rented <= 4
order by
    copies_in_stock desc