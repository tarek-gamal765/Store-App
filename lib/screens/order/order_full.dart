import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/orders_model.dart';
import 'package:ecommerce/provider/orders_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderFull extends StatefulWidget {
  const OrderFull({Key? key}) : super(key: key);

  @override
  State<OrderFull> createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  @override
  Widget build(BuildContext context) {

    final OrdersModel ordersModel = Provider.of<OrdersModel>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailsScreen.routeName,
        arguments: ordersModel.productId,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        margin: const EdgeInsets.only(top: 12, right: 8, left: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
        child: Row(
          children: [
            Image.network(
              ordersModel.imageUrl,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.18,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            ordersModel.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          iconSize: 22,
                          color: Colors.red,
                          onPressed: () {
                            defaultDialog(
                              context: context,
                              title: 'Remove order!',
                              subTitle: 'Order will be removed!',
                              ok: () async {
                                await FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc(ordersModel.orderId)
                                    .delete()
                                    .then(
                                      (value) => Navigator.pop(context),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Price:'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${ordersModel.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Quantity:'),
                      const SizedBox(width: 5),
                      Text(
                        '${ordersModel.quantity}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Provider.of<ThemeProvider>(context).getTheme
                              ? Colors.brown.shade900
                              : Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
