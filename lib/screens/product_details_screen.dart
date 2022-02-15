import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/divider.dart';
import 'package:ecommerce/widgets/feeds_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Details',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.heart),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.shoppingCart),
            color: Colors.purple,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              color: Colors.black12,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.22,
              vertical: MediaQuery.of(context).size.height * 0.06,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.network(
              'https://img.freepik.com/free-psd/smartwatch-mock-up-design_1135-61.jpg?w=740',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.07),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
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
                          'title',
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
                          'US \$ 15',
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
                          'Description',
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
                        info: 'Brand Name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailsItem(
                        context: context,
                        title: 'Quantity:',
                        info: '12 left',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailsItem(
                        context: context,
                        title: 'Category:',
                        info: 'Category Name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailsItem(
                        context: context,
                        title: 'Popularity:',
                        info: 'Popular',
                      ),
                    ],
                  ),
                ),
                defaultDivider(
                  padding: const EdgeInsets.only(top: 15),
                ),
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
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: feedsItem(context: context),
                      );
                    }),
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
                    onPressed: () {},
                    color: Colors.purple,
                    text: 'ADD TO CART',
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
                    onTap: () {},
                    splashColor: ColorsConsts.favColor,
                    child: Container(
                      color: Provider.of<ThemeProvider>(context).getTheme
                          ? Theme.of(context).disabledColor
                          : ColorsConsts.subTitle,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        FeatherIcons.heart,
                        color: Colors.white,
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
