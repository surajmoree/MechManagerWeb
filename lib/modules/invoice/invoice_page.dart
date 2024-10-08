import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/vehicle_model.dart';
import 'package:mech_manager/modules/invoice/edit_invoice_customer.dart';
import 'package:mech_manager/modules/invoice/edit_invoice_vehicle.dart';
import 'package:mech_manager/modules/invoice/invoice_listening.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

import '../../base_layout.dart';
import '../../config/colors.dart';

class InvoicePage extends StatefulWidget {
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _formKey = GlobalKey<FormState>();
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/invoice_listing');
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String manufacturerController = '';

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

  assignValue(JobSheetDetailsState state) {
    _fullNameController.text = state.invoiceModel!.fullName.toString();
    _invoiceDateController.text = state.invoiceModel!.tempDate.toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final List<DateTime?> picked = await showCalendarDatePicker2Dialog(
          context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(
            calendarType: CalendarDatePicker2Type.single,
            selectedDayHighlightColor:
                primaryColor, // Customize your primary color
            todayTextStyle: TextStyle(
              // Use todayTextStyle instead of todayHighlightColor
              color: Colors.orange, // Customize today's text color
              fontWeight: FontWeight.bold,
            ),
            controlsTextStyle: TextStyle(
              color: blackColor, // Customize the control text style
              fontWeight: FontWeight.bold,
            ),
            dayTextStyle: TextStyle(
              color: blackColor, // Customize the day text style
            ),
            weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            weekdayLabelTextStyle: TextStyle(
              color: blackColor, // Customize the weekday label style
              fontWeight: FontWeight.bold,
            ),
            lastDate: DateTime(2101),
            firstDate: DateTime(2015, 8),
          ),
          dialogSize: const Size(350, 450), // Set the dialog size
          value: [_selectedDate],
          // You can either remove the locale or use a different implementation if needed
        ) ??
        [];

    if (picked.isNotEmpty && picked[0] != null) {
      setState(() {
        _selectedDate = picked[0]!;
        _invoiceDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.success) {
          assignValue(state);
        }
      },
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async {
              context
                  .read<JobSheetBloc>()
                  .add(const FetchInvoiceList(status: jobSheetStatus.success));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InvoiceListening()));

              utility.resetToastCount();
              utility.resetAdditionalImageCount();
              return true;
            },
            child: BaseLayout(
                activeRouteNotifier: activeRouteNotifier,
                //  activeRouteNotifier: activeRouteNotifier,
                title: 'MechManager Admin',
                closeDrawer: _toggleDrawer,
                isDrawerOpen: _isDrawerOpen,
                showFloatingActionButton: false,
                body:
                    (state.status == JobSheetDetailsStatus.initial ||
                            state.status == JobSheetDetailsStatus.loading)
                        ? const CenterLoader()
                        : Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          'Create Invoice',
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
                                            side: BorderSide(
                                                color: Colors.grey.shade300)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18,
                                                  right: 18,
                                                  top: 15,
                                                  bottom: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        child: Row(
                                                          children: [
                                                            (state.invoiceModel!
                                                                        .invoiceNumber
                                                                        .toString()
                                                                        .length ==
                                                                    1)
                                                                ? Row(
                                                                    children: [
                                                                      Text(
                                                                        '#000${state.invoiceModel!.invoiceNumber.toString()}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              textColor,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .invoiceModel!
                                                                            .fullName
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              textColor,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : (state.invoiceModel!
                                                                            .invoiceNumber
                                                                            .toString()
                                                                            .length ==
                                                                        3)
                                                                    ? Row(
                                                                        children: [
                                                                          Text(
                                                                            '#0${state.invoiceModel!.invoiceNumber.toString()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                              color: textColor,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              ' '),
                                                                          Text(
                                                                            state.invoiceModel!.fullName.toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                              color: textColor,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Text(
                                                                            '#00${state.invoiceModel!.invoiceNumber.toString()}',
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                              color: textColor,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          const Text(
                                                                              ' '),
                                                                          Text(
                                                                            state.invoiceModel!.fullName.toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                              color: textColor,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuButton(
                                                        itemBuilder: (context) =>
                                                            <PopupMenuEntry>[
                                                          const PopupMenuItem(
                                                            value:
                                                                'edit customer',
                                                            child: Text(
                                                                'Edit Customer'),
                                                          ),
                                                          const PopupMenuItem(
                                                            value:
                                                                'edit vehicle',
                                                            child: Text(
                                                                'Edit Vehicle'),
                                                          ),
                                                        ],
                                                        onSelected: (value) {
                                                          if (value ==
                                                              'edit customer') {
                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0))),
                                                                      contentPadding:
                                                                          EdgeInsets.only(
                                                                              top: 10.0),
                                                                      content:
                                                                          InvoiceEditCustomer(
                                                                        id: state
                                                                            .invoiceModel!
                                                                            .invoiceId,
                                                                        fullname: state
                                                                            .invoiceModel!
                                                                            .fullName
                                                                            .toString(),
                                                                        address: state
                                                                            .invoiceModel!
                                                                            .address
                                                                            .toString(),
                                                                        email: state
                                                                            .invoiceModel!
                                                                            .email
                                                                            .toString(),
                                                                        phoneno: state
                                                                            .invoiceModel!
                                                                            .mobileNumber
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                          } else if (value ==
                                                              'edit vehicle') {
                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              print(
                                                                  'vehicle model data $VehicleModel');
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0))),
                                                                      contentPadding:
                                                                          EdgeInsets.only(
                                                                              top: 10.0),
                                                                      content:
                                                                          InvoiceEditVehicle(
                                                                        id: state
                                                                            .invoiceModel!
                                                                            .invoiceId,
                                                                        vehicleName: state
                                                                            .invoiceModel!
                                                                            .vehicleName
                                                                            .toString(),
                                                                        vehicleNumber: state
                                                                            .invoiceModel!
                                                                            .vehicleNumber
                                                                            .toString(),
                                                                        manufacturers: state
                                                                            .invoiceModel!
                                                                            .manufacturers
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                          }
                                                        },
                                                        child: const Icon(
                                                          Icons.more_vert,
                                                          color: hintTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    color: Color.fromARGB(
                                                        255, 207, 207, 207),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: const [
                                                                const Text(
                                                                  "Email:",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          blackColorLight),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                const Text(
                                                                  'Phone:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          blackColorLight),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Address:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          blackColorLight),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 60,
                                                            ),
                                                            Flexible(
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  state.invoiceModel!
                                                                              .email
                                                                              .toString()
                                                                              .isNotEmpty &&
                                                                          state.invoiceModel!.email.toString() !=
                                                                              null
                                                                      ? Text(
                                                                          state
                                                                              .invoiceModel!
                                                                              .email
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  12,
                                                                              fontWeight: FontWeight
                                                                                  .w600))
                                                                      : const Text(
                                                                          "  -",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600)),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  //////////
                                                                  state.invoiceModel!
                                                                          .mobileNumber
                                                                          .toString()
                                                                          .isNotEmpty
                                                                      ? Text(
                                                                          state
                                                                              .invoiceModel!
                                                                              .mobileNumber
                                                                              .toString(),
                                                                          maxLines:
                                                                              2,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600))
                                                                      : const Text(
                                                                          "  -",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  //////////
                                                                  state.invoiceModel!
                                                                          .address
                                                                          .toString()
                                                                          .isNotEmpty
                                                                      ? Text(
                                                                          state
                                                                              .invoiceModel!
                                                                              .address
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: blackColor))
                                                                      : const Text(
                                                                          "  -",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      // v number v name manufactt
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: const [
                                                                Text(
                                                                  "Vehicle number:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          blackColorLight),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "Vehicle name:",
                                                                  maxLines: 6,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          blackColorLight),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "Vehicle Manufacture:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          blackColorLight),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 30,
                                                            ),
                                                            Flexible(
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  state.invoiceModel!
                                                                              .vehicleNumber
                                                                              .toString()
                                                                              .isNotEmpty &&
                                                                          state.invoiceModel!.vehicleNumber.toString() !=
                                                                              null
                                                                      ? Text(
                                                                          state
                                                                              .invoiceModel!
                                                                              .vehicleNumber
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: blackColor))
                                                                      : const Text(
                                                                          "  -",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  //////////
                                                                  state.invoiceModel!
                                                                          .vehicleName
                                                                          .toString()
                                                                          .isNotEmpty
                                                                      ? Text(
                                                                          state
                                                                              .invoiceModel!
                                                                              .vehicleName
                                                                              .toString(),
                                                                          maxLines:
                                                                              2,
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: blackColor))
                                                                      : const Text(
                                                                          "  -",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  //////////
                                                                  state.invoiceModel!
                                                                          .manufacturers
                                                                          .toString()
                                                                          .isNotEmpty
                                                                      ? Text(
                                                                          state
                                                                              .invoiceModel!
                                                                              .manufacturers
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: blackColor))
                                                                      : const Text(
                                                                          "  -",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      //estimate date
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Estimate Date:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(height: 8),
                                                            TextFormField(
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                              controller:
                                                                  _invoiceDateController,
                                                              decoration:
                                                                  InputDecoration(
                                                                suffixIcon:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .calendar_month_sharp),
                                                                  onPressed: () =>
                                                                      _selectDate(
                                                                          context),
                                                                ),
                                                                hintStyle: TextStyle(
                                                                    color:
                                                                        hintTextColor,
                                                                    fontFamily:
                                                                        'Mulish',
                                                                    fontSize:
                                                                        14),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            8),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 0,
                                                                    style:
                                                                        BorderStyle
                                                                            .none,
                                                                  ),
                                                                ),
                                                                isDense: true,
                                                                hintText:
                                                                    "Estimate Date",
                                                                filled: true,
                                                                fillColor:
                                                                    lightGreyColor,
                                                              ),
                                                              onTap: () =>
                                                                  _selectDate(
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ))));
      },
    );
  }
}
