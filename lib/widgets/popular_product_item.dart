import 'package:badges/badges.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

Widget popularProductItem({
  required BuildContext context,
  required ProductModel productModel,
}) {
  final cartProvider = Provider.of<CartProvider>(context);
  final favouritesProvider = Provider.of<FavouritesProvider>(context);
  return Container(
    width: MediaQuery.of(context).size.height * 0.3,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).backgroundColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(
                productModel.imageUrl!,
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 0.34,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () {
                  favouritesProvider.addProductToFavourites(
                    productId: productModel.productId!,
                    title: productModel.title!,
                    price: productModel.price!,
                    imageUrl: productModel.imageUrl!,
                  );
                },
                icon: favouritesProvider.getfavouritesItems
                        .containsKey(productModel.productId)
                    ? const Icon(
                        Icons.star,
                      )
                    : const Icon(
                        FeatherIcons.star,
                      ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: Badge(
                toAnimate: true,
                animationType: BadgeAnimationType.fade,
                shape: BadgeShape.square,
                badgeColor: Colors.purple,
                borderRadius: BorderRadius.circular(8),
                badgeContent: Text(
                  '\$ ${productModel.price}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            productModel.title!,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  productModel.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: cartProvider.getCartItems
                        .containsKey(productModel.productId)
                    ? null
                    : () {
                        cartProvider.addProductToCart(
                          productId: productModel.productId!,
                          title: productModel.title!,
                          price: productModel.price!,
                          imageUrl: productModel.imageUrl!,
                          quantity: productModel.quantity,
                        );
                      },
                iconSize: 25,
                icon: cartProvider.getCartItems
                        .containsKey(productModel.productId)
                    ? const Icon(
                        FeatherIcons.check,
                      )
                    : const Icon(
                        Icons.add_shopping_cart_outlined,
                      ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
