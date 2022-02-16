import 'package:badges/badges.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

Widget popularProductItem({
  required BuildContext context,
  required ProductModel productModel,
}) {
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
                productModel.imageUrl,
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 0.34,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
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
            productModel.title,
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
                  productModel.description,
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
                onPressed: () {},
                splashRadius: 25,
                iconSize: 25,
                icon: const Icon(
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
