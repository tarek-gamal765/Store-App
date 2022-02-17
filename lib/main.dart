import 'package:ecommerce/consts/theme_data.dart';
import 'package:ecommerce/layout/shop_layout.dart';
import 'package:ecommerce/network/local/shared_prefrence.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/brands_screen.dart';
import 'package:ecommerce/screens/categories_feeds_screen.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();
  void getCurrentTheme() async {
    themeProvider.darkTheme = await SharedPref.getData(key: 'isDark') ?? false;
  }

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
    print('isDark is ${SharedPref.getData(key: 'isDark')}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => themeProvider,
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, ThemeProvider themeProvider, child) => MaterialApp(
          routes: {
            CategoriesFeedsScreen.routeName: (context) =>
                const CategoriesFeedsScreen(),
            BrandsScreen.routeName: (context) =>
             const BrandsScreen(),
             FeedsScreen.routeName: (context) => const FeedsScreen(),
             ProductDetailsScreen.routeName: (context) => const ProductDetailsScreen(),
             
          },
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme
              ? Styles.darkTheme(context: context)
              : Styles.lightTheme(context: context),
          home: ShopLayout(),
        ),
      ),
    );
  }
}
