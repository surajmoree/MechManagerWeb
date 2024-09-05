import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/components/skeletone/job_sheet_row.dart';
import 'package:mech_manager/config.dart' as appInstance;
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

import '../../base_layout.dart';
import '../../config/colors.dart';

class JobSheetListing extends StatefulWidget {
  @override
  State<JobSheetListing> createState() => _JobSheetListingState();
}

class _JobSheetListingState extends State<JobSheetListing>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  String selectedFilterValue = "";
  final ValueNotifier<String> activeRouteNotifier = ValueNotifier<String>('/job_sheet_listing');
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialJobSheets();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  void _fetchInitialJobSheets() {
    context.read<JobSheetBloc>().add(const FetchJobSheets(
          status: jobSheetStatus.loading,
        ));
  }

  void _onScroll() {
    final jobsheetState = context.read<JobSheetBloc>().state;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !jobsheetState.hasReachedMax!) {
      context.read<JobSheetBloc>().add(FetchJobSheets(
          timestamp: jobsheetState.lastTimestamp,
          status: jobSheetStatus.success,
          fromDate: _searchController.text.toString(),
          toDate: _searchController.text.toString(),
          searchKeyword: _searchController.text));
    }
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

    return BaseLayout(
      activeRouteNotifier: activeRouteNotifier,
        title: 'MechManager Admin',
        closeDrawer: _toggleDrawer,
        isDrawerOpen: _isDrawerOpen,
        routeWidgets: [
          GestureDetector(
            onTap: () {
              activeRouteNotifier.value = "/dashboard_page";
              //  Navigator.pushNamed(context, '/dashboard_page');
               Navigator.of(context)
                                        .pushReplacementNamed('/dashboard_page');
            },
            child: const Text(
              "Home",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const Text(" / "),
          const Text(
            "Job Card",
            style: TextStyle(color: greyColor),
          ),
        ],
        ctx: 1,
        key: _scaffoldKey,
        body: LayoutBuilder(builder: (context, constraints) {
          double containerWidth =
              constraints.maxWidth > 600 ? 300.0 : constraints.maxWidth * 0.6;
          double iconContainerWidth =
              constraints.maxWidth > 600 ? 40.0 : constraints.maxWidth * 0.1;
          double textSize = constraints.maxWidth > 600
              ? screenHeight * 0.023
              : screenHeight * 0.018;
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Job Card',
                            style: TextStyle(
                              fontSize: 17,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _fetchInitialJobSheets();
                              _searchController.clear();
                            },
                            child: const SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: greyColor,
                                    size: 22,
                                  ),
                                  Text(
                                    'Reset all',
                                    style: TextStyle(color: greyColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Card(
                  //   elevation: 0,
                  //   child: LayoutBuilder(
                  //     builder: (context, constraints) {
                  //       double containerWidth = constraints.maxWidth > 600
                  //           ? 300.0
                  //           : constraints.maxWidth * 0.6;
                  //       double iconContainerWidth = constraints.maxWidth > 600
                  //           ? 40.0
                  //           : constraints.maxWidth * 0.1;
                  //       double textSize = constraints.maxWidth > 600
                  //           ? screenHeight * 0.023
                  //           : screenHeight * 0.018;

                  //       return Container(
                  //         height: 70,
                  //         color: whiteColor,
                  //         width: constraints.maxWidth,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 20, top: 10, bottom: 10,right: 20),
                  //           child: Row(
                  //             children: [
                  //               Container(
                  //                 width: containerWidth,
                  //                 height: 40,
                  //                 color: lightGreyColor,
                  //                 child: TextField(
                  //                   controller: _searchController,
                  //                   onChanged: (value) {
                  //                     if (value.length > 2) {
                  //                       context.read<JobSheetBloc>().add(
                  //                             FetchJobSheets(
                  //                               searchKeyword:
                  //                                   _searchController.text,
                  //                               fromDate: "",
                  //                               toDate: "",
                  //                               status: jobSheetStatus.loading,
                  //                             ),
                  //                           );
                  //                     } else if (value.isEmpty) {
                  //                       _fetchInitialJobSheets();
                  //                     }
                  //                   },
                  //                   decoration: InputDecoration(
                  //                     hintStyle: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: hintTextColor,
                  //                       fontFamily: 'Mulish',
                  //                       fontSize: textSize,
                  //                     ),
                  //                     contentPadding:
                  //                         EdgeInsets.symmetric(horizontal: 10.0),
                  //                     enabledBorder: OutlineInputBorder(
                  //                       borderSide:
                  //                           BorderSide(color: Colors.grey.shade500),
                  //                     ),
                  //                     focusedBorder: OutlineInputBorder(
                  //                       borderSide:
                  //                           BorderSide(color: Colors.grey.shade500),
                  //                     ),
                  //                     border: OutlineInputBorder(
                  //                       borderSide:
                  //                           BorderSide(color: Colors.grey.shade500),
                  //                     ),
                  //                     hintText:
                  //                         'Search by vehicle number and customer name',
                  //                     fillColor: lightGreyColor,
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(width: 5),
                  //               DecoratedBox(
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(color: Colors.grey.shade500),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                   color:
                  //                       lightGreyColor, // Matches the TextField's background color
                  //                 ),
                  //                 child: PopupMenuButton<String>(
                  //                   tooltip: '',
                  //                   icon: Row(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text(
                  //                         selectedFilterValue.isEmpty
                  //                             ? "Filter by"
                  //                             : selectedFilterValue,
                  //                         style: TextStyle(
                  //                           color: Colors.black87,
                  //                           fontWeight: FontWeight.w500,
                  //                         ),
                  //                       ),
                  //                       SizedBox(width: 8),
                  //                       Icon(
                  //                         Icons.expand_more_outlined,
                  //                         color: Colors.black54,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   itemBuilder: (BuildContext context) {
                  //                     return filterBy.map((String option) {
                  //                       return PopupMenuItem<String>(
                  //                         value: option,
                  //                         child: Text(option),
                  //                       );
                  //                     }).toList();
                  //                   },
                  //                   initialValue: selectedFilterValue.isNotEmpty
                  //                       ? selectedFilterValue
                  //                       : "Filter by",
                  //                   onSelected: (String value) {
                  //                     setState(() {
                  //                       selectedFilterValue = value;
                  //                       performFilterOperation(
                  //                           filterOption: selectedFilterValue);
                  //                     });
                  //                   },
                  //                   color: lightGreyColor,
                  //                   elevation: 3,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                   ),
                  //                   offset: Offset(0, 50),
                  //                 ),
                  //               ),
                  //               SizedBox(width: 5),
                  //               Container(
                  //                 width: iconContainerWidth,
                  //                 height: 40,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(5)),
                  //                   color: primaryColor,
                  //                 ),
                  //                 child: Icon(Icons.search),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  isMobile
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: containerWidth + 20,
                              height: 60,
                              color: lightGreyColor,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  if (value.length > 2) {
                                    context.read<JobSheetBloc>().add(
                                          FetchJobSheets(
                                            searchKeyword:
                                                _searchController.text,
                                            fromDate: "",
                                            toDate: "",
                                            status: jobSheetStatus.loading,
                                          ),
                                        );
                                  } else if (value.isEmpty) {
                                    _fetchInitialJobSheets();
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: textSize,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  hintText:
                                      'Search by vehicle number and customer name',
                                  fillColor: lightGreyColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const SizedBox(width: 5),
                            Container(
                              width: 50,
                              height: 60,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: primaryColor,
                              ),
                              child: const Icon(Icons.search),
                            ),
                            PopupMenuButton<String>(
                              icon: Container(
                                width: 50,
                                height: 60,
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: successColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Image.asset(
                                  "assets/icons/filter.png",
                                  // height: 40,
                                  // width: 40,
                                  color: whiteColor,
                                ),
                              ),
                              itemBuilder: (BuildContext context) {
                                return filterBy.map((String option) {
                                  return PopupMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList();
                              },
                              onSelected: (String value) {
                                performFilterOperation(filterOption: value);
                              },
                              offset: const Offset(0, 60),
                            ),
                          ],
                        )
                      : Card(
                          elevation: 0,
                          child: Container(
                            height: 70,
                            color: whiteColor,
                            width: screenWidth,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 300.0,
                                    height: 40,
                                    color: lightGreyColor,
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (value) {
                                        if (value.length > 2) {
                                          context.read<JobSheetBloc>().add(
                                                FetchJobSheets(
                                                  searchKeyword:
                                                      _searchController.text,
                                                  fromDate: "",
                                                  toDate: "",
                                                  status:
                                                      jobSheetStatus.loading,
                                                ),
                                              );
                                        } else if (value.isEmpty) {
                                          _fetchInitialJobSheets();
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: hintTextColor,
                                          fontFamily: 'Mulish',
                                          fontSize: screenHeight * 0.023,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500),
                                        ),
                                        hintText:
                                            'Search by vehicle number and customer name',
                                        fillColor: lightGreyColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500),
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          lightGreyColor, // Matches the TextField's background color
                                    ),
                                    child: PopupMenuButton<String>(
                                      tooltip: '',
                                      icon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedFilterValue.isEmpty
                                                ? "Filter by"
                                                : selectedFilterValue,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.expand_more_outlined,
                                            color: Colors.black54,
                                          ),
                                        ],
                                      ),
                                      itemBuilder: (BuildContext context) {
                                        return filterBy.map((String option) {
                                          return PopupMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList();
                                      },
                                      initialValue:
                                          selectedFilterValue.isNotEmpty
                                              ? selectedFilterValue
                                              : "Filter by",
                                      onSelected: (String value) {
                                        setState(() {
                                          selectedFilterValue = value;
                                          performFilterOperation(
                                              filterOption:
                                                  selectedFilterValue);
                                        });
                                      },
                                      color: lightGreyColor,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      offset: const Offset(0, 50),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: primaryColor,
                                    ),
                                    child: const Icon(Icons.search),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                  BlocConsumer<JobSheetBloc, JobSheetState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.status == jobSheetStatus.initial ||
                          state.status == jobSheetStatus.loading) {
                        return const CenterLoader();
                      }
                      if (state.jobSheetList.isEmpty) {
                        return const Text('No record found');
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return (index >= state.jobSheetList.length)
                                ? const CenterLoader()
                                : JobSheetRow(
                                    jobSheetDetail: state.jobSheetList[index],
                                  );
                          },
                          // controller: _scrollController,
                          itemCount: state.jobSheetList.length);
                    },
                  ),
                ],
              ),
            ),
          );
        }));
  }

  performFilterOperation({String filterOption = "Today"}) async {
    FocusScope.of(context).unfocus();
    final getCurrentDate = appInstance.utility.getCurrentDate();
    var formatter = DateFormat('yyyy-MM-dd');
    final searchKeyword = _searchController.text.toString().trim();

    switch (filterOption) {
      case "Today":
        context.read<JobSheetBloc>().add(
              FetchJobSheets(
                  searchKeyword: searchKeyword,
                  fromDate: getCurrentDate.toString(),
                  toDate: getCurrentDate.toString(),
                  status: jobSheetStatus.loading),
            );
        break;

      case "Yesterday":
        final getYesterdaysDate = appInstance.utility.getOldDate(dayCount: 1);
        context.read<JobSheetBloc>().add(
              FetchJobSheets(
                  searchKeyword: searchKeyword,
                  fromDate: getYesterdaysDate.toString(),
                  toDate: getYesterdaysDate.toString(),
                  status: jobSheetStatus.loading),
            );
        break;
      case "Last Week":
        DateTime now = DateTime.now(); // Get the current date
        DateTime lastWeekStart = now.subtract(Duration(days: now.weekday + 6));
        DateTime lastWeekEnd = lastWeekStart.add(const Duration(days: 6));
        String formattedStartDate = formatter.format(lastWeekStart);
        String formattedEndDate = formatter.format(lastWeekEnd);
        context.read<JobSheetBloc>().add(
              FetchJobSheets(
                searchKeyword: searchKeyword,
                fromDate: formattedStartDate,
                toDate: formattedEndDate,
                status: jobSheetStatus.loading,
              ),
            );
        break;
      // case "Last Week":
      //   final lastWeekDate = appInstance.utility.getOldDate(dayCount: 7);
      //   context.read<JobSheetBloc>().add(
      //         FetchJobSheets(
      //           searchKeyword: searchKeyword,
      //           fromDate: lastWeekDate.toString(),
      //           toDate: getCurrentDate.toString(),
      //           status: jobSheetStatus.loading,
      //         ),
      //       );
      //   break;

      case "This Month":
        final getFirstDate = appInstance.utility.thisMonthFirstDate();
        context.read<JobSheetBloc>().add(
              FetchJobSheets(
                searchKeyword: searchKeyword,
                fromDate: getFirstDate.toString(),
                toDate: getCurrentDate.toString(),
                status: jobSheetStatus.loading,
              ),
            );
        break;

      case "Last Month":
        final getFirstDateOfLastMonth =
            appInstance.utility.lastMonthFirstDate();
        final getLastDateOfLastMonth = appInstance.utility.lastMonthLastDate();
        context.read<JobSheetBloc>().add(
              FetchJobSheets(
                searchKeyword: searchKeyword,
                fromDate: getFirstDateOfLastMonth.toString(),
                toDate: getLastDateOfLastMonth.toString(),
                status: jobSheetStatus.loading,
              ),
            );
        break;

      case "Date":
        DateTime? selectedDate;
        DateTime? pickeddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100));
        if (pickeddate != null) {
          setState(() {
            selectedDate = pickeddate;
            var formatter = DateFormat('yyyy-MM-dd');
            String formattedDate = formatter.format(selectedDate!);
            context.read<JobSheetBloc>().add(FetchJobSheets(
                  searchKeyword: searchKeyword,
                  fromDate: formattedDate,
                  toDate: "",
                  status: jobSheetStatus.loading,
                ));
          });
        }
        break;

      case "Date Range":
        DateTimeRange? pickedDate = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime.now());
        if (pickedDate != null) {
          String formattedStartDate = formatter.format(pickedDate.start);
          String formattedEndDate = formatter.format(pickedDate.end);
          context.read<JobSheetBloc>().add(FetchJobSheets(
              searchKeyword: searchKeyword,
              fromDate: formattedStartDate,
              toDate: formattedEndDate,
              status: jobSheetStatus.loading));
        }
        break;

      default:
        context.read<JobSheetBloc>().add(FetchJobSheets(
            searchKeyword: searchKeyword,
            fromDate: getCurrentDate.toString(),
            toDate: getCurrentDate.toString(),
            status: jobSheetStatus.loading));
        break;
    }
  }
}
