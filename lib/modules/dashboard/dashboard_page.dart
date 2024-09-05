import 'package:flutter/material.dart';
import 'package:mech_manager/config/colors.dart';

import '../../base_layout.dart';
import 'jobcards.dart';

/*
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'MechManager Admin',
      closeDrawer: _toggleDrawer,
      isDrawerOpen: _isDrawerOpen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Welcome back, Motors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isVertical = constraints.maxWidth <
                      800; // Change this threshold as needed

                  return Card(
                  color: whiteColor,
                    elevation: 5,
                    child: FractionallySizedBox(
                      heightFactor: isVertical
                          ? 1
                          : null, // Occupy full height in vertical mode
                      child: Container(
                 
                        margin: EdgeInsets.all(20),
                        child: isVertical
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Overview',
                                    style: TextStyle(color: blackColor),
                                    textAlign: TextAlign.start,
                                  ),
                                  Expanded(
                                    child: GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            constraints.maxWidth,
                                        mainAxisExtent: 100,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 3 / 2,
                                      ),
                                      itemCount: 8,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
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
                                              title: 'Total Estimate',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else if (index == 2) {
                                          return ResponsiveCard(
                                            child: OverviewCard(
                                              title: 'Total Invoices',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else if (index == 3) {
                                          return ResponsiveCard(
                                            child: OverviewCard(
                                              title: 'Total Staff',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else if (index == 4) {
                                          return ResponsiveCard(
                                            child: OverviewCard(
                                              title: 'Total Customers',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else if (index == 5) {
                                          return ResponsiveCard(
                                            child: OverviewCard(
                                              title: 'Total Stocks',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else if (index == 6) {
                                          return ResponsiveCard(
                                            child: OverviewCard(
                                              title: 'Total Mechanics',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else if (index == 7) {
                                          return ResponsiveCard(
                                            child: OverviewCard(
                                              title: 'JTotal Labours',
                                              count:
                                                  0, // Replace with actual data
                                              icon: Icons.list_alt,
                                              backgroundColor: Colors.blue,
                                              iconColor: Colors.blue.shade800,
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overview',
                                    style: TextStyle(color: blackColor),
                                  ),
                                  GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 280.0,
                                      mainAxisExtent: 100,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio:
                                          constraints.maxWidth > 800
                                              ? 3 / 2
                                              : 1,
                                    ),
                                    itemCount: 8,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
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
                                            title: 'Total Estimate',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else if (index == 2) {
                                        return ResponsiveCard(
                                          child: OverviewCard(
                                            title: 'Total Invoices',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else if (index == 3) {
                                        return ResponsiveCard(
                                          child: OverviewCard(
                                            title: 'Total Staff',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else if (index == 4) {
                                        return ResponsiveCard(
                                          child: OverviewCard(
                                            title: 'Total Customers',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else if (index == 5) {
                                        return ResponsiveCard(
                                          child: OverviewCard(
                                            title: 'Total Stocks',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else if (index == 6) {
                                        return ResponsiveCard(
                                          child: OverviewCard(
                                            title: 'Total Mechanics',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else if (index == 7) {
                                        return ResponsiveCard(
                                          child: OverviewCard(
                                            title: 'Total Labours',
                                            count:
                                                0, // Replace with actual data
                                            icon: Icons.list_alt,
                                            backgroundColor: Colors.blue,
                                            iconColor: Colors.blue.shade800,
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
 final ValueNotifier<String> activeRouteNotifier = ValueNotifier<String>('/job_sheet_listing');
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      activeRouteNotifier: activeRouteNotifier,
      title: 'MechManager Admin',
      closeDrawer: _toggleDrawer,
      isDrawerOpen: _isDrawerOpen,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Welcome back, Motors',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: whiteColor,
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: isMobile ? 200 : 280.0,
                          mainAxisExtent: 100,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: isMobile ? 1 : 3 / 2,
                        ),
                        itemCount: 8,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ResponsiveCard(
                            child: OverviewCard(
                              title: 'Title $index',
                              count: index, // Replace with actual data
                              icon: Icons.work_outline,
                              backgroundColor: Colors.blue,
                              iconColor: Colors.blue.shade800,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
