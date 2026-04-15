--Finding duplicate and data cleaning:

select transaction_id,count(*) from sales 
group by transaction_id
having count(transaction_id) >1;


with chq as(
select *, 
		ROW_NUMBER() over(partition by transaction_id order by transaction_id) as row_num
		from sales
		)
--delete duplicate 
delete from chq 
where row_num = 2

--checking the duplicate data 
select * from chq
where transaction_id in ('TXN240646','TXN342128','TXN855235','TXN981773')

--rename column command 

exec sp_rename'sales.prce','price','COLUMN'


--check the data type 

select COLUMN_NAME, DATA_TYPE
from INFORMATION_SCHEMA.COLUMNS
where table_name= 'sales'


select * from sales 

DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = STRING_AGG(
    'SELECT ''' + COLUMN_NAME + ''' AS ColumnName, 
            COUNT(*) AS NullCount 
     FROM ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + '
     WHERE ' + QUOTENAME(COLUMN_NAME) + ' IS NULL',
    ' UNION ALL '
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales';

EXEC sp_executesql @SQL;

select * from sales where transaction_id is null
or 
customer_id is null
or 
customer_name is null
or
customer_age is null 
or 
gender is null 
or 
product_id is null
or 
product_name is null
or
product_category is null
or 
quantity is null 
or 
price is null 
or 
payment_mode is null 
or 
purchase_date is null
or 
time_of_purchase is null 
or 
status is null

delete  from sales
where transaction_id is null

select * from sales
where customer_name = 'Ehsaan Ram'

update sales 
set customer_id = 'CUST9494'
where transaction_id = 'TXN977900'


select * from sales
where customer_name = 'Damini Raju'


update sales 
set customer_id = 'CUST1401'
where transaction_id = 'TXN985663'


select * from sales
where customer_id = 'CUST1003'

update sales 
set customer_name = 'Mahika Saini',customer_age = '35', gender = 'male'
where transaction_id = 'TXN432798'

--data updating 

select distinct gender from sales 

update sales 
set gender = 'F'
where gender = 'female'

update sales 
set gender = 'M'
where gender = 'male'

select distinct payment_mode from sales 

update sales 
set payment_mode = 'Credit Card'
where payment_mode = 'CC'



