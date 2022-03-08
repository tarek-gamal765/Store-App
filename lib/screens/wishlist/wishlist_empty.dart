import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistEmpty extends StatelessWidget {
  const WishlistEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(
          image: AssetImage('assets/images/empty-wishlist.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Your Wishlist Is Empty',
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
          'Explore more and shortlist some items',
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
          text: 'ADD A WISH',
          textStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ],
    );
  }
}
