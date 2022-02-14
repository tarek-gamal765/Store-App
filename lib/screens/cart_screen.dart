import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items (1)'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FeatherIcons.trash,
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width * 0.17,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return buildCartItem(context);
          },
          itemCount: 20,
        ),
      ),
      bottomSheet: buildBottomSheet(context: context),
    );
  }

  Widget buildBottomSheet({required BuildContext context}) => Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: defaultButton(
                borderRadius: 20,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.redAccent,
                text: 'Checkout',
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Total:',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              '1600',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      );

  Widget buildCartItem(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.2,
        margin: const EdgeInsets.only(top: 12, right: 8, left: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
        child: Row(
          children: [
            Image.network(
              'https://img.freepik.com/free-psd/smartwatch-mock-up-design_1135-61.jpg?w=740',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.18,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Samsung Watch',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          iconSize: 22,
                          color: Colors.red,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Text('Price:'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '4000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                  Row(
                    children: [
                      const Text('Sub Total:'),
                      const SizedBox(width: 5),
                      Text(
                        '4000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Provider.of<ThemeProvider>(context).getTheme
                              ? Colors.brown.shade900
                              : Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  Row(
                    children: [
                      Text(
                        'Ships Free:',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).getTheme
                              ? Colors.brown.shade900
                              : Colors.deepPurple,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(FeatherIcons.minus),
                        iconSize: 22,
                        color: Colors.red,
                        splashRadius: 0.5,
                        onPressed: () {},
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorsConsts.gradiendLStart,
                                ColorsConsts.gradiendLEnd,
                              ],
                              stops: const [
                                0.0,
                                0.7,
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: const Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            //textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(FeatherIcons.plus),
                        iconSize: 22,
                        color: Colors.green,
                        splashRadius: 0.5,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  Widget buildEmptyCart(BuildContext context) => Column(
        children: [
          const Image(
            image: AssetImage('assets/images/emptycart.png'),
          ),
          Text(
            'Your Cart Is Empty',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            'Looks like you didn\'t \n add anything to your cart yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Provider.of<ThemeProvider>(context).getTheme
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          defaultButton(
            borderRadius: 20,
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.redAccent,
            text: 'SHOP NOW',
            textStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
        ],
      );
}
