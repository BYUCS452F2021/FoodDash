import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';

List<Order> order = List<Order>();
int order_inx = 0;
enum Status {
  none,
  Delivering,
  Arrived,
  Completed,
}

class Order {
  int id;
  int status;
  DateTime date;
  String restaurant;

  Order(int id, int status, DateTime date, String restaurant) {
    this.id = id;
    this.status = status;
    this.date = date;
    this.restaurant = restaurant;
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
                          child: orderListView(order, context)),
                    ],
                  )));
        }));
  }

  ListView orderListView(data, mainContext) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return format(data[index], mainContext);
        });
  }

  ListTile format(Order order, context) => ListTile(
        title: Text(order.restaurant.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 23,
            )),
        subtitle: Text(
          'Ordered on ' +
              order.date.month.toString() +
              '/' +
              order.date.day.toString() +
              '/' +
              order.date.year.toString() +
              '\nStatus: ' +
              Status.values[order.status].toString().substring(7),
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
                    _onPressed(order.id);
                    (context as Element).reassemble();
                  },
                  child: new Text('Update Status',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
      );

  void _onPressed(int id) {
    for (int i = 0; i < order.length; i++) {
      if (order[i].id == id) {
        order[i].status = 3;
      }
    }
  }
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
