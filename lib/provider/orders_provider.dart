import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/orders_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersModel> ordersList = [];

  List<OrdersModel> get getOrdersItems {
    return [...ordersList];
  }

  Future<void> getOrders() async {
    final String uId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: uId)
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        ordersList = [];
        for (var element in ordersSnapshot.docs) {
          ordersList.insert(
            0,
            OrdersModel(
              userId: element.get('userId'),
              productId: element.get('productId'),
              orderId: element.get('orderId'),
              title: element.get('title'),
              price: element.get('price'),
              quantity: element.get('quantity'),
              imageUrl: element.get('imageUrl'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      });
    } catch (error) {}
    notifyListeners();
  }

  Future<void> removeOrder({required String orderId}) async {}

  Future<void> clearOrders({required String orderId}) async {
    FirebaseFirestore.instance
        .collection('orders')
        .firestore
        .clearPersistence();
  }
}
