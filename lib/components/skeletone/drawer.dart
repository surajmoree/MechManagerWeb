import 'package:flutter/material.dart';
import 'package:mech_manager/config/colors.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback closeDrawer;

  const MyDrawer({required this.closeDrawer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      elevation: 5,
      child: Container(
        width: 220,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black, // Define your black color
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              height: 50,
              child: Center(
                child: Image.asset(
                  'assets/icons/mech-logo.png',
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerItem(
                      image: 'assets/Icons/jobcard.png',
                      title: 'Dashboard',
                      route: '/dashboard_page',
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/dashboard_page');
                        closeDrawer();
                      },
                    ),
                    DrawerItem(
                      image: 'assets/Icons/jobcard.png',
                      title: 'Job Card',
                      route: '/job_sheet_listing',
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/job_sheet_listing');
                        closeDrawer();
                      },
                    ),
                    DrawerItem(
                      image: 'assets/Icons/estimate.png',
                      title: 'Estimate',
                      route: '/estimate',
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/estimate');
                      },
                    ),
                    DrawerItem(
                      image: 'assets/Icons/invoice.png',
                      title: 'Invoice',
                      route: '/invoice',
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/invoice');
                      },
                    ),
                    DrawerItem(
                        image: 'assets/Icons/jobcard.png',
                        title: 'Dashboard',
                        route: '/dashboard',
                        onTap: closeDrawer),
                    DrawerItem(
                        image: 'assets/Icons/jobcard.png',
                        title: 'Job Card',
                        route: '/job_sheet_listing',
                        onTap: closeDrawer),
                    DrawerItem(
                        image: 'assets/Icons/estimate.png',
                        title: 'Estimate',
                        route: '/estimate',
                        onTap: closeDrawer),
                    DrawerItem(
                        image: 'assets/Icons/invoice.png',
                        title: 'Invoice',
                        route: '/estimate',
                        onTap: closeDrawer),
                    DrawerItem(
                        image: 'assets/Icons/jobcard.png',
                        title: 'Job Card',
                        route: '/job_sheet_listing',
                        onTap: closeDrawer),
                    DrawerItem(
                        image: 'assets/Icons/estimate.png',
                        title: 'Estimate',
                        route: '/estimate',
                        onTap: closeDrawer),
                    DrawerItem(
                        image: 'assets/Icons/setting.png',
                        title: 'Settings',
                        route: '/estimate',
                        onTap: closeDrawer),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black, // Define your black color
                      ),
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.white),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14), // Minimized font size
                        ),
                        onTap: closeDrawer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String image;
  final String title;
  final String route;
  final VoidCallback onTap;

  const DrawerItem({
    required this.image,
    required this.title,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width < 600 ? 20 : 24;
    return ListTile(
      selectedColor: Colors.grey[200],
      leading: Image.asset(
        image,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      onTap: () {
        onTap();
        Navigator.pushNamed(context, route);
      },
    );
  }
}
