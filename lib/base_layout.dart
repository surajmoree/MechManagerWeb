import 'package:flutter/material.dart';
import 'package:mech_manager/components/skeletone/mobile_drawer.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/create_jobsheet/create_job_sheet.dart';

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
    super.key,
    required this.body,
    required this.title,
    required this.closeDrawer,
    required this.isDrawerOpen,
    this.showFloatingActionButton = true,
    required this.activeRouteNotifier,
    this.routeWidgets,
    this.ctx = 0,
  });

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
                  return isMobile
                      ? Container()
                      : SizedBox(
                          width: isMobile ? 180 : 211,
                          child: MyDrawer(
                            closeDrawer: closeDrawer,
                            //activeRouteNotifier: activeRouteNotifier,
                          ),
                          // child: isMobile?
                          //  null: MyDrawer(closeDrawer: closeDrawer),
                        );
                }),
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PreferredSize(
                      preferredSize: Size(screenSize.width, 100),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        title: Text(
                          title,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: blackColor,
                          ),
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
                        actions: const [HumbergerIconButton()],
                      ),
                    ),
                    if (routeWidgets != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 5.0),
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
                  borderRadius: BorderRadius.circular(
                      50), // Adjust this value for more or less rounding
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateJobSheet()));
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

class HumbergerIconButton extends StatelessWidget {
  const HumbergerIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    // return Builder(builder: (context) {
    return Padding(
        padding: const EdgeInsets.only(right: 18),
        child: GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: blackColor,
            radius: 16,
            child: ClipOval(
                child: SizedBox.fromSize(
              size: const Size.fromRadius(16),
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(color: whiteColor),
                ),
              ),
            )),
          ),
        ));
    //   });
  }
}
