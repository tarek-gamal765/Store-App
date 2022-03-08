import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;
  final Timestamp orderDate;

  OrdersModel({
    required this.userId,
    required this.productId,
    required this.orderId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.orderDate,
  });
}
