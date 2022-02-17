import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/feeds_item.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  static const routeName = '/FeedsScreen';

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    List<ProductModel> products = [];
    if (arguments == 'popular') {
      products = Provider.of<ProductsProvider>(context).popularProduct;
    } else {
      products = Provider.of<ProductsProvider>(context).products;
    }
    return Scaffold(
      appBar: AppBar(),
      body: MasonryGridView.count(
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
                arguments: products[index].id,
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
