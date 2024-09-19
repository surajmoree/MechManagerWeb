import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/modules/estimate/estimate_listening.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

import '../../base_layout.dart';

class EstimatePage extends StatefulWidget {
  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final _formKeys = GlobalKey<FormState>();
  String? productId;
  List<dynamic> tasksList = [];
  List<dynamic> assignLabourList = [];
  List<dynamic> assignProductList = [];
  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];
  List<dynamic> labourDetailsList = [];
  List<dynamic> labourDetailsListNew = [];
  List<dynamic> labour = [];
  List<dynamic> sparePart = [];
  int updateIndex = 0;
  final bool _namevalidate = false;
  final bool _validate = false;
  bool? isGenerate = false;
  final FocusNode nameFocusNode = FocusNode();
  bool? showUpdateButton = false;
  bool addNewMode = false;
  String manufacturerController = '';
  int productTotalValue = 0;
  JobSheetModel? jobSheetModel;
  String unitProductControlller = "PCS";
  TextEditingController productNameController = TextEditingController();
  TextEditingController sparePartNameController = TextEditingController();
  TextEditingController quantityProductController =
      TextEditingController(text: '1');
  TextEditingController rateProductController =
      TextEditingController(text: '00');
  String unitLabourController = "UNT";
  TextEditingController labourNameController = TextEditingController();
  TextEditingController rateLabourController = TextEditingController();
  TextEditingController quantityLabourController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _estimateDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? estimateTotalValue;

  assignValue(JobSheetDetailsState state) {
    _fullNameController.text = state.estimateModel!.fullName.toString();
    _estimateDateController.text = state.estimateModel!.tempDate.toString();
    sparePartsList = state.estimateModel!.invoiceProducts!.toList();
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
        _estimateDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }
