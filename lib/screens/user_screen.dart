import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/screens/edit_user_info.dart';
import 'package:ecommerce/screens/order/order.dart';
import 'package:ecommerce/screens/wishlist/wishlist.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/cart/cart.dart';
import 'package:ecommerce/widgets/dialog.dart';
import 'package:ecommerce/widgets/divider_widget.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:ecommerce/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.27 +
                  MediaQuery.of(context).padding.top,
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
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    user!.isAnonymous
                                        ? 'https://cdn.vectorstock.com/i/1000x1000/77/30/default-avatar-profile-icon-grey-photo-placeholder-vector-17317730.webp'
                                        : authProvider.userModel!.imageUrl!,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              user.isAnonymous
                                  ? 'Guest'
                                  : authProvider.userModel!.name!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      background: Image.network(
                        user.isAnonymous
                            ? 'https://cdn.vectorstock.com/i/1000x1000/77/30/default-avatar-profile-icon-grey-photo-placeholder-vector-17317730.webp'
                            : authProvider.userModel!.imageUrl!,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
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
                    trailingIcon: FeatherIcons.chevronRight,
                    onTap: () {
                      navigateTo(
                        context: context,
                        widget: const OrderScreen(),
                      );
                    },
                  ),
                  Row(
                    children: [
                      title(title: 'User Information'),
                      const Spacer(),
                      defaultTextButton(
                        text: 'Edit',
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditUserInfo(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  dividerWidget(),
                  userListTile(
                    context: context,
                    icon: FeatherIcons.mail,
                    title: 'Email',
                    subTitle: authProvider.userModel != null
                        ? authProvider.userModel!.email!
                        : '',
                  ),
                  userListTile(
                    context: context,
                    icon: FeatherIcons.phone,
                    title: 'Phone',
                    subTitle: authProvider.userModel != null
                        ? authProvider.userModel!.phone ?? 'Not Exist'
                        : '',
                  ),
                  userListTile(
                    context: context,
                    icon: FeatherIcons.clock,
                    title: 'Joined Date',
                    subTitle: authProvider.userModel != null
                        ? authProvider.userModel!.joinedAt!
                        : '',
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
                    subTitle: '',
                    onTap: () {
                      defaultDialog(
                        context: context,
                        title: 'Logout',
                        subTitle: 'Do you want to logout?',
                        ok: () {
                          FirebaseAuth.instance.signOut().then(
                                (value) => Navigator.pop(context),
                              );
                        },
                        iconData: Icons.logout,
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
    ));
  }

  Widget userListTile({
    required BuildContext context,
    required String title,
    String? subTitle,
    required IconData icon,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(trailingIcon),
      subtitle: Text(subTitle ?? ''),
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
    double defaultTopMargin = MediaQuery.of(context).size.height * 0.26 +
        MediaQuery.of(context).padding.top;
    double scaleStart = MediaQuery.of(context).size.height * 0.22;
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
          onPressed: () {
            // Provider.of<AuthProvider>(context, listen: false).getUserImage(
            //   source: ImageSource.gallery,
            // );
          },
        ),
      ),
    );
  }
}
