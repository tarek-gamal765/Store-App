import 'package:ecommerce/consts/theme_data.dart';
import 'package:ecommerce/layout/shop_layout.dart';
import 'package:ecommerce/network/local/shared_prefrence.dart';
import 'package:ecommerce/provider/theme_provider.dart';
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
        ChangeNotifierProvider(
          create: (context) => themeProvider,
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, ThemeProvider themeProvider, child) => MaterialApp(
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