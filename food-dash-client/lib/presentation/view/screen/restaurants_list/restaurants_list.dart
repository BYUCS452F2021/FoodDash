import 'dart:math';

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
  List<Food> menu;

  Restaurant(
      {this.id,
      this.name,
      this.address,
      this.distance,
      this.phone,
      this.rating,
      this.menu});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    Random random = new Random();

    return Restaurant(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        distance: (random.nextInt(3) + 0.1).toDouble(),
        phone: json['phone_number'],
        rating: json['rating'],
        menu: (FoodList.fromJson(json['menu']).menu));
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
}

class RestaurantDetail extends StatelessWidget {
  final String restaurantId;
  const RestaurantDetail(this.restaurantId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FoodDash'),
        ),
        body: //foodListView(getFoods()));
            FutureBuilder<Restaurant>(
                future: _fetchRestaurant(restaurantId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Restaurant data = snapshot.data;
                    print(data.name);
                    return foodListView(data.menu, data.name);
                    // return foodListView(getFoods());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }));
  }

  ListView foodListView(data, restaurantName) {
    if (data == null) {
      return ListView();
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          print(restaurantName);
          return format(data[index], context, restaurantName);
        });
  }

  ListTile format(Food food, context, restaurantName) => ListTile(
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
                print(restaurantName);
                cart.add(CartItem(1, 1, food, restaurantName));
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

  // Future<Restaurant> _fetchRestaurant(String restaurantID) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer testToken'
  //   };

  //   final jobsListAPIUrl = Uri.parse(
  //       'http://amiable-archive-326601.wm.r.appspot.com/restaurant/' +
  //           restaurantId);
  //   final response = await http.get(jobsListAPIUrl, headers: requestHeaders);

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonResponse = json.decode(response.body);
  //     return jsonResponse
  //         .map((restaurant) => new Restaurant.fromJson(restaurant)).entries.first;
  //   } else {
  //     throw Exception('Failed to load restaurants from API ' +
  //         response.statusCode.toString());
  //   }
  // }

  Future<Restaurant> _fetchRestaurant(String restaurantId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer testToken'
    };

    final jobsListAPIUrl =
        Uri.parse('http://amiable-archive-326601.wm.r.appspot.com/restaurant');
    final response = await http.get(jobsListAPIUrl, headers: requestHeaders);
    List<Restaurant> rList;

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      rList = jsonResponse
          .map((restaurant) => new Restaurant.fromJson(restaurant))
          .toList();
    } else {
      throw Exception('Failed to load restaurants from API ' +
          response.statusCode.toString());
    }

    for (int i = 0; i < rList.length; i++) {
      if (rList[i].menu != null) {
        List<Food> foods = <Food>[];

        for (int i = 0; i < rList[i].menu.length; i++) {
          Food food = new Food(
              name: rList[i].menu.elementAt(i).name,
              price: rList[i].menu.elementAt(i).price);
          foods.add(food);
        }

        rList[i].menu = foods;
      }

      if (rList[i].id == restaurantId) {
        print(rList[i].name + "\n" + rList[i].menu.toString());
        return rList[i];
      }
    }
    return null;
  }
}

// List<Food> getFoods() {
  //   List<Food> foodList = new List<Food>();
  //   Food dummy1;
  //   Food dummy2;
  //   Food dummy3;
  //   if (restaurantId == 1) {
  //     dummy1 = Food(1, "Fired Chicken", 10.99);
  //     dummy2 = Food(1, "Cole Slaw", 2.99);
  //     dummy3 = Food(3, "Mashed Potatoes", 2.99);
  //   } else if (restaurantId == 2) {
  //     dummy1 = Food(1, "Beef Noodle", 9.99);
  //     dummy2 = Food(1, "Seafood Noodle", 11.99);
  //     dummy3 = Food(3, "Chicken Noddle", 9.99);
  //   } else if (restaurantId == 3) {
  //     dummy1 = Food(1, "Beef Hotdog", 10.99);
  //     dummy2 = Food(1, "Pork Hotdog", 10.99);
  //     dummy3 = Food(3, "Chicken Potatoes", 10.99);
  //   } else if (restaurantId == 4) {
  //     dummy1 = Food(1, "California Pizza", 10.99);
  //     dummy2 = Food(1, "Chicago Pizza", 10.99);
  //     dummy3 = Food(3, "New York-Style Pizza", 10.99);
  //   }

  //   foodList.add(dummy1);
  //   foodList.add(dummy2);
  //   foodList.add(dummy3);
  //   return foodList;
  // }
