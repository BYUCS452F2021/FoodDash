drop table if exists cartitem;
drop table if exists "Order";
drop table if exists "User";
drop table if exists Food;
drop table if exists Restaurant;


create table Restaurant(
    restaurant_id SERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    phone_number varchar(255) NOT NULL,
    rating NUMERIC(3,2) default NULL
);

create table Food(
	food_id SERIAL PRIMARY KEY,
 	restaurant_id SERIAL NOT NULL,
  name varchar(100) NOT NULL,
  price NUMERIC(7,2) NOT NULL,
  	CONSTRAINT fk_restaurant
      FOREIGN KEY(restaurant_id) 
	  REFERENCES Restaurant(restaurant_id)
  	  ON DELETE CASCADE
);

create table "User"(
  	user_id SERIAL PRIMARY KEY,
 	  name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    phone_number varchar(255) NOT NULL,
    rating varchar(255) default NULL
);

create table "Order"(
  	order_id SERIAL PRIMARY KEY,
    user_id SERIAL NOT NULL,
  	"status" smallint NOT NULL,
    CONSTRAINT fk_O_UserID
      FOREIGN KEY(user_id) 
	  REFERENCES "User"(user_id)
  	  ON DELETE CASCADE
 );
 
 create table CartItem(
  	cartItem_id SERIAL PRIMARY KEY,
    order_id SERIAL NOT NULL,
    food_id SERIAL NOT NULL,
   	quantity integer NOT NULL,
    notes varchar(255) DEFAULT NULL,
   
    CONSTRAINT fk_CI_OrderID
      FOREIGN KEY(order_id) 
	  REFERENCES "Order"(order_id)
  	  ON DELETE CASCADE,
   
    CONSTRAINT fk_CI_FOODID
      FOREIGN KEY(food_id) 
	  REFERENCES Food(food_id)
  	  ON DELETE CASCADE
 );
 