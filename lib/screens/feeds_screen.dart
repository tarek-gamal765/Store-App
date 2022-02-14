import 'package:badges/badges.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: 20,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navigateTo(
                context: context,
                widget: const ProductDetailsScreen(),
              );
            },
            child: feedsItem(context: context),
          );
        },
      ),
    );
  }

  Widget feedsItem({required BuildContext context}) => Container(
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height * 0.36,
        width: MediaQuery.of(context).size.width * 0.48,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://img.freepik.com/free-vector/smart-watch-realistic-image-black_1284-11873.jpg?w=740',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.48,
                  filterQuality: FilterQuality.high,
                ),
                Badge(
                  toAnimate: true,
                  animationType: BadgeAnimationType.fade,
                  shape: BadgeShape.square,
                  badgeColor: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
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
                  const Text(
                    'Samsung Watch',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '\$ 1555',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Quantity: 12 left',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
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
}
