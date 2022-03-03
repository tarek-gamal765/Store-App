class ProductModel {
  String? productId;
  String? userId;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  String? productCategoryName;
  String? brand;
  int? quantity;
  bool? isFavorite;
  bool? isPopular;
  String? createdAt;

  ProductModel({
    this.productId,
    this.userId,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.productCategoryName,
    this.brand,
    this.quantity,
    this.isFavorite,
    this.isPopular,
    this.createdAt,
  });
  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    productCategoryName = json['productCategoryName'];
    brand = json['brand'];
    createdAt = json['createdAt'];
    quantity = json['quantity'];
    isFavorite = json['isFavorite'];
    isPopular = json['isPopular'];
  }
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'productCategoryName': productCategoryName,
      'brand': brand,
      'createdAt': createdAt,
      'quantity': quantity,
      'isFavorite': isFavorite,
      'isPopular': isPopular,
    };
  }
}
