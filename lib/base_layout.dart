import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/components/skeletone/mobile_drawer.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/customer/create_customer.dart';
import 'package:mech_manager/modules/estimate/create_estimate_form.dart';
import 'package:mech_manager/modules/invoice/create_invoice_form.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_state.dart';
import 'package:mech_manager/modules/job_sheet/create_jobsheet/create_job_sheet.dart';
import 'package:mech_manager/modules/labours/create_labour.dart';
import 'package:mech_manager/modules/mechanics/create_mechanic.dart';

import 'components/skeletone/drawer.dart';

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
    // String currentRoute = activeRouteNotifier.value;
    // print("current rout==========$currentRoute");
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
                  return isMobile
                      ? Container()
                      : SizedBox(
                          width: isMobile ? 180 : 211,
                          child: MyDrawer(
                            closeDrawer: closeDrawer,
                          ),
                        );
                }),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PreferredSize(
                      preferredSize: Size(screenSize.width, 100),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        title: Text(
                          title,
                          style: const TextStyle(
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (activeRouteNotifier.value ==
                      '/job_sheet_listing') // Correct route comparison
                    FloatingActionButton(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateJobSheet(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  if (activeRouteNotifier.value == '/estimate_listing')
                    FloatingActionButton(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateEstimatePage(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  if (activeRouteNotifier.value ==
                      '/invoice_listing') // Correct the route string
                    FloatingActionButton(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateInvoicePage(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  if (activeRouteNotifier.value ==
                      '/mechanics_listing') // Correct the route string
                    FloatingActionButton(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateMechanic(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  if (activeRouteNotifier.value ==
                      '/labours_listing') // Correct the route string
                    FloatingActionButton(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateLabour(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    //CreateCustomer
                    if (activeRouteNotifier.value ==
                      '/customer_listing') // Correct the route string
                    FloatingActionButton(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateCustomer(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  // Widget? _buildFloatingActionButton(
  //     BuildContext context, String currentRoute) {
  //   if (currentRoute == '/job_sheet_listing') {
  //     return FloatingActionButton(
  //       backgroundColor: primaryColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(50),
  //       ),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const CreateJobSheet()),
  //         );
  //       },
  //       child: const Icon(
  //         Icons.add,
  //         color: Colors.black,
  //         size: 35,
  //       ),
  //     );
  //   } else if (currentRoute == '/estimate_listing') {
  //     return FloatingActionButton(
  //       backgroundColor: primaryColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(50),
  //       ),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const CreateEstimatePage()),
  //         );
  //       },
  //       child: const Icon(
  //         Icons.add,
  //         color: Colors.black,
  //         size: 35,
  //       ),
  //     );
  //   } else if (currentRoute == '/invoice_listing') {
  //     return FloatingActionButton(
  //       backgroundColor: primaryColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(50),
  //       ),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const CreateInvoicePage()),
  //         );
  //       },
  //       child: const Icon(
  //         Icons.add,
  //         color: Colors.black,
  //         size: 35,
  //       ),
  //     );
  //   }

  //   return null;
  // }
}

class HumbergerIconButton extends StatelessWidget {
  const HumbergerIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileSectionBloc, ProfileSectionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final id = state.profileModel!.companyId.toString();
        return Padding(
          padding: const EdgeInsets.only(
            right: 18,
          ),
          child: PopupMenuButton(
            color: blackColor,
            tooltip: '',
            offset: const Offset(
                0, 40), // Adjust the offset to control the position
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'Setting',
                child: Text(
                  'Setting',
                  style: TextStyle(color: whiteColor),
                ),
              ),
              const PopupMenuItem(
                value: 'Logout',
                child: Text('Logout', style: TextStyle(color: whiteColor)),
              ),
            ],
            onSelected: (value) async{
              if (value == 'Setting') {
                print('setttinggg');
                Navigator.of(context).pushNamed("/setting_page");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SettingsPage()));
                context
                    .read<ProfileSectionBloc>()
                    .add(const FetchProfileInfo());
                context
                    .read<JobSheetDetailsBloc>()
                    .add(GetProfileDetail(id: id));
              } else if (value == 'Logout') {
               context.read<JobSheetBloc>().add(LogOutEvent());
                 Navigator.pushNamedAndRemoveUntil(
                    context, '/login_screen', (route) => false);
              }
            },
            child: CircleAvatar(
              backgroundColor: blackColor,
              radius: 16,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(16),
                  child: const Center(
                    child: Text(
                      "",
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
