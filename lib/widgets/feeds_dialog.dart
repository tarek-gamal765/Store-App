import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

Future feedsDialog({
  required BuildContext context,
  required ProductModel productModel,
}) {
  final cartProvider = Provider.of<CartProvider>(
    context,
    listen: false,
  );
  final favouritesProvider = Provider.of<FavouritesProvider>(
    context,
    listen: false,
  );
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.network(
                productModel.imageUrl,
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: dialogContent(
                        productModel: productModel,
                        context: context,
                        index: 0,
                        onPressed: () {
                          favouritesProvider.addProductToFavourites(
                            productId: productModel.id,
                            title: productModel.title,
                            price: productModel.price,
                            imageUrl: productModel.imageUrl,
                          );
                          Navigator.of(context).canPop()
                              ? Navigator.of(context).pop()
                              : null;
                        },
                      ),
                    ),
                    Flexible(
                      child: dialogContent(
                        productModel: productModel,
                        context: context,
                        index: 1,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(
                                ProductDetailsScreen.routeName,
                                arguments: productModel.id,
                              )
                              .then((value) => Navigator.of(context).pop());
                        },
                      ),
                    ),
                    Flexible(
                      child: dialogContent(
                        productModel: productModel,
                        context: context,
                        index: 2,
                        onPressed: () {
                          cartProvider.addProductToCart(
                            productId: productModel.id,
                            title: productModel.title,
                            price: productModel.price,
                            imageUrl: productModel.imageUrl,
                          );
                          Navigator.of(context).canPop()
                              ? Navigator.of(context).pop()
                              : null;
                        },
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.3),
                  shape: BoxShape.circle),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.grey,
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      );
    },
  );
}

Widget dialogContent({
  required BuildContext context,
  required int index,
  required VoidCallback onPressed,
  required ProductModel productModel,
}) {
  final cartProvider = Provider.of<CartProvider>(context);
  final favouritesProvider = Provider.of<FavouritesProvider>(context);
  List<IconData> _dialogIcons = [
    favouritesProvider.getfavouritesItems.containsKey(productModel.id)
        ? Icons.favorite
        : FeatherIcons.heart,
    FeatherIcons.eye,
    cartProvider.getCartItems.containsKey(productModel.id)
        ? Icons.shopping_cart
        : Icons.add_shopping_cart,
    FeatherIcons.trash,
  ];

  List<String> _texts = [
    favouritesProvider.getfavouritesItems.containsKey(productModel.id)
        ? 'In wishlist'
        : 'Add to wishlist',
    'View product',
    cartProvider.getCartItems.containsKey(productModel.id)
        ? 'In Cart '
        : 'Add to cart',
  ];
  List<Color> _colors = [
    favouritesProvider.getfavouritesItems.containsKey(productModel.id)
        ? Colors.red
        : Theme.of(context).textSelectionTheme.selectionColor!,
    Theme.of(context).textSelectionTheme.selectionColor!,
    Theme.of(context).textSelectionTheme.selectionColor!,
  ];
  final themeChange = Provider.of<ThemeProvider>(
    context,
    listen: false,
  );
  return FittedBox(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.grey,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        _dialogIcons[index],
                        color: _colors[index],
                        size: 25,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    _texts[index],
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: themeChange.getTheme
                          ? Theme.of(context).disabledColor
                          : ColorsConsts.subTitle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
