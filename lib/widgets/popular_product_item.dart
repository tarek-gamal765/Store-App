import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

Widget popularProductItem({
  required BuildContext context,
}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.38,
    width: MediaQuery.of(context).size.height * 0.34,
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
      children: [
        Stack(
          children: [
            Image(
              image: const NetworkImage(
                'https://img.freepik.com/free-photo/portrait-smiling-young-man-eyewear_171337-4842.jpg?w=740',
              ),
              fit: BoxFit.fill,
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
                badgeContent: const Text('\$ 1200',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Title',
            maxLines: 1,
            style: TextStyle(
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
              Text(
                'Description',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  fontWeight: FontWeight.w500,
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
