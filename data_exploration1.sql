select * from supply_chain_data;

# data exploration

#Type of product mostly sold
select `product type`,sum(`Number of products sold`)
from supply_chain_data group by `Product type`;

with cc as(
select `product type`,sum(`Number of products sold`), rank()
over(order by sum(`Number of products sold`)) rn
from supply_chain_data group by `Product type`


)
select * from cc where rn=(select max(rn) from cc);

# expenses and defects
select `product type`,sum(`Costs`),avg(`defect rates`)
from supply_chain_data group by `Product type`;

# which transport has most defect rates

select `Transportation modes`,Routes,avg(`Defect rates`)
from supply_chain_data group by `Transportation modes`,Routes
order by `Transportation modes`,Routes;


# failure percent of products


 with c1 as
 (select `Product type`,count(*) fail from supply_chain_data  where `inspection results`='fail'
 group by `Product type`),
 c2 as
(select `Product type`,count(*) tot from supply_chain_data group by `Product type`)
select c1.`product type`,c1.fail *100/c2.tot from c1,c2 where c1.`product type`=c2.`product type`;

# type of product which generate most of profit

select `product type`,sum(`Revenue generated`-price)
from supply_chain_data group by `Product type`;

with cc as(
select `product type`,sum(`Revenue generated`-Costs), rank()
over(order by sum(`Revenue generated`-costs)) rn
from supply_chain_data group by `Product type`


)
select * from cc where rn=(select max(rn) from cc);

# suppliers and locations
select `supplier name`,sum(`Number of products sold`+availability) quantity
 from supply_chain_data
group by `Supplier name` order by `Supplier name`;

select Location,sum(`Number of products sold`+availability) quantity
 from supply_chain_data
group by Location order by quantity;

# customer demographics
  
select `product type`,sum(`Number of products sold`),max(`Customer demographics`) sd from supply_chain_data
group by `product type`;


# Shipping 
select `product type`,sum(`Shipping times`),max(`Shipping carriers`),
sum(`Shipping costs`) from supply_chain_data
group by `Product type`;

# most famous product
select * from supply_chain_data
where `Number of products sold`=(select max(`Number of products sold`) from supply_chain_data);

# least famous product
select * from supply_chain_data
where `Number of products sold`=(select min(`Number of products sold`) from supply_chain_data);


