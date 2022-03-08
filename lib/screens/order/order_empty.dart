import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderEmpty extends StatefulWidget {
  const OrderEmpty({Key? key}) : super(key: key);

  @override
  State<OrderEmpty> createState() => _OrderEmptyState();
}

class _OrderEmptyState extends State<OrderEmpty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/6996/6996406.png',
            ),
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(height: 15),
          Text(
            'Your Order is Empty',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            'Looks like you didn\'t \n add any order yet.',
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
            onPressed: () {
              navigateTo(
                context: context,
                widget: const FeedsScreen(),
              );
            },
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
      ),
    );
  }
}
