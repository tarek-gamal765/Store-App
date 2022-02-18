import 'package:ecommerce/models/favourites_model.dart';
import 'package:flutter/material.dart';

class FavouritesProvider with ChangeNotifier {
  Map<String, FavouritesModel> favouritesItems = {};

  Map<String, FavouritesModel> get getfavouritesItems {
    return favouritesItems;
  }

  void addProductToFavourites({
    required String productId,
    required String title,
    required double price,
    required String imageUrl,
  }) {
    if (favouritesItems.containsKey(productId)) {
      removeItem(productId: productId);
    } else {
      favouritesItems.putIfAbsent(
        productId,
        () => FavouritesModel(
          id: productId,
          title: title,
          imageUrl: imageUrl,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem({required String productId}) {
    favouritesItems.remove(productId);
    notifyListeners();
  }

  void clearFavourites() {
    favouritesItems.clear();
    notifyListeners();
  }
}
