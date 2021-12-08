import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';
import 'package:food_dash/presentation/view/screen/food.dart';
import 'package:food_dash/presentation/view/screen/cart/cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Restaurant {
  final String id;
  final String name;
  final String address;
  final double distance;
  final String phone;
  final double rating;
  final List<Food> menu;

  Restaurant(
      {this.id,
      this.name,
      this.address,
      this.distance,
      this.phone,
      this.rating,
      this.menu});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    double dis = 0.4;
    return Restaurant(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      distance: dis,
      phone: json['phone_number'],
      rating: json['rating'],
      menu: json['menu'],
    );
  }
}

class RestaurantsListScreen extends StatelessWidget {
  RestaurantsListScreen();
  // const RestaurantsListScreen({Key? key}) : super(key: key);

  static const String _title = 'Restaurants List Screen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RestaurantsList extends StatelessWidget {
  const RestaurantsList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: _fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> data = snapshot.data;
          return restaurantListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView restaurantListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return format(data[index].id, data[index].name, data[index].distance,
              data[index].rating, data[index].phone, context);
        });
  }

  ListTile format(String id, String title, double distance, double rating,
          String phone, context) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            )),
        subtitle: Text(
            distance.toString() + ' mi away  |  ' + rating.toString() + '★',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        leading: Icon(
          Icons.food_bank_outlined,
          size: 40.0,
          color: Colors.blue[500],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.call,
            //     size: 40.0,
            //     color: Colors.green[900],
            //   ),
            //   onPressed: () {
            //     // launch(('tel://${phone}'));
            //   },
            // ),
          ],
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RestaurantDetail(id)));
        },
      );

  Future<List<Restaurant>> _fetchRestaurants() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer testToken'
    };

    final jobsListAPIUrl =
        Uri.parse('http://amiable-archive-326601.wm.r.appspot.com/restaurant');
    final response = await http.get(jobsListAPIUrl, headers: requestHeaders);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((restaurant) => new Restaurant.fromJson(restaurant))
          .toList();
    } else {
      throw Exception('Failed to load restaurants from API ' +
          response.statusCode.toString());
    }
  }

  // List<Restaurant> getRestaurants(){
  //   List<Restaurant> restaurantList = new List<Restaurant>();
  //   Restaurant dummy1 = Restaurant(1,"KFC", "800 E 900 F", "2.3", "801-234-5565", "4.5", "kfc@gmail.com");
  //   Restaurant dummy2 = Restaurant(2,"Pho Plus", "800 E 900 F", "1.5", "801-234-5565", "4.0", "kfc@gmail.com");
  //   Restaurant dummy3 = Restaurant(3,"J Dawgs", "800 E 900 F", "0.5", "801-234-5565", "4.8", "kfc@gmail.com");
  //   restaurantList.add(dummy1);
  //   restaurantList.add(dummy2);
  //   restaurantList.add(dummy3);
  //   return restaurantList;
  // }

}

class RestaurantDetail extends StatelessWidget {
  final String restaurantId;
  const RestaurantDetail(this.restaurantId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FoodDash'), // TO DO: ADD RESTAURANT NAME
        ),
        body: FutureBuilder<Restaurant>(
            future: _fetchRestaurant(restaurantId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Restaurant data = snapshot.data;
                return foodListView(data.menu);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
    // return foodListView(getFoods());
    // FutureBuilder<Restaurant>(
    //     future: _fetchRestaurant(restaurantId),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         Restaurant data = snapshot.data;
    //         // return Container(
    //         //     alignment: Alignment.topLeft,
    //         //     child: Scaffold(
    //         //       appBar: AppBar(
    //         //         title: Text(data.name), // TO DO: ADD RESTAURANT NAME
    //         //       ),
    //         //       body:
    //         return foodListView(getFoods());
    //         // ));
    //       } else if (snapshot.hasError) {
    //         return Text("${snapshot.error}");
    //       }
    //       return CircularProgressIndicator();
    //     });
  }

  ListView foodListView(data) {
    if (data == null) {
      return ListView();
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return format(data[index], context);
        });
  }

  ListTile format(Food food, context) => ListTile(
        title: Text(food.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            )),
        subtitle: Text('\$ ' + food.price.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        leading: Icon(
          Icons.fastfood,
          size: 40,
          color: Colors.blue[500],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                size: 30.0,
                color: Colors.brown[900],
              ),
              onPressed: () {
                cart.add(CartItem(1, 1, food));
              },
            ),
          ],
        ),
        // onTap: () {
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RestaurantDetail(id)));
        // },
      );

  // Future<List<Restaurant>> _fetchRestaurants() async {
  //
  //   final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
  //   final response = await http.get(jobsListAPIUrl);
  //
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((job) => new Job.fromJson(job)).toList();
  //   } else {
  //     throw Exception('Failed to load jobs from API');
  //   }
  // }

  List<Food> getFoods() {
    List<Food> foodList = new List<Food>();
    Food dummy1;
    Food dummy2;
    Food dummy3;
    if (restaurantId == 1) {
      dummy1 = Food(1, "Fired Chicken", 10.99);
      dummy2 = Food(1, "Cole Slaw", 2.99);
      dummy3 = Food(3, "Mashed Potatoes", 2.99);
    } else if (restaurantId == 2) {
      dummy1 = Food(1, "Beef Noddle", 9.99);
      dummy2 = Food(1, "Seafood Noddle", 11.99);
      dummy3 = Food(3, "Chicken Noddle", 9.99);
    } else if (restaurantId == 3) {
      dummy1 = Food(1, "Beef HotDog", 10.99);
      dummy2 = Food(1, "Pork HotDog", 10.99);
      dummy3 = Food(3, "Chicken Potatoes", 10.99);
    } else if (restaurantId == 4) {
      dummy1 = Food(1, "California Pizza", 10.99);
      dummy2 = Food(1, "Chicago Pizza", 10.99);
      dummy3 = Food(3, "New York-Style Pizza", 10.99);
    }

    foodList.add(dummy1);
    foodList.add(dummy2);
    foodList.add(dummy3);
    return foodList;
  }

  ListTile formatInfoTile(String id, String title, double distance,
          double rating, String phone, context) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            )),
        subtitle: Text(
            distance.toString() + ' mi away  |  ' + rating.toString() + '★',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        leading: Icon(
          Icons.food_bank_outlined,
          size: 40.0,
          color: Colors.blue[500],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.call,
            //     size: 40.0,
            //     color: Colors.green[900],
            //   ),
            //   onPressed: () {
            //     // launch(('tel://${phone}'));
            //   },
            // ),
          ],
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RestaurantDetail(id)));
        },
      );

  Future<Restaurant> _fetchRestaurant(String restaurantID) async {
    // TO-DO: Implement a fetch restaurant function that grabs the restaurant by its ID
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer testToken'
    };

    final jobsListAPIUrl = Uri.parse(
        'http://amiable-archive-326601.wm.r.appspot.com/restaurant/' +
            restaurantId);
    final response = await http.get(jobsListAPIUrl, headers: requestHeaders);
    List<Restaurant> rList;

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((restaurant) => new Restaurant.fromJson(restaurant))
          .first;
      // return Restaurant(restaurantID, "Taco Bell", "1 Hacker Way", 3.4, "8583361959", 4.5);
    } else {
      throw Exception('Failed to load restaurants from API ' +
          response.statusCode.toString());
    }
  }
}
