select
    strftime (r.rental_date, '%Y-%m') as rental_month,
    count(*) as number_of_rentals,
    sum(p.amount) as total_revenue
from
    staging.rental r
    join staging.payment p on r.rental_id = p.rental_id
where
    strftime (r.rental_date, '%Y') = '2005' -- Filtrera så endast 2005 syns då 2006 är 'current month'
group by
    rental_month
order by
    rental_month asc