import 'package:flutter/material.dart';
class BrandsScreen extends StatefulWidget {
   BrandsScreen({Key? key,required this.selectedIndex}) : super(key: key);
 int selectedIndex = 0;

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  


  List<String> brandsName = [
    'Addidas',
    'Apple',
    'Dell',
    'H&M',
    'Nike',
    'Samsung',
    'Huawei',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: MediaQuery.of(context).size.width * 0.14,
                      groupAlignment: 1.0,
                      selectedIndex: widget.selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          widget.selectedIndex = index;
                          if (widget.selectedIndex == index) {
                            setState(() {
                              print(brandsName[widget.selectedIndex]);
                            });
                          }
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: const <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: const TextStyle(
                        color: Color(0xFFE6BC97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination('Addidas', 10),
                        buildRotatedTextRailDestination("Apple", 10),
                        buildRotatedTextRailDestination("Dell", 10),
                        buildRotatedTextRailDestination("H&M", 10),
                        buildRotatedTextRailDestination("Nike", 10),
                        buildRotatedTextRailDestination("Samsung", 10),
                        buildRotatedTextRailDestination("Huawei", 10),
                        buildRotatedTextRailDestination("All", 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 10,
                ),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) =>
                      brandsNavigationRail(context: context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget brandsNavigationRail({required BuildContext context}) => Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/pair-trainers_144627-3799.jpg?w=740',
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2.0)
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 10.0)
                  ],
                ),
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('US 16 \$',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 26.0,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'CatergoryName',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

NavigationRailDestination buildRotatedTextRailDestination(
  String text,
  double padding,
) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}