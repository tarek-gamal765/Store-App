import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/screens/wishlist/wishlist_empty.dart';
import 'package:ecommerce/screens/wishlist/wishlist_full.dart';
import 'package:ecommerce/widgets/dialog.dart';
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
                'Wishlist (${favouritesProvider.getfavouritesItems.length})',
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
                return ChangeNotifierProvider.value(
                  value: favouritesProvider.getfavouritesItems.values
                      .toList()[index],
                  child: WishlistFull(
                    productId: favouritesProvider.getfavouritesItems.keys
                        .toList()[index],
                  ),
                );
              },
              itemCount: favouritesProvider.getfavouritesItems.length,
            )
          : const WishlistEmpty(),
    );
  }
}
