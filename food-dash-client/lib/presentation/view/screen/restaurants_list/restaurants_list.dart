import 'package:food_dash/presentation/config/theming/sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return ListView(
      children: const <Widget>[
        Card(
          child: ListTile(
            // onTap: () {
            //   RestaurantDetail();
            // };
            title: Text('Restaurant Name'),
            subtitle: Text('2.3 miles away | 4.7*'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Restaurant Name'),
            subtitle: Text('2.3 miles away | 4.7*'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
      ],
    );
  }
}

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail();

  @override
  Widget build(BuildContext context) {}
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  // const MyStatefulWidget({Key? key}) : super(key: key);
  MyStatefulWidget();

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    RestaurantsList(),
    Text(
      'Index 1: Cart',
      style: optionStyle,
    ),
    Text(
      'Index 2: Orders',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FoodDash'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'Find Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_outlined),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