/*
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: blackColor,
              onSurface: blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: blackColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _estimateDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }
  */

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

  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
        listener: (context, state) {
      if (state.status == JobSheetDetailsStatus.success) {
        assignValue(state);
      }
    }, builder: (context, state) {
      tasksList = state.estimateModel!.customerComplaints!;
      return WillPopScope(
          onWillPop: () async {
            context.read<JobSheetDetailsBloc>().add(ResetLastEstimateId());
            context
                .read<JobSheetBloc>()
                .add(const FetchEstimateList(status: jobSheetStatus.success));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EstimateListing()));

            utility.resetToastCount();
            utility.resetAdditionalImageCount();
            return true;
          },
          child: BaseLayout(
              activeRouteNotifier: activeRouteNotifier,
              title: 'MechManager Admin',
              closeDrawer: _toggleDrawer,
              isDrawerOpen: _isDrawerOpen,
              body: (state.status == JobSheetDetailsStatus.initial ||
                      state.status == JobSheetDetailsStatus.loading)
                  ? const CenterLoader()
                  : Form(
                      key: _formKey,
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
                                  'Estimate',
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    (state.estimateModel!
                                                                .estimateNumber
                                                                .toString()
                                                                .length ==
                                                            1)
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                '#000${state.estimateModel!.estimateNumber.toString()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                state
                                                                    .estimateModel!
                                                                    .fullName
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : (state.estimateModel!
                                                                    .estimateNumber
                                                                    .toString()
                                                                    .length ==
                                                                3)
                                                            ? Row(
                                                                children: [
                                                                  Text(
                                                                    '#0${state.estimateModel!.estimateNumber.toString()}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          textColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Text(' '),
                                                                  Text(
                                                                    state
                                                                        .estimateModel!
                                                                        .fullName
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          textColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Row(
                                                                children: [
                                                                  Text(
                                                                    '#00${state.estimateModel!.estimateNumber.toString()}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          textColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                      ' '),
                                                                  Text(
                                                                    state
                                                                        .estimateModel!
                                                                        .fullName
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          textColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: textfieldColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  3))),
                                                  child: Icon(
                                                    menuIcon,
                                                    size: 14,
                                                  ))
                                            ],
                                          ),
                                          const Divider(
                                            color: Color.fromARGB(
                                                255, 207, 207, 207),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // email phone address
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
                                                          MainAxisSize.min,
                                                      children: const [
                                                        const Text(
                                                          "Email:",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                          'Phone:',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Address:',
                                                          style: TextStyle(
                                                              fontSize: 12,
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
                                                      fit: FlexFit.tight,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          state.estimateModel!
                                                                      .email
                                                                      .toString()
                                                                      .isNotEmpty &&
                                                                  state.estimateModel!
                                                                          .email
                                                                          .toString() !=
                                                                      null
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .email
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                              : const Text(
                                                                  "  -",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .mobileNumber
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .mobileNumber
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                              : const Text(
                                                                  "  -",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .address
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .address
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                          MainAxisSize.min,
                                                      children: const [
                                                        Text(
                                                          "Vehicle number:",
                                                          style: TextStyle(
                                                              fontSize: 12,
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
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Vehicle Manufacture:",
                                                          style: TextStyle(
                                                              fontSize: 12,
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
                                                      fit: FlexFit.tight,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          state.estimateModel!
                                                                      .vehicleNumber
                                                                      .toString()
                                                                      .isNotEmpty &&
                                                                  state.estimateModel!
                                                                          .vehicleNumber
                                                                          .toString() !=
                                                                      null
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .vehicleNumber
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .vehicleName
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .vehicleName
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .manufacturers
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .manufacturers
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Estimate Date:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8),
                                                    TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      controller:
                                                          _estimateDateController,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: IconButton(
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
                                                            fontSize: 14),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        8),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
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

                                                      /*
                                                    
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Estimate Date',
                                                        suffixIcon: IconButton(
                                                          icon: const Icon(Icons
                                                              .calendar_month_sharp),
                                                          onPressed: () =>
                                                              _selectDate(
                                                                  context),
                                                        ),
                                                      ),
                                                      */
                                                      // readOnly: true,
                                                      onTap: () =>
                                                          _selectDate(context),
                                                    ),

                                                    /*
                                                    GestureDetector(
                                                      onTap: () {
                                                        //   _selectDate(context);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 12,
                                                                vertical: 8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Text('05-Sep-2024'),
                                                            // Spacer(),
                                                            // Icon(
                                                            //     Icons
                                                            //         .calendar_today,
                                                            //     size: 16),
                                    
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    */
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 207, 207, 207),
                                    ),

                                    //spare part table
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Spare Parts:',
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontFamily: 'Mulish',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          if (sparePartsList.isNotEmpty) ...[
                                            Table(
                                              border: TableBorder.all(
                                                  color: Colors
                                                      .grey), // Border color and width
                                              columnWidths: {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(
                                                    3), // Increased width for the second column
                                                2: FlexColumnWidth(2),
                                                3: FlexColumnWidth(2),
                                                4: FlexColumnWidth(2),
                                                5: FlexColumnWidth(2),
                                                6: FlexColumnWidth(2),
                                              },
                                              children: [
                                                // Header Row
                                                TableRow(
                                                  decoration: BoxDecoration(
                                                      color: tablerowcolor),
                                                  children: [
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Sr no',
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            'Spare Part Name',
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Quantity',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Unit',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Rate',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Amount',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Action',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Data Rows
                                                for (var spareParts
                                                    in sparePartsList)
                                                  TableRow(
                                                    children: [
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_id']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_name']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_qty']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_unit']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_price']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            ((double.tryParse(spareParts['product_price']
                                                                            .toString()) ??
                                                                        0.0) *
                                                                    (double.tryParse(spareParts['product_qty']
                                                                            .toString()) ??
                                                                        0.0))
                                                                .toStringAsFixed(
                                                                    2),
                                                          ),
                                                        ),
                                                      ),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            color: primaryColor,
                                                          ),
                                                          child: const Icon(
                                                              Icons.add),
                                                        ),
                                                        //  Text(
                                                        //   '',
                                                        //   style: TextStyle(
                                                        //       color: redColor),
                                                        // ),
                                                      )),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ],
                                          if (sparePartsListNew.isNotEmpty) ...[
                                            Table(
                                              border: TableBorder.all(
                                                  color: Colors.grey),
                                              columnWidths: {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(3),
                                                2: FlexColumnWidth(2),
                                                3: FlexColumnWidth(2),
                                                4: FlexColumnWidth(2),
                                                5: FlexColumnWidth(2),
                                                6: FlexColumnWidth(2),
                                              },
                                              children: [
                                                // Header Row
                                                TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Sr no',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            'Spare Part Name',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Quantity',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Unit',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Rate',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Amount',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text('Action',
                                                            style: TextStyle(
                                                              color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Data Rows
                                                for (var spareParts
                                                    in sparePartsListNew)
                                                  TableRow(
                                                    children: [
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_id']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_name']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_qty']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_unit']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(spareParts[
                                                                  'product_price']
                                                              .toString()),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            ((double.tryParse(spareParts['product_price']
                                                                            .toString()) ??
                                                                        0.0) *
                                                                    (double.tryParse(spareParts['product_qty']
                                                                            .toString()) ??
                                                                        0.0))
                                                                .toStringAsFixed(
                                                                    2),
                                                          ),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: ElevatedButton(
                                                            onPressed: () {},
                                                            child: Icon(
                                                                Icons.add)),
                                                        //                             Container(
                                                        //   width: 50,
                                                        //   height: 60,
                                                        //   decoration: const BoxDecoration(
                                                        //     borderRadius:
                                                        //         BorderRadius.all(Radius.circular(5)),
                                                        //     color: primaryColor,
                                                        //   ),
                                                        //   child: const Icon(Icons.search),
                                                        // ),
                                                        //  Text(
                                                        //   '',
                                                        //   style: TextStyle(
                                                        //       color: redColor),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ] else
                                            const SizedBox.shrink(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))));
    });
  }
}
