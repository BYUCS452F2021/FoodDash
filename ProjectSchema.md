# ProjectSchema

## Tables
* Restaurant (RestaurantID, Name, Address, PhoneNumber, Rating)
* Food (FoodID, FoodName, Price) 
   * Foreign Key RestaurantID references Restaurant 
* User (UserID, Name, Address, Email, PhoneNumber)
* Order (OrderID, Status)
   * Foreign Key UserID references User
* CartItem (CartItemID, Quantity, Notes)
   * Foreign Key OrderID references Order
   * Foreign Key FoodID references Food


## Explanations
* Restaurant table represents a physical restaurants that the app will allow Users to order from
   * RestaurantID: the primary key
   * Name: the string name of the restaurant
   * Address: the string address of the restaurant
   * PhoneNumber: the string restaurant’s phone number
   * Rating: the int rating given to the restaurant by users
* Food table represents the food item in a Restaurant that User can order
   * FoodID: Primary key 
   * FoodName: the string name of the food
   * Price: price of the food
* User represents the user who makes the Order from the Restaurant
   * UserID: primary key; it is an arbitrary id that represents the identity of a user
   * Name: the user’s name
   * Address: the user’s shipping address
   * Email: the user’s contact email
   * PhoneNumber: the user’s phone number
* Order table represents individual orders Users can make from one individual Restaurant
   * OrderID: Primary key
   * Status(Enum): the indicator of if the order has been completed or is in process
* CartItem table represents a single cart item that a user can add to their order. The item is an object in the Food table. A CartTable item also references an OrderID, which once placed, would put the cart item into a placed order.
   * CartItemID: the primary key
   * Quantity: an Integer representing how many items a customer wants ordered
   * Notes: a String that contains any special instructions a customer has for their order.
