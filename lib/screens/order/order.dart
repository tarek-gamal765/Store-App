import 'package:ecommerce/provider/orders_provider.dart';
import 'package:ecommerce/screens/order/order_empty.dart';
import 'package:ecommerce/screens/order/order_full.dart';
import 'package:ecommerce/services/payment.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    StripePaymentServices.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return FutureBuilder(
      future: ordersProvider.getOrders(),
      builder: (context, snapshot) {
        return ordersProvider.getOrdersItems.isEmpty
            ? const OrderEmpty()
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).backgroundColor,
                  elevation: 0.0,
                  title: Text(
                    'Order (${ordersProvider.getOrdersItems.length})',
                    style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        defaultDialog(
                          context: context,
                          title: 'Clear Order!',
                          subTitle: 'Your order will be cleared!',
                          ok: () {},
                        );
                      },
                      icon: Icon(
                        FeatherIcons.trash,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    )
                  ],
                ),
                body: Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: ordersProvider.getOrdersItems[index],
                        child: const OrderFull(),
                      );
                    },
                    itemCount: ordersProvider.getOrdersItems.length,
                  ),
                ),
              );
      },
    );
  }
}
