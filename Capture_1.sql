create table half_years_data as
select invoice_total, payment_total, invoice_date
from invoices;

-- Add column in the beginnig, to divide data into half next
ALTER TABLE half_years_data 
ADD datarange varchar(30) first; 

-- Add a column to define the halves of the year
ALTER TABLE half_years_data 
ADD half_index int not null;

-- Define the halves of the year
UPDATE half_years_data  
SET half_index = CASE 
WHEN (invoice_date <= '2019-06-30') THEN 1  
ELSE 2 END;

-- Remove invoice_date column; we don't need this anymore
alter table half_years_data drop column invoice_date;

-- Display the result
select case when half_index = 1 then "First half of 2019"
			else "Second half of 2019" end as "data range",
sum(invoice_total) as "total sales", 
sum(payment_total) as "total payments", 
sum(invoice_total) - sum(payment_total) as "as we expect"
from half_years_data
group by half_index;
