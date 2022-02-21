import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/widgets/feeds_item.dart';
import 'package:ecommerce/widgets/search_by_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  final FocusNode _node = FocusNode();

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    searchTextController.dispose();
  }

  List<ProductModel> searchList = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SearchByHeader(
              stackPaddingTop: 175,
              titlePaddingTop: 50,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsConsts.title,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              stackChild: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: searchTextController.text.isEmpty
                          ? null
                          : () {
                              searchTextController.clear();
                              _node.unfocus();
                            },
                      icon: Icon(
                        FeatherIcons.x,
                        color: searchTextController.text.isNotEmpty
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    searchTextController.text.toLowerCase();
                    setState(() {
                      searchList = productProvider.searchQuery(value);
                    });
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: searchTextController.text.isNotEmpty && searchList.isEmpty
                ? Column(
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        FeatherIcons.search,
                        size: 60,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'No results found',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 240 / 420,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                      searchTextController.text.isEmpty
                          ? productProvider.productsList.length
                          : searchList.length,
                      (index) => feedsItem(
                        context: context,
                        productModel: searchTextController.text.isEmpty
                            ? productProvider.productsList[index]
                            : searchList[index],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
