import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/customer_page/customer_estimate_row_list.dart';
import 'package:mech_manager/components/customer_page/customer_invoice_row_list.dart';
import 'package:mech_manager/components/customer_page/customer_jobcard_row_list.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/components/skeletone/form_field_title.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({super.key});

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  List<dynamic> vehiclList = [];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animationController.forward();
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

  assignValues(JobSheetDetailsState state) {
    vehiclList = state.customerModel!.vehicles!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.success) {
          assignValues(state);
        }
      },
      builder: (context, state) {
        return BaseLayout(
          showFloatingActionButton: false,
          title: 'MechManager Admin',
          closeDrawer: _toggleDrawer,
          isDrawerOpen: _isDrawerOpen,
          activeRouteNotifier: activeRouteNotifier,
          body:
              (state.status == JobSheetDetailsStatus.initial ||
                      state.status == JobSheetDetailsStatus.loading)
                  ? const CenterLoader()
                  : Form(
                      child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: const Text(
                                'Customer Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Card(
                              shadowColor: whiteColor,
                              color: whiteColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  // borderRadius: BorderRadius.circular(5),
                                  side:
                                      BorderSide(color: Colors.grey.shade300)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                        top: 15,
                                        bottom: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormFieldTitle(
                                            title: state.customerModel!.fullName
                                                .toString()),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        state.customerModel!.address
                                                .toString()
                                                .isNotEmpty
                                            ? Text(state.customerModel!.address
                                                .toString())
                                            : SizedBox.shrink(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 34,
                                              width: 82,
                                              decoration: BoxDecoration(
                                                color: emailbuttoncolor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: emailcolor),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Email',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: emailcolor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 34,
                                              width: 78,
                                              decoration: BoxDecoration(
                                                color: callbuttoncolor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: callcolor),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Call',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: callcolor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 34,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                color: callbuttoncolor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: callcolor),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Additional Call',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: callcolor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Vehicle list: ${state.customerModel!.vehicleCount.toString()}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: greyColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Column(
                                          children: [
                                            for (int i = 0;
                                                i < vehiclList.length;
                                                i++)
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey[300]!),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 18,
                                                              right: 18,
                                                              top: 15,
                                                              bottom: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${i + 1} ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.0,
                                                                color:
                                                                    greyColor),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                vehiclList[i][
                                                                    'vehicle_number'],
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              ),
                                                              // SizedBox(height: 4.0),
                                                              (vehiclList[i]
                                                                      .isNotEmpty)
                                                                  ? Row(
                                                                      children: [
                                                                        Text(
                                                                          vehiclList[i]
                                                                              [
                                                                              'vehicle_name'],
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                8.0),
                                                                        Text(
                                                                            '•'),
                                                                        SizedBox(
                                                                            width:
                                                                                8.0),
                                                                        Text(vehiclList[i]
                                                                            [
                                                                            'manufacturers']),
                                                                      ],
                                                                    )
                                                                  : SizedBox
                                                                      .shrink(),

                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  //jobcard button
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                          'Tapped');
                                                                      if (state
                                                                          .customerModel!
                                                                          .vehicles!
                                                                          .isNotEmpty) {
                                                                        context
                                                                            .read<JobSheetBloc>()
                                                                            .add(
                                                                              GetCustomerInfoJobCard(
                                                                                status: jobSheetStatus.initial,
                                                                                id: state.customerModel!.id.toString(),
                                                                                vehicleId: vehiclList[i]['vehicle_id'].toString(),
                                                                              ),
                                                                            );
                                                                      }

                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  'Jobcard',
                                                                                  style: TextStyle(fontSize: 18),
                                                                                ),
                                                                                IconButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    icon: const Icon(clearIcon))
                                                                              ],
                                                                            ),
                                                                            backgroundColor:
                                                                                whiteColor,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                                            contentPadding:
                                                                                EdgeInsets.only(top: 10.0, bottom: 10),
                                                                            content: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.50,
                                                                                // color: whiteColor,
                                                                                child: BlocConsumer<JobSheetBloc, JobSheetState>(
                                                                                  listener: (context, state) {},
                                                                                  builder: (context, state) {
                                                                                    if (state.status == jobSheetStatus.initial || state.status == jobSheetStatus.loading) {
                                                                                      return const CenterLoader();
                                                                                    }
                                                                                    if (state.customerListing.isEmpty) {
                                                                                      return const Text('No record found');
                                                                                    }
                                                                                    return ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      itemBuilder: (context, index) {
                                                                                        return (index >= state.customerInfoJobcardlisting.length)
                                                                                            ? const CenterLoader()
                                                                                            : CustomersJobCardRowList(
                                                                                                listData: state.customerInfoJobcardlisting[index],
                                                                                              );
                                                                                      },
                                                                                      itemCount: state.customerInfoJobcardlisting.length,
                                                                                    );
                                                                                  },
                                                                                )),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      width:
                                                                          140,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            invoicecardColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        border: Border.all(
                                                                            color:
                                                                                invoiceIconColor),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                              '',
                                                                              style: TextStyle(fontSize: 17, color: invoiceIconColor)),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            'Job Card: ${vehiclList[i]['jobcard_count']}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: invoiceIconColor,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                      width:
                                                                          15.0),
                                                                  // estimate button
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      context
                                                                          .read<
                                                                              JobSheetBloc>()
                                                                          .add(
                                                                            GetCustomerInfoEstimate(
                                                                              status: jobSheetStatus.initial,
                                                                              id: state.customerModel!.id.toString(),
                                                                              vehicleId: vehiclList[i]['vehicle_id'].toString(),
                                                                            ),
                                                                          );

                                                                      if (vehiclList[i]
                                                                              [
                                                                              'vehicle_id']
                                                                          .toString()
                                                                          .isNotEmpty) {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Estimate',
                                                                                    style: TextStyle(fontSize: 18),
                                                                                  ),
                                                                                  IconButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      icon: const Icon(clearIcon))
                                                                                ],
                                                                              ),
                                                                              backgroundColor: whiteColor,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                                              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10),
                                                                              content: SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.50,
                                                                                  // color: whiteColor,
                                                                                  child: BlocConsumer<JobSheetBloc, JobSheetState>(
                                                                                    listener: (context, state) {},
                                                                                    builder: (context, state) {
                                                                                      if (state.status == jobSheetStatus.initial || state.status == jobSheetStatus.loading) {
                                                                                        return const CenterLoader();
                                                                                      }
                                                                                      if (state.customerListing.isEmpty) {
                                                                                        return const Text('No record found');
                                                                                      }
                                                                                      return ListView.builder(
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return (index >= state.customerInfoestimatelisting.length)
                                                                                              ? const CenterLoader()
                                                                                              : CustomerEstimateRowList(
                                                                                                  estimatelistData: state.customerInfoestimatelisting[index],
                                                                                                );
                                                                                        },
                                                                                        itemCount: state.customerInfoestimatelisting.length,
                                                                                      );
                                                                                    },
                                                                                  )),
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      width:
                                                                          140,
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              estimatecardColor,
                                                                          borderRadius: BorderRadius.circular(
                                                                              12),
                                                                          border:
                                                                              Border.all(color: estimateIconColor)),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            '',
                                                                            style:
                                                                                TextStyle(fontSize: 17, color: estimateIconColor),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Estimate: ${vehiclList[i]['estimate_count']}',
                                                                            style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: estimateIconColor,
                                                                                fontWeight: FontWeight.w500),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15.0),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      context
                                                                          .read<
                                                                              JobSheetBloc>()
                                                                          .add(
                                                                            GetCustomerInfoInvoice(
                                                                              status: jobSheetStatus.initial,
                                                                              id: state.customerModel!.id.toString(),
                                                                              vehicleId: vehiclList[i]['vehicle_id'].toString(),
                                                                            ),
                                                                          );

                                                                      if (vehiclList[i]
                                                                              [
                                                                              'vehicle_id']
                                                                          .toString()
                                                                          .isNotEmpty) {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Invoice',
                                                                                    style: TextStyle(fontSize: 18),
                                                                                  ),
                                                                                  IconButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      icon: const Icon(clearIcon))
                                                                                ],
                                                                              ),
                                                                              backgroundColor: whiteColor,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                                              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10),
                                                                              content: SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.50,
                                                                                  // color: whiteColor,
                                                                                  child: BlocConsumer<JobSheetBloc, JobSheetState>(
                                                                                    listener: (context, state) {},
                                                                                    builder: (context, state) {
                                                                                      if (state.status == jobSheetStatus.initial || state.status == jobSheetStatus.loading) {
                                                                                        return const CenterLoader();
                                                                                      }
                                                                                      if (state.customerListing.isEmpty) {
                                                                                        return const Text('No record found');
                                                                                      }
                                                                                      return ListView.builder(
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return (index >= state.customerInfoinvoicelisting.length)
                                                                                              ? const CenterLoader()
                                                                                              : CustomerInvoiceRowList(
                                                                                                  invoicelistData: state.customerInfoinvoicelisting[index],
                                                                                                );
                                                                                        },
                                                                                        itemCount: state.customerInfoinvoicelisting.length,
                                                                                      );
                                                                                    },
                                                                                  )),
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      width:
                                                                          140,
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              staffcardColor,
                                                                          borderRadius: BorderRadius.circular(
                                                                              12),
                                                                          border:
                                                                              Border.all(color: staffIconColor)),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            '',
                                                                            style:
                                                                                TextStyle(fontSize: 17, color: staffIconColor),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Invoice: ${vehiclList[i]['invoice_count']}',
                                                                            style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: staffIconColor,
                                                                                fontWeight: FontWeight.w500),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  )
                                                ],
                                              )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
        );
      },
    );
  }
}
