import 'package:badges/badges.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/widgets/feeds_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

Widget feedsItem({
  required BuildContext context,
  ProductModel? productModel,
}) =>
    Container(
      color: Theme.of(context).backgroundColor,
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                productModel!.imageUrl!,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.48,
                filterQuality: FilterQuality.high,
              ),
              Badge(
                toAnimate: true,
                animationType: BadgeAnimationType.fade,
                shape: BadgeShape.square,
                badgeColor: Colors.purple,
                badgeContent:
                    const Text('NEW', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.title!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '\$ ${productModel.price}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Quantity: ${productModel.quantity} left',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        feedsDialog(
                          context: context,
                          productModel: productModel,
                        );
                      },
                      icon: const Icon(
                        FeatherIcons.moreHorizontal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
