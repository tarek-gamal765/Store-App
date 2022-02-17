import 'package:backdrop/backdrop.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/brands_screen.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/back_layer_widget.dart';
import 'package:ecommerce/widgets/category_item.dart';
import 'package:ecommerce/widgets/popular_product_item.dart';
import 'package:ecommerce/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> carouselImages = [
  'assets/images/carousel1.png',
  'assets/images/carousel2.jpeg',
  'assets/images/carousel3.jpg',
  'assets/images/carousel4.png',
];
List<String> brandesImages = [
  'assets/images/addidas.jpg',
  'assets/images/apple.jpg',
  'assets/images/Dell.jpg',
  'assets/images/h&m.jpg',
  'assets/images/nike.jpg',
  'assets/images/samsung.jpg',
  'assets/images/Huawei.jpg',
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
   
    return BackdropScaffold(
      headerHeight: MediaQuery.of(context).size.height * 0.25,
      frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: BackdropAppBar(
        title: const Text("Backdrop Example"),
        leading: const BackdropToggleButton(
          icon: AnimatedIcons.home_menu,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsConsts.starterColor,
                ColorsConsts.endColor,
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.height * 0.06,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {},
              child: const CircleAvatar(
                child: Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/portrait-smiling-young-man-eyewear_171337-4842.jpg?w=740',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
      backLayer: backLayerWidget(context: context),
      frontLayer: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: CarouselSlider(
                items: carouselImages
                    .map(
                      (image) => Image.asset(
                        image,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return buildCategoryItem(
                      context: context,
                      index: index,
                    );
                  },
                  itemCount: 7,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Popular Brands',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  defaultTextButton(
                    text: 'View all',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        BrandsScreen.routeName,
                        arguments: {7},
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.24,
              child: Swiper(
                autoplay: true,
                itemWidth: MediaQuery.of(context).size.height * 0.18,
                itemHeight: MediaQuery.of(context).size.height * 0.24,
                layout: SwiperLayout.DEFAULT,
                onTap: (index) {
                  Navigator.pushNamed(
                    context,
                    BrandsScreen.routeName,
                    arguments: {index},
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      image: AssetImage(
                        brandesImages[index],
                      ),
                      fit: BoxFit.fill,
                    ),
                  );
                },
                itemCount: brandesImages.length,
                curve: Curves.fastOutSlowIn,
                fade: 1,
                duration: 400,
                viewportFraction: 0.8,
                scale: 0.9,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  defaultTextButton(
                    text: 'View all',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        FeedsScreen.routeName,
                        arguments: 'popular',
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: popularProductItem(
                        context: context,
                        productModel: productProvider.popularProduct[index],
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: productProvider.popularProduct[index].id,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
