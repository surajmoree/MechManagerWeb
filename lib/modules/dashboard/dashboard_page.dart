import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

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
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BaseLayout(
        activeRouteNotifier: activeRouteNotifier,
        title: 'MechManager Admin',
        closeDrawer: _toggleDrawer,
        isDrawerOpen: _isDrawerOpen,
        showFloatingActionButton: false,
        body: BlocConsumer<JobSheetBloc, JobSheetState>(
            listener: (context, state) {},
            builder: (context, state) {
              return (state.status == jobSheetStatus.loading ||
                      state.status == jobSheetStatus.initial)
                  ? const CenterLoader()
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 600;

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 22, top: 10),
                                child: Text(
                                  'Welcome back, Motors',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child:
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 5),
                                child: Card(
                                  //  margin: EdgeInsets.all(20),
                                  color: whiteColor,
                                  elevation: 0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 25, bottom: 5),
                                          child: Text(
                                            'Overview',
                                            style: TextStyle(
                                                // fontFamily: 'meck',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, bottom: 20),
                                        child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent:
                                                isMobile ? 200 : 280.0,
                                            mainAxisExtent: 100,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            childAspectRatio:
                                                isMobile ? 1 : 3 / 2,
                                          ),
                                          itemCount: 8,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            if (index == 0) {
                                              return GestureDetector(
                                                onTap: () {
                                                  context.read<JobSheetBloc>().add(
                                            const FetchJobSheets(
                                                status: jobSheetStatus.success));
                                        Navigator.pushNamed(
                                            context, '/job_sheet_listing');
                                                },
                                                child: ResponsiveCard(
                                                  child: OverviewCard(
                                                    title: 'Total Job Card',
                                                    count: state.dashboardModel!.totalRepair.toString(),
                                                    container: Container(
                                                      height: 44,
                                                      width: 44,
                                                      decoration: BoxDecoration(
                                                        color: jobcardColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                jobcardIconColor),
                                                      )),
                                                    ),
                                                    // icon: Icons.work_outline,
                                                    backgroundColor: Colors.green,
                                                    iconColor: Colors.greenAccent,
                                                  ),
                                                ),
                                              );
                                            } else if (index == 1) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Estimate',
                                                  count:
                                                     state.dashboardModel!.totalEstimate.toString(),
                                                  //  icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: estimatecardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color:
                                                              estimateIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else if (index == 2) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Invoices',
                                                  count:
                                                      state.dashboardModel!.totalInvoice.toString(),
                                                  //  icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: invoicecardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color:
                                                              invoiceIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else if (index == 3) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Staff',
                                                  count:
                                                      state.dashboardModel!.userCount.toString(),
                                                  //  icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: staffcardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: staffIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else if (index == 4) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Customers',
                                                  count:
                                                      state.dashboardModel!.totalCustomer.toString(),
                                                  //  icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: customercardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color:
                                                              customerIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else if (index == 5) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Stocks',
                                                  count:
                                                      state.dashboardModel!.totalProduct.toString(),
                                                  // icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: stockcardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: stockIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else if (index == 6) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Mechanics',
                                                  count:
                                                     state.dashboardModel!.totalMechanic.toString(),
                                                  //  icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: mechanicscardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color:
                                                              mechanicsIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else if (index == 7) {
                                              return ResponsiveCard(
                                                child: OverviewCard(
                                                  title: 'Total Labours',
                                                  count:
                                                      state.dashboardModel!.totalLabour.toString(),
                                                  // icon: Icons.list_alt,
                                                  container: Container(
                                                    height: 44,
                                                    width: 44,
                                                    decoration: BoxDecoration(
                                                      color: labourscardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color:
                                                              laboursIconColor),
                                                    )),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  iconColor: Colors.blue.shade800,
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                          /*
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
                            */
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // ),
                            ],
                          ),
                        );
                      },
                    );
            }));
  }
}
