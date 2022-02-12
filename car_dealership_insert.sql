-- This data page was created by Justin Rittenhouse
insert into "customer" ("first_name", "last_name", "email", "phone_number")
values 
('Jesse', 'Hitt', 'jesse.hitt@gmail.com', '1234567890'),
('Justin', 'Rittenhouse', 'justin.rittenhouse@gmail.com', '2345678901'),
('Hamilton', 'White', 'hamilton.white@gmail.com', '3456789012'),
('Shakti', 'Shah', 'shakti.shah@gmail.com', '4567890123'),
('Jared', 'Nance', 'jared.nance@gmail.com', '5678901234'),
('Muhammad', 'Rana', 'muhammad.rana@gmail.com', '6789012345'),
('Eric', 'Sylvestre', 'eric.sylvestre@gmail.com', '7890123456'),
('Christopher', 'Rodriguez', 'christopher.rodriguez@gmail.com', '8901234567'),
('Michael', 'Amerio', 'michael.amerio@gmail.com', '9012345678');

insert into "mechanics" ("first_name", "last_name")
values 
('Derek', 'Lang'),
('Lucas', 'Hawkins');

insert into "salesperson" ("first_name", "last_name")
values
('Ripal', 'Patel'),
('Ryan', 'Butz');

insert into "car_in_for_service" (car_service_id, make, model, color, "make_year", customer_id)
values 
(1, 'Toyoter', 'Preeyus', 'silver', 2010, 2),
(2, 'Honduh', 'Achord', 'red', 2022, 6),
(3, 'Fart', 'Explora', 'blue', 2015, 1),
(4, 'Chevvee', 'Espresso', 'gray', 1997, 1);

insert into "cars_for_sale" (car_for_sale_id, make, model, color, "make_year", salesperson_id)
values 
(1, 'Toyoter', 'Preeyus', 'silver', 2010, 1),
(5, 'BAM', 'Series TV', 'yes', 2020, 1),
(6, 'Testa', 'Model *', 'clear', 2021, 2),
(7, 'Fart', 'Mustache', 'pink', 2015, 2);

-- Justin Rittenhouse and Hamilton White made this function together.
create function tax(raw_amount decimal) returns decimal(10, 2)
as 
$$
begin
	return raw_amount * 1.053;
end
$$ 
language plpgsql;

insert into "service_history" (mechanic_id, car_id, amount, part_needed)
values 
(1, 1, tax(650), 'filters'),
(1, 2, tax(80), 'oil'),
(2, 3, tax(900), null),
(2, 4, tax(5), null);

--create function barter(salesperson_id int, raw_amount decimal) returns decimal(10, 2)
--as 
--$$ 
--begin 
--	if (salesperson_id = 2)
--		return raw_amount + 1000;
--		else
--		return raw_amount;
--end
--$$ 
--language plpgsql;
-- This didn't work out how I wanted it to.

create function barter(raw_amount decimal) returns decimal(10, 2)
as 
$$ 
begin 
	return raw_amount + 1000;
end
$$
language plpgsql;

insert into "invoice" (customer_id, salesperson_id, car_for_sale_id, amount)
values 
(2, 1, 1, tax(10000)),
(7, 2, 6, tax(barter(40000)));