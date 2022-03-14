import 'package:badges/badges.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/cart/cart.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/screens/wishlist/wishlist.dart';
import 'package:ecommerce/widgets/feeds_item.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  static const routeName = '/FeedsScreen';

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  Future<void> getProducts() async{
    final ProductsProvider productsProvider = Provider.of<
        ProductsProvider>(context,listen: false);
    productsProvider.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute
        .of(context)!
        .settings
        .arguments;
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final FavouritesProvider favouritesProvider = Provider.of<
        FavouritesProvider>(context);

    List<ProductModel> products = [];
    if (arguments == 'popular') {
      products = Provider
          .of<ProductsProvider>(context)
          .popularProduct;
    } else {
      products = Provider
          .of<ProductsProvider>(context)
          .productsList;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme
            .of(context)
            .cardColor,
        title: Text(
          'Feeds',
          style: TextStyle(
            fontSize: 20,
            color: Theme
                .of(context)
                .textSelectionTheme
                .selectionColor,
          ),
        ),

        actions: [
          Badge(
            animationType: BadgeAnimationType.slide,
            position: BadgePosition.topEnd(
              top: 5,
              end: 7,
            ),
            badgeColor: Colors.purple,
            badgeContent: Text(
              '${favouritesProvider.getfavouritesItems.length}',
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                navigateTo(
                  context: context,
                  widget: const WishlistScreen(),
                );
              },
              icon: const Icon(FeatherIcons.heart),
              color: Colors.red,
              iconSize: 28,
            ),
          ),
          Badge(
            animationType: BadgeAnimationType.slide,
            position: BadgePosition.topEnd(
              top: 5,
              end: 7,
            ),
            badgeColor: Colors.purple,
            badgeContent: Text(
              '${cartProvider.getCartItems.length}',
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                navigateTo(
                  context: context,
                  widget: const CartScreen(),
                );
              },
              icon: const Icon(FeatherIcons.shoppingCart),
              color: Colors.purple,
              iconSize: 28,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getProducts,
        child: MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: products.length,
          padding: const EdgeInsets.all(8),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProductDetailsScreen.routeName,
                  arguments: products[index].productId,
                );
              },
              child: feedsItem(
                context: context,
                productModel: products[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
