
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/widgets/divider_widget.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:ecommerce/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ScrollController _scrollController;
  double top = 0.0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                elevation: 0.0,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.deepPurple,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.all(15),
                        centerTitle: true,
                        title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: top <= 180 ? 1.0 : 0,
                          child: Row(
                            children: [
                              Container(
                                height: kToolbarHeight / 1.6,
                                width: kToolbarHeight / 1.6,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        background: Image.network(
                          'https://img.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg?w=740',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title(title: 'User Bag'),
                    dividerWidget(),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.heart,
                      title: 'Wishlist',
                      subTitle: 'Sub Wishlist',
                      trailingIcon: FeatherIcons.chevronRight,
                      onTap: () {
                        navigateTo(
                          context: context,
                          widget: const WishlistScreen(),
                        );
                      },
                    ),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.shoppingCart,
                      title: 'Cart',
                      subTitle: 'Sub Cart',
                      trailingIcon: FeatherIcons.chevronRight,
                      onTap: () {
                        navigateTo(
                          context: context,
                          widget: const CartScreen(),
                        );
                      },
                    ),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.shoppingBag,
                      title: 'My Orders',
                      subTitle: 'Sub Orders',
                      trailingIcon: FeatherIcons.chevronRight,
                      onTap: () {},
                    ),
                    title(title: 'User Information'),
                    dividerWidget(),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.mail,
                      title: 'Email',
                      subTitle: 'Sub Email',
                    ),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.phone,
                      title: 'Phone',
                      subTitle: 'Sub Phone',
                    ),
                    userListTile(
                      context: context,
                      icon: Icons.local_shipping_outlined,
                      title: 'Shopping',
                      subTitle: 'Sub Shopping',
                    ),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.clock,
                      title: 'Joined Date',
                      subTitle: 'Sub Joined Date',
                    ),
                    title(title: 'Settings'),
                    dividerWidget(),
                    ListTileSwitch(
                      value: themeProvider.getTheme,
                      leading: const Icon(FeatherIcons.sun),
                      onChanged: (value) {
                        setState(() {
                          themeProvider.darkTheme = value;
                        });
                      },
                      switchType: SwitchType.cupertino,
                      title: const Text('Dark Theme'),
                      switchActiveColor: Theme.of(context).primaryColor,
                    ),
                    userListTile(
                      context: context,
                      icon: FeatherIcons.logOut,
                      title: 'Logout',
                      subTitle: 'Sub Logout',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Sign Out'),
                              content: const Text('Do you want to sign out ?'),
                              actions: [
                                defaultTextButton(
                                  text: 'Cancel',
                                  onPressed: () {},
                                ),
                                defaultTextButton(
                                  text: 'Ok',
                                  onPressed: () {},
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          buildFab(),
        ],
      ),
    );
  }

  Widget userListTile({
    required BuildContext context,
    required String title,
    required String subTitle,
    required IconData icon,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(trailingIcon),
      subtitle: Text(subTitle),
      onTap: onTap,
      tileColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget title({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildFab() {
    double defaultTopMargin = MediaQuery.of(context).size.height * 0.3;
    double scaleStart = MediaQuery.of(context).size.height * 0.24;
    double scaleEnd = scaleStart / 2;
    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      right: 16,
      top: top,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(scale),
        child: FloatingActionButton(
          heroTag: 'fabUser',
          backgroundColor: Colors.purple,
          child: const Icon(
            FeatherIcons.camera,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
