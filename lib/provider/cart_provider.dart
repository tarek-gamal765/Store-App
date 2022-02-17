import 'package:ecommerce/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> cartItems = {};

  Map<String, CartModel> get getCartItems {
    return cartItems;
  }

  double get totalAmount {
    double total = 0.0;
    cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
   // notifyListeners();
    return total;
  }

  void addProductToCart({
    required String productId,
    required String title,
    required double price,
    required String imageUrl,
    int? quantity,
  }) {
    if (cartItems.containsKey(productId)) {
      cartItems.update(
        productId,
        (existingItem) => CartModel(
          id: existingItem.id,
          title: existingItem.title,
          imageUrl: existingItem.imageUrl,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      cartItems.putIfAbsent(
        productId,
        () => CartModel(
          id: productId,
          title: title,
          imageUrl: imageUrl,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void reduceQuantityByOne({
    required String productId,
    required String title,
    required double price,
    required String imageUrl,
  }) {
    if (cartItems.containsKey(productId)) {
      cartItems.update(
        productId,
        (existingItem) => CartModel(
          id: existingItem.id,
          title: existingItem.title,
          imageUrl: existingItem.imageUrl,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem({required String productId}) {
    cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
