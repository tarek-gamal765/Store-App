
import 'package:flutter/material.dart';

class CartModel with ChangeNotifier{
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;

  CartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
