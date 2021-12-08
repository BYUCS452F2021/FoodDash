import 'package:food_dash/presentation/view/screen/food.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';
import 'package:food_dash/presentation/view/screen/orders_list/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<CartItem> cart = List<CartItem>();

class CartItem {
  int id;
  int quantity;
  Food food;
  CartItem(int id, int quantity, Food food) {
    this.id = id;
    this.quantity = quantity;
    this.food = food;
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
    // return FutureBuilder<List<Restaurant>>(
    //   future: _fetchRestaurants(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<Restaurant> data = snapshot.data;
    //       return _jobsListView(data);
    //     } else if (snapshot.hasError) {
    //       return Text("${snapshot.error}");
    //     }
    //     return CircularProgressIndicator();
    //   },
    // );
    double total = 0;
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
                        _onPressed();
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

  void _onPressed() {
    order.add(new Order((order.length + 1), 1, new DateTime.now(),
        "Restaurant Name")); // TO-DO: fix this so that the actual restaurant name goes into the function
    cart.clear();
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
            // IconButton(
            //   icon: Icon(
            //     Icons.delete_forever,
            //     size: 30.0,
            //     color: Colors.black,
            //   ),
            //   onPressed: () {
            //     cart.remove(cartitem);
            //     (context as Element).reassemble();
            //   },
            // ),
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
