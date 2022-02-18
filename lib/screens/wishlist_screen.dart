import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/models/favourites_model.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritesProvider = Provider.of<FavouritesProvider>(context);
    return Scaffold(
      appBar: favouritesProvider.getfavouritesItems.isNotEmpty
          ? AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Wishlist Items (${favouritesProvider.getfavouritesItems.length})',
                style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    defaultDialog(
                      context: context,
                      title: 'Clear Wishlist!',
                      subTitle: 'Your wishlist will be cleared!',
                      ok: () {
                        favouritesProvider.clearFavourites();
                        Navigator.pop(context);
                      },
                    );
                  },
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  icon: const Icon(
                    FeatherIcons.trash,
                  ),
                )
              ],
            )
          : null,
      body: favouritesProvider.getfavouritesItems.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetailsScreen.routeName,
                      arguments: favouritesProvider.getfavouritesItems.keys
                          .toList()[index],
                    );
                  },
                  child: buildWishlistItem(
                    context: context,
                    favouritesModel: favouritesProvider
                        .getfavouritesItems.values
                        .toList()[index],
                  ),
                );
              },
              itemCount: favouritesProvider.getfavouritesItems.length,
            )
          : buildEmptyWishlist(context),
    );
  }

  Widget buildWishlistItem({
    required BuildContext context,
    required FavouritesModel favouritesModel,
  }) {
    final favouritesProvider = Provider.of<FavouritesProvider>(context);
    return Stack(
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
                favouritesModel.imageUrl,
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
                          children: [
                            Flexible(
                              child: Text(
                                favouritesModel.title,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                                style: const TextStyle(
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
                        '\$ ${favouritesModel.price}',
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
              onPressed: () {
                defaultDialog(
                  context: context,
                  title: 'Remove Item!',
                  subTitle: 'This product will be removed from your wishlist!',
                  ok: () {
                    favouritesProvider.removeItem(
                      productId: favouritesModel.id,
                    );
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmptyWishlist(BuildContext context) => Column(
        children: [
          const Image(
            image: AssetImage('assets/images/empty-wishlist.png'),
          ),
          const SizedBox(
            height: 20,
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
            onPressed: () {
               navigateTo(
                context: context,
                widget: const FeedsScreen(),
              );
            },
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
