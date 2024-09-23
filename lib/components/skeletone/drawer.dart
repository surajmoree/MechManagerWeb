import 'package:flutter/material.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/colors.dart';

class MyDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;

  const MyDrawer({super.key, required this.closeDrawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String selectedRoute = '/dashboard_page';

  void selectedItem(route) {
    setState(() {
      selectedRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        elevation: 5,

        //  width: 220,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              height: 60,
              child: Center(
                child: SizedBox(
                  width: 170,
                  child: Image.asset(
                    'assets/icons/mech-logo.png',
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                  child: ValueListenableBuilder<String>(
                      valueListenable: selectedRouteNotifier,
                      builder: (context, selectedRoute, child) {
                        return Column(
                          children: [
                            DrawerItem(
                              imageIcon: '',
                              title: 'Dashboard',
                              route: '/dashboard_page',
                              isSelected: selectedRoute == '/dashboard_page',
                              onTap: () {
                                selectedRouteNotifier.value = "/dashboard_page";
                                Navigator.of(context)
                                    .pushNamed('/dashboard_page');
                                widget.closeDrawer();
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            DrawerItem(
                              imageIcon: '',
                              title: 'Job Card',
                              route: '/job_sheet_listing',
                              isSelected: selectedRoute == "/job_sheet_listing",
                              onTap: () {
                                selectedRouteNotifier.value =
                                    "/job_sheet_listing";
                                Navigator.of(context)
                                    .pushReplacementNamed('/job_sheet_listing');
                                widget.closeDrawer();
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            DrawerItem(
                              imageIcon: '',
                              title: 'Estimate',
                              route: '/estimate_listing',
                              isSelected: selectedRoute == "/estimate_listing",
                              onTap: () {
                                selectedRouteNotifier.value =
                                    "/estimate_listing";
                                Navigator.of(context)
                                    .pushReplacementNamed('/estimate_listing');
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            DrawerItem(
                              imageIcon: '',
                              title: 'Invoice',
                              route: '/invoice',
                              isSelected: selectedRoute == "/invoice",
                              onTap: () {
                                selectedRouteNotifier.value = "/invoice";
                                Navigator.of(context)
                                    .pushReplacementNamed('/invoice');
                              },
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Staff',
                                route: '/staff_page',
                                isSelected: selectedRoute == "/staff_page",
                                onTap: () {
                                  selectedRouteNotifier.value = "/staff_page";
                                  Navigator.of(context)
                                      .pushNamed('/staff_page');
                                }),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Customers',
                                route: '/customer_page',
                                isSelected: selectedRoute == "/customer_page",
                                onTap: () {
                                  selectedRouteNotifier.value =
                                      ('/customer_page');
                                  Navigator.of(context)
                                      .pushNamed('/customer_page');
                                }),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Spare parts',
                                route: '/spare_parts_page',
                                isSelected:
                                    selectedRoute == "/spare_parts_page",
                                onTap: () {
                                  selectedRouteNotifier.value =
                                      "/spare_parts_page";
                                  Navigator.of(context)
                                      .pushNamed('/spare_parts_page');
                                }),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Stocks',
                                route: '/stock_page',
                                isSelected: selectedRoute == "/stock_page",
                                onTap: () {
                                  selectedRouteNotifier.value = '/stock_page';
                                  Navigator.of(context)
                                      .pushNamed('/stock_page');
                                }),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Mechanics',
                                route: '/job_sheet_listing',
                                isSelected: selectedRoute == "/invoice",
                                onTap: widget.closeDrawer),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Laboures',
                                route: '/estimate',
                                isSelected: selectedRoute == "/invoice",
                                onTap: widget.closeDrawer),
                            SizedBox(
                              height: 3,
                            ),
                            DrawerItem(
                                imageIcon: '',
                                title: 'Settings',
                                route: '/estimate',
                                isSelected: selectedRoute == "/invoice",
                                onTap: widget.closeDrawer),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              width: 160,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                color: Colors.black, // Define your black color
                              ),
                              child: ListTile(
                                leading: Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 18, color: whiteColor),
                                ),
                                title: Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14), // Minimized font size
                                ),
                                onTap: widget.closeDrawer,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      })),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  //final String image;
  final String imageIcon;
  final String title;
  final String route;
  final bool isSelected;
  final VoidCallback onTap;

  const DrawerItem({
    // required this.image,
    required this.imageIcon,
    required this.title,
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width < 600 ? 20 : 24;
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      dense: true,
      visualDensity: VisualDensity(vertical: -1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      selected: isSelected,
      selectedTileColor: backgroundColor,

      //selectedColor: Colors.grey[200],
      leading: Text(
        imageIcon,
        style: TextStyle(
            fontSize: 18, color: isSelected ? textColor : dashboardTextColor),
      ),
      //Image.asset(
      //image,
      // imageIcon,
      // width: imageSize,
      // height: imageSize,
      // fit: BoxFit.cover,
      // color: Colors.black,
      // ),
      title: Text(
        title,
        style: TextStyle(
            color: isSelected ? textColor : dashboardTextColor,
            fontSize: 14,
            fontFamily: 'meck'),
      ),
      onTap: () {
        onTap();
        switchDrawerItem(0, context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}

switchDrawerItem(int value, BuildContext context) async {
  int ctx = 0;
  switch (value) {
    case 0:
      if (ctx != 0) {
        Navigator.pushNamed(context, '/dashboard_page');
      }
      break;

    case 1:
      if (ctx != 1) {
        Navigator.pushNamed(context, '/job_sheet_listing');
      }
      break;

    case 2:
      if (ctx != 2) {
        Navigator.pushNamed(context, '/estimate_listing');
      }
  }
}
