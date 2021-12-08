import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int order_inx = 0;
enum Status {
  none,
  Delivering,
  Arrived,
  Completed,
}

class Order {
  String id;
  String status;
  DateTime date;
  String restaurantName;

  Order({this.id, this.status, this.date, this.restaurantName});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        status: json['status'],
        date: DateTime.now(),
        restaurantName: json['restaurantName']);
  }
}

class OrdersListScreen extends StatelessWidget {
  OrdersListScreen();

  static const String _title = 'Orders List Screen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderDetail extends StatelessWidget {
  final int UserId;
  const OrderDetail(this.UserId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: _fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Order> data = snapshot.data;
          if (data == null || data.isEmpty) {
            data = <Order>[];
          }
          return orderListView(data, context);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Order>> _fetchOrders() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer testToken'
    };

    final jobsListAPIUrl =
        Uri.parse('http://amiable-archive-326601.wm.r.appspot.com/order');
    final response = await http.get(jobsListAPIUrl, headers: requestHeaders);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((restaurant) => new Order.fromJson(restaurant))
          .toList();
    } else {
      throw Exception('Failed to load restaurants from API ' +
          response.statusCode.toString());
    }
  }

  ListView orderListView(data, mainContext) {
    return ListView.builder(
        // physics: ClampingScrollPhysics(),
        // scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return format(data[index], mainContext);
        });
  }

  ListTile format(Order order, context) => ListTile(
        title: Text(
            order.restaurantName != null ? order.restaurantName : "Cougareat",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 23,
            )),
        subtitle: Text(
          'Ordered on ' +
              (order.date != null
                  ? (order.date.month.toString() +
                      "/" +
                      order.date.day.toString() +
                      "/" +
                      order.date.year.toString())
                  : "12/7/2021") +
              '\nStatus: ' +
              order.status,
        ),
        leading: Icon(
          Icons.fastfood,
          size: 40,
          color: Colors.blue[500],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 78,
              height: 50,
              child: MaterialButton(
                  height: 50.0,
                  // minWidth: 200.0,
                  onPressed: () {
                    _onPressed(order);
                    order.status = "COMPLETE";
                    (context as Element).reassemble();
                  },
                  child: new Text('Update Status',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
      );

  void _onPressed(Order order) {
    _updateStatus(order);
  }

  Future<Order> _updateStatus(Order order) async {
    print("we update the status here");

    final jobsListAPIUrl = Uri.parse(
        'http://amiable-archive-326601.wm.r.appspot.com/order/status');
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
        "status": "COMPLETE",
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
