-- Some how this doesn't work on Spring so I had to manaully run this script on postgres server. 
-- Jordan Lin 10.14.2021


-- delete all existing data
do
$$
declare
  l_stmt text;
begin
  select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename), ',')
    into l_stmt
  from pg_tables
  where schemaname in ('public');

  execute l_stmt;
end;
$$;


-- reset all sequence number on each table
ALTER SEQUENCE restaurant_restaurant_id_seq RESTART WITH 1;
ALTER SEQUENCE food_food_id_seq RESTART WITH 1;
ALTER SEQUENCE "Order_order_id_seq" RESTART WITH 1;
ALTER SEQUENCE "User_user_id_seq" RESTART WITH 1;
ALTER SEQUENCE cartitem_cartitem_id_seq RESTART WITH 1;


-- start inserting dummy data
INSERT INTO 
    restaurant("name","address",phone_number,rating)
VALUES
    ('Cougareat','BYU',8011234567,3.5),
    ('Panda Express','Cougar Blvd', 801234576, 4.2),
    ('Rancherito', 'Cougar Blvd 200', 8081392834, 5.0),
    ('Papa Johns', 'State Street', 3855321234, 2.8 );


INSERT INTO
    Food(restaurant_id, "name", price)
VALUES
    (1,'Subway Subs',7.5),
    (1,'Choices Bowls', 8.5),
    (1,'Chick Sandwich', 6.3),
    (2,'Orange Chicken', 10.0),
    (2,'Beijing Beef', 10.0),
    (2,'Walnut Shrimp', 15),
    (3,'Taco', 3.5),
    (3,'Burrito',8),
    (3,'Qeusadia',6),
    (4,'Pepperoni',10),
    (4,'Italian Sausage',6);


INSERT INTO
    "User"("name","address",phone_number)
VALUES
    ('Sam','wyview',3621273847),
    ('Jordan', 'Windsor',8083835460),
    ('Justin','University',385671234),
    ('Alyssa','BYU',1023456948),
    ('Luqi','South Campus',8012933485);


INSERT INTO
    "Order"(user_id,status)
VALUES
    (1,1),
    (2,1),
    (2,3);

INSERT INTO
    CartItem(order_id, food_id, quantity)
VALUES
    (1,2,1),
    (1,1,2),
    (2,3,1),
    (2,4,2);

