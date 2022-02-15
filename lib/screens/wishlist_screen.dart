import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Items (1)'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FeatherIcons.trash,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return buildWishlistItem(context);
        },
        itemCount: 20,
      ),
    );
  }

  Widget buildWishlistItem(BuildContext context) => Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            margin: const EdgeInsets.only(top: 12, right: 26, left: 8),
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
                  'https://img.freepik.com/free-psd/smartwatch-mock-up-design_1135-61.jpg?w=740',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.16,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Samsung Watch',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '\$ 16',
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height * 0.06,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.rectangle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close),
                iconSize: 22,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ),
        ],
      );
  Widget buildEmptyWishlist(BuildContext context) => Column(
        children: [
          const Image(
            image: AssetImage('assets/images/empty-wishlist.png'),
          ),
          Text(
            'Your Wishlist Is Empty',
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
            'Explore more and shortlist some items',
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
            text: 'ADD A WISH',
            textStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
        ],
      );
}
