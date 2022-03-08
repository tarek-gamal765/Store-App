import 'package:badges/badges.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/cart/cart.dart';
import 'package:ecommerce/screens/wishlist/wishlist.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/divider.dart';
import 'package:ecommerce/widgets/feeds_item.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/ProductDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final productModel = productProvider.findById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final favouritesProvider = Provider.of<FavouritesProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.network(
              productModel.imageUrl!,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.09,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.23,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(FeatherIcons.save),
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(FeatherIcons.share2),
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productModel.title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'US \$${productModel.price}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 21,
                            color: Provider.of<ThemeProvider>(context).getTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      defaultDivider(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          productModel.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 21,
                            color: Provider.of<ThemeProvider>(context).getTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      defaultDivider(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      detailsItem(
                        context: context,
                        title: 'Brand:',
                        info: productModel.brand!,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailsItem(
                        context: context,
                        title: 'Quantity:',
                        info: '${productModel.quantity} left',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailsItem(
                        context: context,
                        title: 'Category:',
                        info: productModel.productCategoryName!,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailsItem(
                        context: context,
                        title: 'Popularity:',
                        info: productModel.isPopular!
                            ? 'Popular'
                            : 'Barely known',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                defaultDivider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Text(
                        'No reviews yet',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Be the first review!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Provider.of<ThemeProvider>(context).getTheme
                              ? Theme.of(context).disabledColor
                              : ColorsConsts.subTitle,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                defaultDivider(),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Text(
                    'Suggested Products:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.products.length < 7
                        ? productProvider.products.length
                        : 7,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsScreen.routeName,
                            arguments:
                                productProvider.products[index].productId,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: feedsItem(
                            context: context,
                            productModel: productProvider.products[index],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Details',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              centerTitle: true,
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: defaultButton(
                    onPressed: cartProvider.getCartItems
                            .containsKey(productModel.productId)
                        ? null
                        : () {
                            cartProvider.addProductToCart(
                              productId: productModel.productId!,
                              title: productModel.title!,
                              price: productModel.price!,
                              imageUrl: productModel.imageUrl!,
                              quantity: productModel.quantity,
                            );
                          },
                    color: Colors.purple,
                    text: cartProvider.getCartItems
                            .containsKey(productModel.productId)
                        ? 'Added To Cart'
                        : 'ADD TO CART',
                    textStyle: const TextStyle(color: Colors.white),
                    height: 50,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: Theme.of(context).backgroundColor,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            'BUY NOW',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.purple.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      favouritesProvider.addProductToFavourites(
                        productId: productId,
                        title: productModel.title!,
                        price: productModel.price!,
                        imageUrl: productModel.imageUrl!,
                      );
                    },
                    splashColor: ColorsConsts.favColor,
                    child: Container(
                      color: Provider.of<ThemeProvider>(context).getTheme
                          ? Theme.of(context).disabledColor
                          : ColorsConsts.subTitle,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        favouritesProvider.getfavouritesItems
                                .containsKey(productModel.productId)
                            ? Icons.favorite
                            : FeatherIcons.heart,
                        color: favouritesProvider.getfavouritesItems
                                .containsKey(productModel.productId)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsItem({
    required BuildContext context,
    required String title,
    required String info,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 21,
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            info,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 20,
              color: Provider.of<ThemeProvider>(context).getTheme
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
