import 'dart:math';

import 'package:food_dash/presentation/view/screen/food.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';
import 'package:food_dash/presentation/view/screen/orders_list/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

List<CartItem> cart = List<CartItem>();

class CartItem {
  int id;
  int quantity;
  Food food;
  String restaurantName;

  CartItem(int id, int quantity, Food food, String restaurantName) {
    this.id = id;
    this.quantity = quantity;
    this.food = food;
    this.restaurantName = restaurantName;
  }
}

class CartScreen extends StatelessWidget {
  CartScreen();

  static const String _title = 'Cart Screen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CartDetail extends StatelessWidget {
  final int UserId;
  const CartDetail(this.UserId);

  @override
  Widget build(BuildContext context) {
    double total = 0;
    String restaurantName =
        (cart.length > 0) ? cart[0].restaurantName : "Cougareat";

    for (int i = 0; i < cart.length; i++) {
      total += cart[i].food.price * cart[i].quantity;
    }

    return DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText1,
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: cartListView(cart, context),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: EmptyOrTotal(total)
                    // Text('Total: \$' + total.toStringAsFixed(2),
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 25,
                    //     ))
                    ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MaterialButton(
                      height: 50.0,
                      onPressed: () {
                        print(restaurantName);
                        _onPressed(restaurantName);
                        (context as Element).reassemble();
                      },
                      child: new Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('SUBMIT CART',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Colors.white,
                              ))),
                      color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ));
        }));
    //cartListView(cart, context);
  }

  void _onPressed(String restaurantName) {
    print(restaurantName);
    var rng = new Random();
    String id = Uuid().toString() + rng.nextInt(1000).toString();

    Order order = Order(
        id: id,
        status: "PENDING",
        restaurantName:
            restaurantName); // TO-DO: fix this so that the actual restaurant name goes into the function
    _sendOrder(order);
    cart.clear();
    // cartListView(cart, context);
  }

  ListView cartListView(data, mainContext) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return format(data[index], mainContext);
        });
  }

  ListTile format(CartItem cartitem, context) => ListTile(
        title: Text(cartitem.food.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            )),
        subtitle: Text(
            '\$' + (cartitem.food.price * cartitem.quantity).toStringAsFixed(2),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
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
                Icons.add,
                size: 25.0,
                color: Colors.black,
              ),
              onPressed: () {
                cartitem.quantity += 1;
                (context as Element).reassemble();
              },
            ),
            SizedBox(
              width: 45,
              height: 30,
              child: TextField(
                  controller:
                      TextEditingController(text: cartitem.quantity.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0, height: 2.0, color: Colors.black),
                  keyboardType: TextInputType.number,
                  onSubmitted: (text) {
                    if (int.parse(text) < 99) {
                      cartitem.quantity = int.parse(text);
                      (context as Element).reassemble();
                    }
                  }),
            ),
            IconButton(
              icon: Icon(
                Icons.remove,
                size: 25.0,
                color: Colors.black,
              ),
              onPressed: () {
                cartitem.quantity -= 1;
                if (cartitem.quantity == 0) {
                  cart.remove(cartitem);
                }
                (context as Element).reassemble();
              },
            ),
          ],
        ),
        // onTap: () {
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RestaurantDetail(id)));
        // },
      );

  Future<Order> _sendOrder(Order order) async {
    print("we send the order here");

    final jobsListAPIUrl =
        Uri.parse('http://amiable-archive-326601.wm.r.appspot.com/order');
    final response = await http.post(
      jobsListAPIUrl,
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer testToken'
      },
      body: jsonEncode(<String, String>{
        "id": order.id,
        "restaurantName": order.restaurantName,
        "status": order.status,
        "userId": "user"
      }),
    );

    print("Response= " + response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Order.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create order.');
    }
  }
}

class EmptyOrTotal extends StatelessWidget {
  final double total;

  EmptyOrTotal(this.total);

  Widget build(BuildContext context) {
    return Text((() {
      if (total == 0) {
        return "CART IS EMPTY";
      }

      return 'Total: \$' + total.toStringAsFixed(2);
    })(),
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 25,
        ));
  }
}
