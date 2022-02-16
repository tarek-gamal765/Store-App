import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/widgets/brands_navigation_rail.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({Key? key}) : super(key: key);
  static const routeName = '/BrandsScreen';

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  List<String> brandsName = [
    'Addidas',
    'Apple',
    'Dell',
    'H&M',
    'Nike',
    'Samsung',
    'Huawei',
    'All',
  ];
  String? routeArgs;
  String? brand;
  int selectedIndex = 0;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    selectedIndex = int.parse(
      routeArgs!.substring(1, 2),
    );
    for (int i = 0; i < brandsName.length; i++) {
      setState(() {
        if (selectedIndex == i) {
          setState(() {
            brand = brandsName[selectedIndex];
          });
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = Provider.of<ProductsProvider>(context, listen: false);
    final brandProducts = allProducts.findByBrand(brandName: brand!);
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: MediaQuery.of(context).size.width * 0.14,
                      groupAlignment: 1.0,
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          selectedIndex = index;
                          brand = brandsName[selectedIndex];
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: const <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: const TextStyle(
                        color: Color(0xFFE6BC97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination('Addidas', 10),
                        buildRotatedTextRailDestination("Apple", 10),
                        buildRotatedTextRailDestination("Dell", 10),
                        buildRotatedTextRailDestination("H&M", 10),
                        buildRotatedTextRailDestination("Nike", 10),
                        buildRotatedTextRailDestination("Samsung", 10),
                        buildRotatedTextRailDestination("Huawei", 10),
                        buildRotatedTextRailDestination("All", 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 10,
                ),
                child: ListView.builder(
                  itemCount: brandProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        navigateTo(
                          context: context,
                          widget: ProductDetailsScreen(
                            productModel: brandProducts[index],
                          ),
                        );
                      },
                      child: brandsNavigationRail(
                        context: context,
                        productModel: brandProducts[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
  String text,
  double padding,
) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}
