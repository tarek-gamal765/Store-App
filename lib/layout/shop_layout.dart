
import 'package:ecommerce/screens/search_screen.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/feeds_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> pages =  [
    {
      'page': const HomeScreen(),
      'title': 'Home Screen',
    },
    {
      'page': const FeedsScreen(),
      'title': 'Feeds Screen',
    },
    {
      'page': const SearchScreen(),
      'title': 'Search Screen',
    },
    {
      'page': const CartScreen(),
    },
    {
      'page': const UserScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.9),
            ),
          ),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            selectedItemColor: Colors.purple,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home),
                label: 'Home',
                tooltip: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.rss),
                label: 'Feeds',
                tooltip: 'Feeds',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.shoppingCart),
                label: 'Cart',
                tooltip: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.user),
                label: 'User',
                tooltip: 'User',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fabSearch',
        backgroundColor: Colors.purple,
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: const Icon(FeatherIcons.search),
      ),
    );
  }
}
