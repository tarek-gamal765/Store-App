import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/cart/cart_empty.dart';
import 'package:ecommerce/screens/cart/cart_full.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/services/payment.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    StripePaymentServices.init();
    super.initState();
  }

  Future<void> payment({int? amount}) async {
    final _customer = await StripePaymentServices.createCustomer();
    final _paymentIntent = await StripePaymentServices.createPaymentIntents(
      amount: amount.toString(),
    );
    await StripePaymentServices.createCreditCard(
      _customer['id'],
      _paymentIntent['client_secret'],
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: cartProvider.getCartItems.isNotEmpty
          ? AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0.0,
              title: Text(
                'Cart (${cartProvider.getCartItems.length})',
                style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    defaultDialog(
                      context: context,
                      title: 'Clear cart!',
                      subTitle: 'Your cart will be cleared!',
                      ok: () {
                        cartProvider.clearCart();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  icon: Icon(
                    FeatherIcons.trash,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                )
              ],
            )
          : null,
      body: cartProvider.getCartItems.isEmpty
          ? const CartEmpty()
          : Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.17,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.getCartItems.values.toList()[index],
                    child: CartFull(
                      productId: cartProvider.getCartItems.keys.toList()[index],
                    ),
                  );
                },
                itemCount: cartProvider.getCartItems.length,
              ),
            ),
      bottomSheet: cartProvider.getCartItems.isNotEmpty
          ? buildBottomSheet(
              context: context,
              subTotal: cartProvider.totalAmount,
            )
          : null,
    );
  }


  Widget buildBottomSheet({
    required BuildContext context,
    required double subTotal,
  }) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: defaultButton(
              onPressed: () {
                double amountInCents = subTotal * 1000;
                int integerAmount = (amountInCents / 10).ceil();
                payment(amount: integerAmount);
              },
              borderRadius: 20,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.4,
              color: Colors.redAccent,
              text: 'Checkout',
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Total:',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            cartProvider.totalAmount.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
