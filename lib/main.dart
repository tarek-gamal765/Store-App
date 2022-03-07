import 'package:ecommerce/consts/theme_data.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/network/local/shared_prefrence.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/favourites_provider.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/auth/sign_up.dart';
import 'package:ecommerce/screens/brands_screen.dart';
import 'package:ecommerce/screens/categories_feeds_screen.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/screens/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider<FavouritesProvider>(
          create: (context) => FavouritesProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider()..getUserData(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, ThemeProvider themeProvider, child) => MaterialApp(
          routes: {
            CategoriesFeedsScreen.routeName: (context) =>
                const CategoriesFeedsScreen(),
            BrandsScreen.routeName: (context) => const BrandsScreen(),
            FeedsScreen.routeName: (context) => const FeedsScreen(),
            ProductDetailsScreen.routeName: (context) =>
                const ProductDetailsScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
          },
          title: 'E Commerce',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme
              ? Styles.darkTheme(context: context)
              : Styles.lightTheme(context: context),
          home: const UserState(),
        ),
      ),
    );
  }
}
