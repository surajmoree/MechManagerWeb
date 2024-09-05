import 'package:flutter/material.dart';
import 'package:mech_manager/components/skeletone/mobile_drawer.dart';
import 'package:mech_manager/config/colors.dart';

import 'components/skeletone/drawer.dart';
//final ValueNotifier<String> activeRouteNotifier = ValueNotifier<String>('/dashboard_page');

class BaseLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final VoidCallback closeDrawer;
  final bool isDrawerOpen;
  final bool? showFloatingActionButton;
  final List<Widget>? routeWidgets;
   final ValueNotifier<String> activeRouteNotifier;
  int ctx;

   BaseLayout({
    Key? key,
    required this.body,
    required this.title,
    required this.closeDrawer,
    required this.isDrawerOpen,
    this.showFloatingActionButton = true,
    required this.activeRouteNotifier,
    this.routeWidgets,
     this.ctx =0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Scaffold(
        drawer: MobileDrawer(),
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;

          return Row(
            children: [
              if (isDrawerOpen)
                LayoutBuilder(builder: (context, constraints) {
                  // final screenWidth = constraints.maxWidth;
                  // final isMobile = screenWidth < 600;
                  return isMobile? 
                  Container():
                   SizedBox(
                    width: isMobile ? 180 : 211,
                    child: MyDrawer(closeDrawer: closeDrawer, 
                    //activeRouteNotifier: activeRouteNotifier,
                    ),
                    // child: isMobile?
                    //  null: MyDrawer(closeDrawer: closeDrawer),
                  );
                }),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PreferredSize(
                      preferredSize: Size(screenSize.width, 100),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        title: Text(
                          title,
                          style: TextStyle(color: Colors.grey),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            if (isMobile) {
                              // Logic to open the drawer on mobile screens
                             Scaffold.of(context).openDrawer();
                             print('mobile view');
                            } else {
                              closeDrawer();
                              // Implement behavior for non-mobile screens if needed
                            }
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    if (routeWidgets != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: routeWidgets!,
                        ),
                      ),
                    Expanded(child: body),
                  ],
                ),
              ),
            ],
          );
        }),
        floatingActionButton: (showFloatingActionButton != true)
            ? null
            : FloatingActionButton(
                backgroundColor: primaryColor, // successColor
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Adjust this value for more or less rounding
                ),
                onPressed: () {
                  // Your onPressed logic here
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 35,
                ), // blackColor
              ),
      ),
    );
  }
}




