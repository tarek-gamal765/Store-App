import 'package:ecommerce/widgets/bottom_nav_bar.dart';
import 'package:ecommerce/screens/upload_product_form.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          BottomNavBar(),
          UploadProductForm(),
        ],
      ),
    );
  }
}
