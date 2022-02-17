import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

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
                      cancel: () {
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
          ? buildEmptyCart(context)
          : Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.17,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProductDetailsScreen.routeName,
                        arguments:
                            cartProvider.getCartItems.keys.toList()[index],
                      );
                    },
                    child: buildCartItem(
                      context: context,
                      cartModel:
                          cartProvider.getCartItems.values.toList()[index],
                    ),
                  );
                },
                itemCount: cartProvider.getCartItems.length,
              ),
            ),
      bottomSheet: cartProvider.getCartItems.isNotEmpty
          ? buildBottomSheet(context: context)
          : null,
    );
  }

  

  Widget buildCartItem({
    required BuildContext context,
    required CartModel cartModel,
  }) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double subTotal = 0.0;
    subTotal += cartModel.price * cartModel.quantity;
    return Container(
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
            cartModel.imageUrl,
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
                          cartModel.title,
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
                            title: 'Remove Item!',
                            subTitle: 'Product will be removed from the cart!',
                            ok: () {
                              cartProvider.removeItem(
                                productId: cartModel.id,
                              );
                              Navigator.of(context).pop();
                            },
                            cancel: () {
                              Navigator.of(context).pop();
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
                      '${cartModel.price}',
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
                    const Text('Sub Total:'),
                    const SizedBox(width: 5),
                    Text(
                      subTotal.toStringAsFixed(2),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                Row(
                  children: [
                    Text(
                      'Ships Free:',
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).getTheme
                            ? Colors.brown.shade900
                            : Colors.deepPurple,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(FeatherIcons.minus),
                      iconSize: 22,
                      color: Colors.red,
                      splashRadius: 0.5,
                      onPressed: cartModel.quantity < 2
                          ? () {}
                          : () {
                              cartProvider.reduceQuantityByOne(
                                productId: cartModel.id,
                                imageUrl: cartModel.imageUrl,
                                price: cartModel.price,
                                title: cartModel.title,
                              );
                            },
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorsConsts.gradiendLStart,
                              ColorsConsts.gradiendLEnd,
                            ],
                            stops: const [
                              0.0,
                              0.7,
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Text(
                          '${cartModel.quantity}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FeatherIcons.plus),
                      iconSize: 22,
                      color: Colors.green,
                      splashRadius: 0.5,
                      onPressed: () {
                        cartProvider.addProductToCart(
                          productId: cartModel.id,
                          imageUrl: cartModel.imageUrl,
                          price: cartModel.price,
                          title: cartModel.title,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyCart(BuildContext context) => Column(
        children: [
          const Image(
            image: AssetImage('assets/images/emptycart.png'),
          ),
          Text(
            'Your Cart Is Empty',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            'Looks like you didn\'t \n add anything to your cart yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Provider.of<ThemeProvider>(context).getTheme
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          defaultButton(
            onPressed: () {},
            borderRadius: 20,
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.redAccent,
            text: 'SHOP NOW',
            textStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
        ],
      );
  Widget buildBottomSheet({required BuildContext context}) {
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
              onPressed: () {},
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
