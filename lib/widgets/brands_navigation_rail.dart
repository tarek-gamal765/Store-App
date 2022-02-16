import 'package:flutter/material.dart';

import 'package:ecommerce/models/product_model.dart';

Widget brandsNavigationRail(
    {required BuildContext context, required ProductModel productModel}) {
  return Container(
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 5),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              image: DecorationImage(
                image: NetworkImage(
                  productModel.imageUrl,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0)
              ],
            ),
          ),
        ),
        FittedBox(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 10.0)
              ],
            ),
            margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text('US ${productModel.price} \$',
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 26.0,
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  productModel.productCategoryName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
