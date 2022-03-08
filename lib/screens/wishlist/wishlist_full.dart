import 'package:ecommerce/models/favourites_model.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistFull extends StatefulWidget {
  const WishlistFull({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  State<WishlistFull> createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final FavouritesProvider favouritesProvider =
        Provider.of<FavouritesProvider>(context);
    final FavouritesModel favouritesModel =
        Provider.of<FavouritesModel>(context);

    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: widget.productId,
            );
          },
          child: Container(
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
}
