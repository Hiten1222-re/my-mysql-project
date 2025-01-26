select * from us_regional_sales_data;

alter table us_regional_sales_data
rename column `ï»¿OrderNumber` to OrderNumber;

with cc as(
select *,row_number() over(partition by OrderNumber, `Sales Channel`, 
WarehouseCode, ProcuredDate, OrderDate, ShipDate, DeliveryDate, 
 _SalesTeamID, _CustomerID, _StoreID, _ProductID, `Order Quantity`,
 `Discount Applied`, `Unit Cost`, `Unit Price`) rown
from us_regional_sales_data

)
select * from cc
where rown >1;

select orderDate,str_to_date(orderDate , '%d/%m/%Y') from us_regional_sales_data;

update us_regional_sales_data set OrderDate=str_to_date(orderDate , '%d/%m/%Y');

update us_regional_sales_data set 
OrderNumber=Trim(OrderNumber),
`Sales Channel`=Trim(`Sales Channel`), 
WarehouseCode=Trim(WarehouseCode),
 ProcuredDate=Trim(ProcuredDate),
 OrderDate=Trim(OrderDate),
 ShipDate=Trim(ShipDate),
 DeliveryDate=Trim(DeliveryDate), 
 _SalesTeamID=Trim(_SalesTeamID),
 _CustomerID=Trim(_CustomerID), 
 _StoreID=Trim(_StoreID), 
 _ProductID=Trim(_ProductID), 
 `Order Quantity`=Trim(`Order Quantity`),
 `Discount Applied`=Trim(`Discount Applied`), 
 `Unit Cost`=Trim(`Unit Cost`), 
 `Unit Price`=Trim(`Unit Price`);

select ShipDate,str_to_date(ShipDate , '%d/%m/%Y') from us_regional_sales_data;

update us_regional_sales_data set ShipDate=str_to_date(ShipDate , '%d/%m/%Y');

select DeliveryDate,str_to_date(DeliveryDate , '%d/%m/%Y') from us_regional_sales_data;

update us_regional_sales_data set DeliveryDate=str_to_date(DeliveryDate , '%d/%m/%Y');

select ProcuredDate,str_to_date(ProcuredDate , '%d/%m/%Y') from us_regional_sales_data;

update us_regional_sales_data set ProcuredDate=str_to_date(ProcuredDate , '%d/%m/%Y');

alter table us_regional_sales_data
modify column DeliveryDate date;

alter table us_regional_sales_data
modify column ProcuredDate date;

alter table us_regional_sales_data
modify column ShipDate date;

alter table us_regional_sales_data
modify column OrderDate date;

alter table us_regional_sales_data
modify column `Unit Cost` double;

select `Unit Price`,convert(`Unit Price`,double)
 from us_regional_sales_data;

update us_regional_sales_data
set `Unit Cost`=replace(`Unit Cost`,',','');

update us_regional_sales_data
set `Unit Cost`=convert(`Unit Cost`,double);

update us_regional_sales_data
set `Unit Price`=replace(`Unit Price`,',','');

update us_regional_sales_data
set `Unit Price`=convert(`Unit Price`,double);

alter table us_regional_sales_data
modify column `Unit Price` double;

alter table us_regional_sales_data
drop column CurrencyCode;