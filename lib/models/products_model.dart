class Product {
  String name;
  double price;
  List<String?> categories;
  String brand;
  double rating;
  int stock;

  Product({
    required this.brand,
    required this.categories,
    required this.price,
    required this.rating,
    required this.stock,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        brand: json["brand"],
        categories: List<String>.from(json["categories"] ?? []),
        price: json["price"].toDouble(),
        rating: json["rating"],
        stock: json["stock"].toDouble(),
        name: json["name"]);
  }
}
