import 'package:flutter/material.dart';

/*
double? devicePixelRatio = ScreenUtil().pixelRatio;
double deviceWidth = 1.sw;
double deviceHeight = 1.sh;
double statusBarHeight = ScreenUtil().statusBarHeight;
double bottomBarHeight = ScreenUtil().bottomBarHeight;
double appBarHeight = AppBar().preferredSize.height;
double safeAreaHeight =
    deviceHeight - statusBarHeight - appBarHeight - bottomBarHeight;
double unitWidth = 1.w;
double unitHeight = 1.w;
double sideMenuWidth = 300.w;
double pageHPadding = 10.w;
double pageVPadding = 8.w;
double filterOptionTapWidth = 120.w;
double filterOptionTapSpace = 5.w;
double filterLocationInputWidth = 380.w;
double filterSubtypeOptionWidth = 180.w;
double filterRentFrequencyTapWidth = 100.w;
double filterRoomsOptionSize = 40.w;
double filterSimpleDropdownWidth = 160.w;
double filterCustomDropdownWidth = 380.w;
double filterMinMaxSelectDialogWidth = 300.w;
double filterSingleSelectDialogWidth = 280.w;
double filterMinMaxSelectDialogHeight = 380.w;
double filterSingleSelectDialogHeight = 460.w;
double filterSingleSelectDialogOptionWidth = 260.w;
double filterMinMaxSingleSelectDialogHeight = 240.w;
double filterCircleOptionWidth = 40.w;
double pageTitleSize = 25;
double pageSubtitleSize = 14.sp;
double pageTextSize = 14;
double pageSmallTextSize = 10.sp;
double pageIconSize = 16.sp;
double pageSmallIconSize = 12.sp;
double bottomSheetHPadding = 6.sp;
double bottomSheetVPadding = 4.sp;
double filterPriceOptionWidth = 120.sp;
double filterPriceOptionHeight = 280.sp;
double filterDialogActionButtonsWidth = 116.sp;
double textSmallSize = 11.sp;
double iconSize = 14.sp;
double buttonTextSized = 15.sp;
double drawerMenuItemSize = 17.sp;
double channelRowTextSize = 15.sp;
double linkTitleSize = 23.sp;
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin { 
  late AnimationController _animationController;
  late Animation<double> _drawerSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _drawerSlideAnimation =
        Tween<double>(begin: 0, end: 260).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleDrawer();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Scaffold(
          body: Stack(
            children: [
              // Drawer
              Transform.translate(
                offset: Offset(_drawerSlideAnimation.value - 260, 0),
                child: MyDrawer(closeDrawer: _toggleDrawer),
              ),
              // AppBar and Dashboard
              Transform.translate(
                offset: Offset(_drawerSlideAnimation.value, 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PreferredSize(
                        preferredSize: Size(screenSize.width, 1000),
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: const Text(
                            'MechManager Admin',
                            style: TextStyle(color: Colors.grey),
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: _toggleDrawer,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Welcome back, Motors',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                    
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 250,right: 20),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                int crossAxisCount = constraints.maxWidth > 1400
                                    ? 4
                                    : constraints.maxWidth > 800
                                        ? 3
                                        : 2;
                                                
                                return Card(
                             //     margin: EdgeInsets.all(20),
                                  elevation: 50,
                                  
                             

                                    child: Container(
                                      margin: EdgeInsets.only(top: 50,left: 20,right: 40),
                                  //    width: screenSize.width-340,
                                                                   
                                      child: GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                           maxCrossAxisExtent: 280.0,
                                           mainAxisExtent: 100,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          childAspectRatio: constraints.maxWidth > 800
                                              ? 3 / 2
                                              : 1,
                                        ),
                                        itemCount: 8, // Add your item count here
                                        shrinkWrap: true,
                                      //  physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          // Build your cards dynamically
                                          if (index == 0) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Total Job Card',
                                                count: 14,
                                                icon: Icons.work_outline,
                                                backgroundColor: Colors.green,
                                                iconColor: Colors.green.shade800,
                                              ),
                                            );
                                          } else if (index == 1) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          } 
                                                          
                                          else if (index == 2) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          } 
                                                          
                                          else if (index == 3) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          } else if (index == 4) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          }
                                                          
                                          else if (index == 5) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          } else if (index == 6) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          } else if (index == 7) {
                                            return ResponsiveCard(
                                              child: OverviewCard(
                                                title: 'Job Card Listing',
                                                count: 0, // Replace with actual data
                                                icon: Icons.list_alt,
                                                backgroundColor: Colors.blue,
                                                iconColor: Colors.blue.shade800,
                                              ),
                                            );
                                          }
                                          
                                          
                                          else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                 
                                );
                              },
                            ),
                          ),
                       
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/