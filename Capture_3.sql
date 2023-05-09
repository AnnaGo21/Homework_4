select p.payment_method, sum(amount) total
from payments p
join payment_methods pm
on p.payment_method = pm.payment_method_id
group by p.payment_method
union 
select null, sum(payments.amount)
from payments

