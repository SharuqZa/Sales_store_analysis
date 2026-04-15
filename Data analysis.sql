select * from sales

--Data analysis 
--Top 5 product most selling product by quantity...?

select top 5 product_name, sum(quantity) as total_product_sales
from sales 
where status = 'delivered'
group by product_name
order by total_product_sales desc


--Business problem : we don't which product are in demand
--Business impact : Helps priorities stock and boost sales through targeted promotions 


-------------------------------------------------------------------
-------------------------------------------------------------------


--Top 5 product most cancelled product by?

select top 5 product_name, count(*) As total_cancelled 
from sales 
where status ='cancelled'
group by product_name
order by total_cancelled


--Business problem : frequent cancellation affect revenue and customer's trust 
--Business impact : identity poor-performing products to improve quality or remove from catalog

-------------------------------------------------------------------
-------------------------------------------------------------------



--What time of the day has the highest number of purchase...?

select * from sales 
select
    case
        when datepart(hour,time_of_purchase) between 0 and 5 then 'morning'
         when datepart(hour,time_of_purchase) between 6 and 12 then 'afternoon'
          when datepart(hour,time_of_purchase) between 13 and 18 then 'evening'
           when datepart(hour,time_of_purchase) between 19 and 24 then 'night'
           end as time_of_day,
           count(*) as total_orders
from sales 
group by 
case
        when datepart(hour,time_of_purchase) between 0 and 5 then 'morning'
         when datepart(hour,time_of_purchase) between 6 and 12 then 'afternoon'
          when datepart(hour,time_of_purchase) between 13 and 18 then 'evening'
           when datepart(hour,time_of_purchase) between 19 and 24 then 'night'
           end
           order by total_orders desc



--Business problem solved : Find peak sales time 
--Business impact : Optimize Staffing, promotions, and server loads


-------------------------------------------------------------------
-------------------------------------------------------------------




--Who are the top 5 customers ?

select top 5 customer_name, sum(quantity*price) as total_spend
from sales 
where status = 'delivered'
group by customer_name
order by total_spend desc 

--Business problem solved : Identify VIP customers.
--Business impact : Personalized offers, loyalty rewards, and retention.



-------------------------------------------------------------------
-------------------------------------------------------------------



--Which product categories generate the highest revenue..?

select product_category, sum(quantity*price) as total_revenue
from sales
where status = 'delivered'
group by product_category
order by total_revenue desc 


-- Business Problem Solved: Identify top-performing product categories.

-- Business Impact: Refine product strategy, supply chain, and promotions.
-- allowing the business to invest more in high-margin or high-demand categories.


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------


--What is return & cancellation rate per product category?

select * from sales

--Cancelled 

select product_category, 
       format(count(case when status = 'cancelled' then 1 end)*100.0/COUNT(*),'N2')+ ' %' as cancelled_product
       from sales 
       group by product_category
       order by cancelled_product desc

--Returned

select product_category, 
       format(count(case when status = 'returned' then 1 end)*100.0/COUNT(*),'N2')+ ' %' as returned_product
       from sales 
       group by product_category
       order by returned_product desc

--Business Problem Solved: Monitor dissatisfaction trends per category.

--Business Impact: Reduce returns, improve product descriptions/expectations.
--Helps identify and fix product or logistics issues.

-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------


--How does age group affect purchasing behavior ?

select 
    case
        when customer_age between 18 and 25 then '18 - 25'
        when customer_age between 26 and 35 then '26 - 35'
        when customer_age between 36 and 50 then '36 - 50'
    else '51+'
    end as customer_age,
    format(sum(price * quantity),'n2') as total_purchase
    from sales
    group by case
        when customer_age between 18 and 25 then '18 - 25'
        when customer_age between 26 and 35 then '26 - 35'
        when customer_age between 36 and 50 then '36 - 50'
    else '51+'
    end
order by total_purchase desc 

--Business Problem Solved: Understand customer demographics.
--Business Impact: Targeted marketing and product recommendations by age group.


------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


-- What is monthly sales trend ?

select 
    format(purchase_date,'yyyy-MM') as Month_year,
    format(sum(price*quantity),'C0','en-IN') as total_sales,
    sum(quantity) as total_quantity
    from sales 
group by format(purchase_date,'yyyy-MM')
order by Month_year asc


-- Business Problem: Sales fluctuations go unnoticed.
-- Business Impact: Plan inventory and marketing according to seasonal trends.


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


--Are certine genders buying more specific product category ?
select *
    from(select gender,product_category
    from sales) as source_table
pivot(
count(gender)
for gender in ([M],[F])
)as genders
order by product_category desc

-- Business Problem Solved: Gender-based product preferences.
-- Business Impact: Personalized ads, gender-focused campaigns.

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
