
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/feeds_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  const CategoriesFeedsScreen({Key? key}) : super(key: key);

  static const routeName = '/CategoriesFeedsScreen';

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final products = Provider.of<ProductsProvider>(context).findByCategory(
      categoryName: categoryName,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                'No products related to this category.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            )
          : MasonryGridView.count(
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
    );
  }
}
