import 'package:flutter/material.dart';

import 'package:ecommerce/screens/categories_feeds_screen.dart';

List<Map<String, String>> categoryImages = [
  {
    'image': 'assets/images/CatPhones.png',
    'categoryName': 'Phones',
  },
  {
    'image': 'assets/images/CatLaptops.png',
    'categoryName': 'Laptops',
  },
  {
    'image': 'assets/images/CatWatches.jpg',
    'categoryName': 'Watches',
  },
  {
    'image': 'assets/images/CatClothes.jpg',
    'categoryName': 'Clothes',
  },
  {
    'image': 'assets/images/CatShoes.jpg',
    'categoryName': 'Shoes',
  },
  {
    'image': 'assets/images/CatFurniture.jpg',
    'categoryName': 'Furniture',
  },
  {
    'image': 'assets/images/CatBeauty.jpg',
    'categoryName': 'Beauty & Health',
  },
];

Widget buildCategoryItem({
  required BuildContext context,
  required int index,
}) =>
    InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          CategoriesFeedsScreen.routeName,
          arguments: categoryImages[index]['categoryName'],
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.only(
              right: 10,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image(
                    image: AssetImage(
                      categoryImages[index]['image']!,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    categoryImages[index]['categoryName']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
