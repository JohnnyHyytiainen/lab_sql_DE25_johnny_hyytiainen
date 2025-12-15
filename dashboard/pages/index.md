# Business intelligence report - Sakila database

## 1 - Our Top Performing Genres:
**Key insights:** Sports and Sci-Fi generate the most revenue. The manager should prioritize acquiring more sports and action oriented films.


```sql revenue_query
-- Aggregated view for performance
-- Joins: category -> film_category -> film -> inventory -> rental -> payment
select * from lab_database.revenue_per_genre
```

<BarChart 
    data={revenue_query} 
    x=genre 
    y=total_revenue 
    yFmt="usd" 
    title="Revenue by top 5 Genres" 
/>


## 2 - Customer Lifetime Value (**CLV**):
**Key insights:** I have identified our top 10 most valuable customers from both stores, based on total amount spent. These customers are prime candidates for a loyalty program should we decide to implement such a program in the future.

```sql customers_query
-- Calculates (CLV) 
-- Aggregates total spend per customer_id
-- Joins: customer -> rental -> payment
select * from lab_database.top_customers
```

<DataTable
    data={customers_query} 
    search=true> 
    <Column id=full_name title="Customer Name"/> 
    <Column id=total_rentals title="Rentals Count" align=right/> 
    <Column id=lifetime_value title="Lifetime Value ($)" fmt="usd" align=right/> 
</DataTable>


## 3 - Store Performance Analysis.
**Observation:** Store 2 is currently outperforming Store 1. **However,** Store 1 is close behind and could overtake Store 2 depending on future inventory and staffing decisions.  
**Recommendation:** Management should investigate staffing, location and inventory discrepancies to balance performance.

```sql store_query
-- Links payments to stores from the staff member that did the transaction
-- Joins: store -> staff -> payment
select * from lab_database.store_performance
```

<BarChart
    data={store_query}
    x=store_name
    y=total_revenue
    yFmt="usd"
    series=store_name
    colorPalette={['#05963aff', '#f30c0cff']}
    title="Revenue Comparison: Store 1 vs Store 2"
/>


## 4 - Seasonal Trends Analysis
**Key insights:** As per the Managers request, I have analyzed the revenue streams over time. We can clearly see that the end of summer (July/August) is our most profitable period. As stated in analysis #1 we should focus on having our **top performing** genres in stock, to not miss out on revenue by not having enough rentals in stock.

```sql monthly_trends_query
-- Groups by month using strftime. Filters out incomplete data from 2006-02
-- Joins: rental -> payment
select * from lab_database.monthly_revenue
```

<BarChart 
    data={monthly_trends_query} 
    x=rental_month 
    y=total_revenue 
    yFmt="usd" 
    title="Monthly revenue trends 2005" 
/>


## 5 & 6 - Analysis of inventory with focus on underperforming assets.
**Initial investigation:** I first looked for movies which had **zero** rentals to identify titles not being rented or not in circulation.  
**Result:** We currently have **0** movies with zero rentals. This is a positive indicator that our entire stock is being utilized by our customers.

**Deep dive:** I expanded the search to find movies with **low circulation** (rented four times or less).
**Discovery:** The discovery after a deeper dive **3 titles** that are underperforming relative to their stock levels (4 copies each, but only rented 4 times total) were identified.

```sql underperforming_query
-- Use LEFT JOIN on rental to make sure to include inventory items even if they have 0 rentals
-- Joins: film -> inventory -> (LEFT) rental
select * from lab_database.underperforming_films 
```

<DataTable 
    data={underperforming_query}> 
    <Column id=title title="Film Title"/> 
    <Column id=rental_rate title="Price $" align=right/> 
    <Column id=copies_in_stock title="Copies in stock" align=right/> 
    <Column id=times_rented title="Total times rented" align=right/> 
</DataTable>