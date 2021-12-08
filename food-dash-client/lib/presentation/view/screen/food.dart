class Food {
  String name;
  double price;

  Food({this.name, this.price});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name'], price: json['price']);
  }
}

class FoodList {
  final List<Food> menu;

  FoodList({
    this.menu,
  });

  factory FoodList.fromJson(List<dynamic> json) {
    List<Food> menu = new List<Food>();
    menu = json.map((i) => Food.fromJson(i)).toList();

    return new FoodList(
      menu: menu,
    );
  }
}
