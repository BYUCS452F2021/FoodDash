ALTER TABLE restaurant
ADD COLUMN distance NUMERIC(4,1);


Update restaurant as r set
    distance = c.distance
from (values
    (1, 1),
    (2, 1.2),
    (3, 1.3),
    (4, 0.4)
) as c(restaurant_id, distance) 
where c.restaurant_id = r.restaurant_id;