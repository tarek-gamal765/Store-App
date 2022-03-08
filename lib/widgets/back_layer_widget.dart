import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/screens/cart/cart.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/wishlist/wishlist.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:ecommerce/screens/upload_product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

Widget backLayerWidget({
  required BuildContext context,
}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          ColorsConsts.starterColor,
          ColorsConsts.endColor,
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: -100,
          left: 140,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 100,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              width: 150,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Positioned(
          top: -50,
          left: 60,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?w=740',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              content(
                context: context,
                icon: FeatherIcons.shoppingBag,
                text: 'Cart',
                onPressed: () {
                  navigateTo(
                    context: context,
                    widget: const CartScreen(),
                  );
                },
              ),
              content(
                context: context,
                icon: FeatherIcons.rss,
                text: 'Feeds',
                onPressed: () {
                  navigateTo(
                    context: context,
                    widget: const FeedsScreen(),
                  );
                },
              ),
              content(
                context: context,
                icon: FeatherIcons.heart,
                text: 'Wishlist',
                onPressed: () {
                  navigateTo(
                    context: context,
                    widget: const WishlistScreen(),
                  );
                },
              ),
              content(
                context: context,
                icon: FeatherIcons.upload,
                text: 'Upload a new product',
                onPressed: () {
                  navigateTo(
                    context: context,
                    widget: const UploadProductForm(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget content({
  required BuildContext context,
  required String text,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            icon,
          ),
        ],
      ),
    ),
  );
}
