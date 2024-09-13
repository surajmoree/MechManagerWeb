import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/select_image_row.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/components/skeletone/form_field_title.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/models/customer_complaint.dart';
import 'package:mech_manager/models/customer_model.dart';
import 'package:mech_manager/models/mechanic_model.dart';
import 'package:mech_manager/models/vehicle_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_state.dart';
import 'package:mech_manager/modules/job_sheet/job_sheet_listening.dart';

class CreateJobSheet extends StatefulWidget {
  const CreateJobSheet({super.key});

  @override
  State<CreateJobSheet> createState() => _CreateJobSheetState();
}

class _CreateJobSheetState extends State<CreateJobSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _formKey = GlobalKey<FormState>();
  bool _isDrawerOpen = true;
  List<dynamic> assignMechanicList = [];
  List<dynamic> tasksList = [];
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  dynamic valuejack = {'name': "Jack & Tommy", 'checked': false, 'value': ""};
  dynamic valuestep = {'name': "Stepney", 'checked': false, 'value': ""};
  dynamic valuetool = {'name': "Tool Kit", 'checked': false, 'value': ""};
  dynamic valuetap = {'name': "Tape", 'checked': false, 'value': ""};
  dynamic valuebattery = {'name': "Battery", 'checked': false, 'value': ""};
  dynamic valuerh = {'name': "Mirror RH", 'checked': false, 'value': ""};
  dynamic valuelh = {'name': "Mirror LH", 'checked': false, 'value': ""};
  dynamic valuemat = {'name': "Mats", 'checked': false, 'value': ""};
  dynamic valueMudFlap = {'name': "Mud Flap", 'checked': false, 'value': ""};

  TextEditingController fullNameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController _wheelcapController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController _alternatePhoneNumber = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController batteryNameController = TextEditingController();
  TextEditingController kmsController = TextEditingController();
  TextEditingController customerComplaintController = TextEditingController();
  TextEditingController taskToDoController = TextEditingController();
  TextEditingController assignMechanicController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController mudFlapController = TextEditingController();
  TextEditingController matevalueController = TextEditingController();
  TextEditingController fieldTextEditingController = TextEditingController();
  //dropdown  controller
  String manufacturerController = '';
  String fuelController = '';
  String batteryCompanyController = '';
  String errorMessage = '';
  String statusListController = 'New Job';
  //images
  XFile frontImage = XFile("");
  XFile rightHandSideImage = XFile("");
  XFile leftHandSideImage = XFile("");
  XFile rearImage = XFile("");
  XFile dashboardImage = XFile("");
  XFile engineImage = XFile("");

  // Additonal Images
  XFile imageOne = XFile("");
  XFile imageTwo = XFile("");
  XFile imageThree = XFile("");
  XFile imageFour = XFile("");
  bool? showUpdateButton = false;
  final FocusNode vehiclefFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  bool _validate = false;
  bool _nameValidate = false;
  bool _mobileValidate = false;
  bool _task = false;
  int updateIndex = 0;
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
    return BlocListener<JobSheetBloc, JobSheetState>(
        listener: (context, state) {
          if (state.status == jobSheetStatus.sending) {
            CenterLoader.show(context);
          }
          if (state.status == jobSheetStatus.submitSuccess) {
            CenterLoader.hide();
            Fluttertoast.showToast(
                toastLength: Toast.LENGTH_SHORT,
                msg: "Job card added successfully",
                backgroundColor: successDarkColor);
            Navigator.pushNamed(context, "/job_sheet_listing");
          } else if (state.status == jobSheetStatus.submitFailure) {
            CenterLoader.hide();
          }
        },
        child: WillPopScope(
            onWillPop: () async {
              appConfig.toastCount = 0;
              appConfig.additonalImageCount = 0;
              context
                  .read<JobSheetBloc>()
                  .add(const FetchJobSheets(status: jobSheetStatus.success));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobSheetListing()),
              );
              return true;
            },
            child: BaseLayout(
                title: 'MechMenager Admin',
                closeDrawer: _toggleDrawer,
                isDrawerOpen: _isDrawerOpen,
                showFloatingActionButton: false,
                activeRouteNotifier: activeRouteNotifier,
                body: Form(
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
                                'Job Card Update',
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
                                  //vehicle details
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                        top: 15,
                                        bottom: 15),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title: "Vehicle Details:"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Vehicle number:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      Icon(Icons.star,
                                                          color: redColor,
                                                          size: 8)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  BlocBuilder<SearchBloc,
                                                          SearchState>(
                                                      builder:
                                                          (context, state) {
                                                    return Autocomplete<
                                                        VehicleModel>(
                                                      optionsBuilder:
                                                          (TextEditingValue
                                                              textEditingValue) {
                                                        if (textEditingValue
                                                            .text.isEmpty) {
                                                          return [];
                                                        }
                                                        return state
                                                            .vehicleDetails!
                                                            .where((element) => element
                                                                .vehiclenumber!
                                                                .toLowerCase()
                                                                .contains(
                                                                    textEditingValue
                                                                        .text
                                                                        .toLowerCase()));
                                                      },
                                                      displayStringForOption:
                                                          (vehicle) => vehicle
                                                              .vehiclenumber!,
                                                      fieldViewBuilder: (BuildContext
                                                              context,
                                                          TextEditingController
                                                              fieldTextEditingController,
                                                          FocusNode
                                                              fieldFocusNode,
                                                          VoidCallback
                                                              onFieldSubmitted) {
                                                        return TextField(
                                                          controller:
                                                              fieldTextEditingController,
                                                          focusNode: _validate
                                                              ? vehiclefFocusNode
                                                              : fieldFocusNode,

                                                          style: TextStyle(
                                                              fontSize: 13),
                                                          // focusNode: fieldFocusNode,
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle: TextStyle(
                                                                color:
                                                                    hintTextColor,
                                                                fontFamily:
                                                                    'meck',
                                                                fontSize: 12),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            16),
                                                            errorText: _validate
                                                                ? "Please enter correct vehicle number"
                                                                : null,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
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
                                                                "MH15AB2000",
                                                            filled: true,
                                                            fillColor:
                                                                textfieldColor,
                                                          ),
                                                          onChanged: (text) {
                                                            if (text
                                                                .isNotEmpty) {
                                                              context
                                                                  .read<
                                                                      SearchBloc>()
                                                                  .add(SearchVehicleDetails(
                                                                      searchKeyword:
                                                                          text));
                                                              vehicleNumberController =
                                                                  fieldTextEditingController;
                                                            }
                                                          },
                                                        );
                                                      },
                                                      onSelected: (suggestion) {
                                                        setState(() {
                                                          vehicleNumberController
                                                                  .text =
                                                              suggestion
                                                                  .vehiclenumber!;

                                                          vehicleNameController
                                                                  .text =
                                                              suggestion
                                                                  .vehiclename!;

                                                          fullNameController
                                                                  .text =
                                                              suggestion
                                                                  .fullName!;

                                                          adressController
                                                                  .text =
                                                              suggestion
                                                                  .address!;

                                                          emailController.text =
                                                              suggestion.email!;

                                                          phoneNumberController
                                                                  .text =
                                                              suggestion
                                                                  .mobileNumber!;
                                                          if (suggestion
                                                                  .manufacturers!
                                                                  .isNotEmpty &&
                                                              suggestion
                                                                      .manufacturers !=
                                                                  null) {
                                                            manufacturerController =
                                                                suggestion
                                                                    .manufacturers!;
                                                          } else {
                                                            manufacturerController =
                                                                "";
                                                          }

                                                          // Set cursor position to the end of the text
                                                          vehicleNumberController
                                                                  .selection =
                                                              TextSelection.fromPosition(
                                                                  TextPosition(
                                                                      offset: vehicleNumberController
                                                                          .text
                                                                          .length));
                                                          // Set cursor position to the end of the text
                                                        });
                                                      },
                                                    );
                                                  })
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    20), // Space between the TextFields
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Vehical name:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        vehicleNameController,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 16),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      hintText:
                                                          "Enter vehicle name",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),

                                            //manufatt
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Manufacturer:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  DropdownButtonFormField2(
                                                    value: manufacturerController
                                                            .isNotEmpty
                                                        ? manufacturerController
                                                        : null,
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.5,
                                                              horizontal: 10),
                                                      isDense: true,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                    hint: const Text(""),

                                                    // dropdownMaxHeight: 450,
                                                    isExpanded: true,
                                                    items: manufacturerCompaniesList
                                                        .map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value.toString(),
                                                        child: Text(
                                                          value,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            // wordSpacing: 3,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        manufacturerController =
                                                            value!.toString();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),
                                  //customer details
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18, bottom: 15),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title: "Customer Details:"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Full Name :",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      Icon(Icons.star,
                                                          color: redColor,
                                                          size: 8)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  BlocBuilder<SearchBloc,
                                                          SearchState>(
                                                      builder:
                                                          (context, state) {
                                                    return Autocomplete<
                                                        CustomerModel>(
                                                      optionsBuilder:
                                                          (TextEditingValue
                                                              textEditingValue) {
                                                        if (textEditingValue
                                                                .text ==
                                                            '') {
                                                          return const Iterable<
                                                              CustomerModel>.empty();
                                                        }
                                                        return state
                                                            .customerList!
                                                            .where((element) => element
                                                                .fullName
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(
                                                                    textEditingValue
                                                                        .text
                                                                        .toLowerCase()));
                                                      },
                                                      displayStringForOption:
                                                          (vehicle) =>
                                                              vehicle.fullName!,
                                                      fieldViewBuilder: (BuildContext
                                                              context,
                                                          TextEditingController
                                                              _fieldTextEditingController,
                                                          FocusNode
                                                              fieldFocusNode,
                                                          VoidCallback
                                                              onFieldSubmitted) {
                                                        if (fullNameController
                                                            .text.isEmpty) {
                                                          fullNameController =
                                                              _fieldTextEditingController;
                                                        }
                                                        return TextField(
                                                          controller:
                                                              fullNameController,
                                                          focusNode:
                                                              fieldFocusNode,
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                          decoration:
                                                              InputDecoration(
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
                                                                            16),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
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
                                                                "Enter first name",
                                                            filled: true,
                                                            errorText: _nameValidate
                                                                ? "Please enter correct full name"
                                                                : null,
                                                            fillColor:
                                                                textfieldColor,
                                                          ),
                                                          onChanged: (text) {
                                                            if (text
                                                                .isNotEmpty) {
                                                              context
                                                                  .read<
                                                                      SearchBloc>()
                                                                  .add(SearchCustomerDetails(
                                                                      searchKeyword:
                                                                          text));
                                                            }
                                                          },
                                                        );
                                                      },
                                                      onSelected: (suggestion) {
                                                        setState(
                                                          () {
                                                            fullNameController
                                                                    .text =
                                                                suggestion
                                                                    .fullName!;

                                                            adressController
                                                                    .text =
                                                                suggestion
                                                                    .address!;

                                                            emailController
                                                                    .text =
                                                                suggestion
                                                                    .email!;

                                                            phoneNumberController
                                                                    .text =
                                                                suggestion
                                                                    .mobileNumber!;

                                                            // Set cursor position to the end of the text
                                                            fullNameController
                                                                    .selection =
                                                                TextSelection.fromPosition(
                                                                    TextPosition(
                                                                        offset: fullNameController
                                                                            .text
                                                                            .length));
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    20), // Space between the TextFields
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Address:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        adressController,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 16),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      hintText: "Enter address",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),

                                            //manufatt
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Email:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  TextField(
                                                    controller: emailController,
                                                    // focusNode: fieldFocusNode,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 16),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      hintText: "Enter email",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Phone Number:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Icon(Icons.star,
                                                          color: redColor,
                                                          size: 8)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        phoneNumberController,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    focusNode: mobileFocusNode,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 16),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      errorText: _mobileValidate
                                                          ? "The mobile Number field is reqired"
                                                          : null,
                                                      hintText: "0000000000",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),

                                            //manufatt
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Alternate Mobile Number:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _alternatePhoneNumber,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    // focusNode: fieldFocusNode,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 16),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      hintText: "0000000000",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const Expanded(
                                              child: SizedBox
                                                  .shrink(), // Empty placeholder
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Status:",
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              color: blackColor),
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField2(
                                                value: statusListController,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10.5,
                                                          horizontal: 10),
                                                  isDense: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: textfieldColor,
                                                ),
                                                items: statusList.map<
                                                    DropdownMenuItem<
                                                        String>>((value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.toString(),
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    statusListController =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const Expanded(
                                              child: SizedBox
                                                  .shrink(), // Empty placeholder
                                            ),
                                            const SizedBox(width: 20),
                                            const Expanded(
                                              child: SizedBox
                                                  .shrink(), // Empty placeholder
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),

                                  //Vehicle inventory
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title: "Vehicle Inventory:"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Kms :",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  TextField(
                                                    controller: kmsController,
                                                    // focusNode: fieldFocusNode,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 16),
                                                      isDense: true,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      hintText:
                                                          "Enter vehicle Kms",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Fuel :",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  DropdownButtonFormField2(
                                                    value: fuelController
                                                            .isNotEmpty
                                                        ? fuelController
                                                        : null,
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 11,
                                                              horizontal: 10),
                                                      isDense: true,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none),
                                                      ),
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                    items: fuelList.map<
                                                        DropdownMenuItem<
                                                            String>>((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value.toString(),
                                                        child: Text(
                                                          value,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        fuelController =
                                                            value.toString();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(child: SizedBox.shrink()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),
                                  // selected item
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title: 'Select Items:'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Checkbox(
                                                          activeColor:
                                                              blueColor,
                                                          value: valuejack[
                                                              'checked'],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              valuejack[
                                                                      'checked'] =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Jack & Tommy',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Checkbox(
                                                          activeColor:
                                                              blueColor,
                                                          value: valuetool[
                                                              'checked'],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              valuetool[
                                                                      'checked'] =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Tool Kit',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment
                                                    //         .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: 0.7,
                                                            child: Checkbox(
                                                                activeColor:
                                                                    blueColor,
                                                                value: valuebattery[
                                                                    'checked'],
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    valuebattery[
                                                                            'checked'] =
                                                                        value!;
                                                                  });
                                                                }),
                                                          ),
                                                          const Text(
                                                            'Battery',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )
                                                        ],
                                                      ),
                                                      if (valuebattery[
                                                              'checked'] ==
                                                          true)
                                                        Flexible(
                                                          // fit: FlexFit.tight,
                                                          child:
                                                              // Column(
                                                              //   crossAxisAlignment:
                                                              //       CrossAxisAlignment
                                                              //           .start,
                                                              //   children: [
                                                              SizedBox(
                                                            width: 200,
                                                            child: TextField(
                                                                controller: TextEditingController(
                                                                    text: batteryCompanyController
                                                                            .isNotEmpty
                                                                        ? batteryCompanyController
                                                                        : ''),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          6,
                                                                      horizontal:
                                                                          6),
                                                                  isDense: true,
                                                                  hintText:
                                                                      "Enter Battery name",
                                                                  hintStyle: const TextStyle(
                                                                      color:
                                                                          hintTextColor,
                                                                      fontFamily:
                                                                          'Mulish',
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      lightGreyColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      width: 0,
                                                                      style: BorderStyle
                                                                          .none,
                                                                    ),
                                                                  ),
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    valuebattery[
                                                                            'value'] =
                                                                        value;
                                                                    batteryCompanyController =
                                                                        value;
                                                                  });
                                                                }),
                                                          ),
                                                          //   ],
                                                          // ),
                                                        )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Checkbox(
                                                            activeColor:
                                                                blueColor,
                                                            value: valuelh[
                                                                'checked'],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                valuelh['checked'] =
                                                                    value!;
                                                              });
                                                            }),
                                                      ),
                                                      const Text(
                                                        'Mirror LH',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: 0.7,
                                                            child: Checkbox(
                                                                activeColor:
                                                                    blueColor,
                                                                value: valueMudFlap[
                                                                    'checked'],
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    valueMudFlap[
                                                                            'checked'] =
                                                                        value!;
                                                                  });
                                                                }),
                                                          ),
                                                          const Text(
                                                            'Mud Flap',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )
                                                        ],
                                                      ),
                                                      if (valueMudFlap[
                                                              'checked'] ==
                                                          true)
                                                        Flexible(
                                                          // fit: FlexFit.tight,
                                                          child: SizedBox(
                                                            width: 140,
                                                            child: TextField(
                                                              controller:
                                                                  mudFlapController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            10),
                                                                isDense: true,
                                                                filled: true,
                                                                fillColor:
                                                                    lightGreyColor,
                                                                hintText:
                                                                    "Enter count",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 0,
                                                                    style:
                                                                        BorderStyle
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                valueMudFlap[
                                                                        'value'] =
                                                                    value;
                                                                mudFlapController
                                                                        .text =
                                                                    value;
                                                                mudFlapController
                                                                        .value =
                                                                    mudFlapController
                                                                        .value
                                                                        .copyWith(
                                                                  text: value,
                                                                  selection: TextSelection
                                                                      .collapsed(
                                                                          offset:
                                                                              value.length),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Checkbox(
                                                            activeColor:
                                                                blueColor,
                                                            value: valuestep[
                                                                'checked'],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                valuestep[
                                                                        'checked'] =
                                                                    value!;
                                                              });
                                                            }),
                                                      ),
                                                      const Text(
                                                        'Stepney',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Checkbox(
                                                            value: valuetap[
                                                                'checked'],
                                                            activeColor:
                                                                blueColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                valuetap[
                                                                        'checked'] =
                                                                    value!;
                                                              });
                                                            }),
                                                      ),
                                                      const Text(
                                                        'Tape',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Checkbox(
                                                            value: valuerh[
                                                                'checked'],
                                                            activeColor:
                                                                blueColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                valuerh['checked'] =
                                                                    value!;
                                                              });
                                                            }),
                                                      ),
                                                      const Text(
                                                        'Mirror RH',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: 0.7,
                                                            child: Checkbox(
                                                                value: valuemat[
                                                                    'checked'],
                                                                activeColor:
                                                                    blueColor,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    valuemat[
                                                                            'checked'] =
                                                                        value!;
                                                                    if (!value) {
                                                                      matevalueController
                                                                          .text = "";
                                                                      valuemat[
                                                                          'value'] = "";
                                                                    }
                                                                  });
                                                                }),
                                                          ),
                                                          const Text(
                                                            'Mats',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )
                                                        ],
                                                      ),
                                                      if (valuemat['checked'] ==
                                                          true)
                                                        Flexible(
                                                          // fit: FlexFit.tight,
                                                          child: SizedBox(
                                                            width: 140,
                                                            child: TextField(
                                                              controller:
                                                                  matevalueController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            10),
                                                                isDense: true,
                                                                filled: true,
                                                                fillColor:
                                                                    lightGreyColor,
                                                                hintText:
                                                                    "Enter count",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 0,
                                                                    style:
                                                                        BorderStyle
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                valuemat[
                                                                        'value'] =
                                                                    value;
                                                                matevalueController
                                                                        .text =
                                                                    value;
                                                                matevalueController
                                                                        .value =
                                                                    matevalueController
                                                                        .value
                                                                        .copyWith(
                                                                  text: value,
                                                                  selection: TextSelection
                                                                      .collapsed(
                                                                          offset:
                                                                              value.length),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  /*
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Checkbox(
                                                              activeColor:
                                                                  blueColor,
                                                              value:
                                                                  valueWheelcap[
                                                                      'checked'],
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  valueWheelcap[
                                                                          'checked'] =
                                                                      value!;
                                                                });
                                                              }),
                                                          const Text('Wheelcap')
                                                        ],
                                                      ),
                                                      if (valueWheelcap[
                                                              'checked'] ==
                                                          true)
                                                        Flexible(
                                                          child: TextFormField(
                                                            controller:
                                                                _wheelcapController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          10),
                                                              isDense: true,
                                                              filled: true,
                                                              fillColor:
                                                                  lightGreyColor,
                                                              hintText:
                                                                  "Enter count",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  width: 0,
                                                                  style:
                                                                      BorderStyle
                                                                          .none,
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                valueWheelcap[
                                                                        'value'] =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                        )
                                                    ],
                                                  )
                                                  */
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),
                                  // customer complaints
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18, top: 5),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title:
                                                'Customer Complaints/ Tasks To Do:'),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 40,
                                                child: BlocBuilder<SearchBloc,
                                                        SearchState>(
                                                    builder: (context, state) {
                                                  return Autocomplete<
                                                      CustomerComplaintModel>(
                                                    optionsBuilder:
                                                        (TextEditingValue
                                                            textEditingValue) {
                                                      if (textEditingValue
                                                          .text.isEmpty) {
                                                        return [];
                                                      }
                                                      return state
                                                          .customerComplaintList!
                                                          .where((element) => element
                                                              .customerComplaint!
                                                              .toLowerCase()
                                                              .contains(
                                                                  textEditingValue
                                                                      .text
                                                                      .toLowerCase()));
                                                    },
                                                    displayStringForOption:
                                                        (complaints) => complaints
                                                            .customerComplaint!,
                                                    fieldViewBuilder: (BuildContext
                                                            context,
                                                        TextEditingController
                                                            fieldTextEditingController,
                                                        FocusNode
                                                            fieldFocusNode,
                                                        VoidCallback
                                                            onFieldSubmitted) {
                                                      taskController =
                                                          fieldTextEditingController;
                                                      return TextField(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center, // Ensures text is vertically centered
                                                        keyboardType:
                                                            TextInputType.text,
                                                        focusNode:
                                                            fieldFocusNode,
                                                        controller:
                                                            fieldTextEditingController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffix:
                                                              (showUpdateButton ==
                                                                      false)
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            100,
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _task = taskController.text.isEmpty;
                                                                            });
                                                                            var checkTaskAvailable = tasksList.where((element) =>
                                                                                element['task'] ==
                                                                                taskController.text);
                                                                            if (checkTaskAvailable.isEmpty) {
                                                                              addTask();
                                                                            } else {
                                                                              taskController.clear();
                                                                              Fluttertoast.showToast(msg: "This task already exists");
                                                                            }
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                taskbuttonColor,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Text(
                                                                              'Add Task',
                                                                              style: TextStyle(fontSize: 12, color: whiteColor),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            140,
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed: () =>
                                                                              updateTask(),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                primaryColor,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Text('Update Task'),
                                                                        ),
                                                                      ),
                                                                    ),

                                                          hintStyle:
                                                              const TextStyle(
                                                            color:
                                                                hintTextColor,
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 14,
                                                          ),
                                                          // contentPadding:
                                                          //     EdgeInsets.symmetric(
                                                          //         vertical: 8,
                                                          //         horizontal: 16),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter task",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                          errorText: _task
                                                              ? "Enter Complaints or tasks to do"
                                                              : null,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                        ),
                                                        onChanged: (text) {
                                                          if (text.isNotEmpty) {
                                                            context
                                                                .read<
                                                                    SearchBloc>()
                                                                .add(SearchCustomerComplaint(
                                                                    searchKeyword:
                                                                        text));
                                                          }
                                                        },
                                                      );
                                                    },
                                                    onSelected: (suggestion) {
                                                      taskController.text =
                                                          suggestion
                                                              .customerComplaint!;
                                                      setState(() {
                                                        _task = taskController
                                                            .text.isEmpty;
                                                      });
                                                      var checkTaskAvailable =
                                                          tasksList.where(
                                                              (element) =>
                                                                  element[
                                                                      'task'] ==
                                                                  suggestion
                                                                      .customerComplaint);
                                                      if (checkTaskAvailable
                                                          .isEmpty) {
                                                        addTask();
                                                      } else {
                                                        taskController.clear();
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "This task is already exist");
                                                      }
                                                    },
                                                  );
                                                })),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Column(
                                          children: [
                                            for (int i = 0;
                                                i < tasksList.length;
                                                i++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15, bottom: 5),
                                                // child: Container(
                                                //   height: 40,
                                                //   decoration: BoxDecoration(
                                                //     border: Border.all(
                                                //         color: Colors
                                                //             .grey.shade300),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             5),
                                                //   ),
                                                //   child: Center(
                                                child: Ink(
                                                  color: complentboxColor,
                                                  child: ListTile(
                                                    selectedColor:
                                                        textfieldColor,
                                                    selectedTileColor:
                                                        textfieldColor,
                                                    focusColor: textfieldColor,
                                                    visualDensity:
                                                        VisualDensity(
                                                            vertical: -4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: BorderSide(
                                                          color:
                                                              complentborderColor),
                                                    ),
                                                    leading: Checkbox(
                                                      activeColor: blueColor,
                                                      value: tasksList[i]
                                                              ['status'] ==
                                                          1,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          tasksList[i]
                                                                  ['status'] =
                                                              value! ? 1 : 0;
                                                        });
                                                      },
                                                    ),
                                                    title: Text(
                                                        tasksList[i]['task']),
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            editTask(
                                                                i,
                                                                tasksList[i]
                                                                    ['task']);
                                                          },
                                                          child: const Text(
                                                            '',
                                                            style: TextStyle(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),

                                                        GestureDetector(
                                                          onTap: () {
                                                            deleteTask(
                                                                i,
                                                                tasksList[i]
                                                                    ['task']);
                                                            taskController
                                                                .clear();
                                                          },
                                                          child: const Text(
                                                            '',
                                                            style: TextStyle(
                                                                color: redColor,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        // IconButton(
                                                        //   icon: const Icon(
                                                        //       Icons.delete,
                                                        //       size: 18),
                                                        //   onPressed: () {
                                                        //     deleteTask(
                                                        //         i,
                                                        //         tasksList[i]
                                                        //             ['task']);
                                                        //     _taskController
                                                        //         .clear();
                                                        //   },
                                                        //   color: redColor,
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // ),
                                                // ),
                                              ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),

                                  //Assign Mechanics

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title: 'Assign Mechanics :'),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        BlocBuilder<SearchMechanicBloc,
                                                SearchMechanicState>(
                                            builder: (context, state) {
                                          return Autocomplete<MechanicModel>(
                                            optionsBuilder: (TextEditingValue
                                                textEditingValue) {
                                              if (textEditingValue
                                                  .text.isEmpty) {
                                                return [];
                                              }
                                              return state.mechanicList!.where(
                                                  (element) => element
                                                      .mechanicName!
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase()));
                                            },
                                            displayStringForOption:
                                                (mechanic) =>
                                                    mechanic.mechanicName!,
                                            fieldViewBuilder: (BuildContext
                                                    context,
                                                TextEditingController
                                                    fieldTextEditingController,
                                                FocusNode fieldFocusNode,
                                                VoidCallback onFieldSubmitted) {
                                              assignMechanicController =
                                                  fieldTextEditingController;
                                              return TextField(
                                                controller:
                                                    fieldTextEditingController,
                                                focusNode: fieldFocusNode,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  hintText: 'Add Mechanic',
                                                  hintStyle: const TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily: 'Mulish',
                                                      fontSize: 16),
                                                  // contentPadding:
                                                  //     const EdgeInsets
                                                  //         .symmetric(
                                                  //         vertical: 12,
                                                  //         horizontal: 8),
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: lightGreyColor,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  if (text.isNotEmpty) {
                                                    context
                                                        .read<
                                                            SearchMechanicBloc>()
                                                        .add(SearchMechanic(
                                                            searchKeyword:
                                                                text));
                                                  }
                                                },
                                              );
                                            },
                                            onSelected: (suggestion) {
                                              var checkMachanicAvailable =
                                                  assignMechanicList.where(
                                                      (element) =>
                                                          element['key'] ==
                                                          suggestion.id);
                                              if (checkMachanicAvailable
                                                  .isEmpty) {
                                                setState(() {
                                                  assignMechanicList.add({
                                                    "key": suggestion.id,
                                                    "value": suggestion
                                                        .mechanicName
                                                        .toString()
                                                  });
                                                });
                                              }
                                              assignMechanicController.clear();
                                            },
                                          );
                                        }),
                                        const SizedBox(height: 10),
                                        (assignMechanicList.isNotEmpty)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.start,
                                                    children: [
                                                      for (var mechanic
                                                          in assignMechanicList) ...[
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  backgroundColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 3),
                                                          child: Wrap(
                                                              crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .center,
                                                              children: [
                                                                Text(mechanic[
                                                                    'value']),
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        assignMechanicList.removeWhere((element) =>
                                                                            element['key'] ==
                                                                            mechanic['key']);
                                                                      });
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      clearIcon,
                                                                      color:
                                                                          redColor,
                                                                      size: 15,
                                                                    ))
                                                              ]),
                                                        )
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      children: [
                                        const FormFieldTitle(
                                            title: "Vehicle Images:"),
                                        SelectImageRow(
                                          title: 'Front',
                                          takeImage: takeImage,
                                          imageFile: frontImage,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Right hand side
                                        SelectImageRow(
                                          title: "Right Hand Side",
                                          takeImage: takeImage,
                                          imageFile: rightHandSideImage,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // left hand side
                                        SelectImageRow(
                                          title: "Left Hand Side",
                                          takeImage: takeImage,
                                          imageFile: leftHandSideImage,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Rear Image
                                        SelectImageRow(
                                          title: "Rear",
                                          takeImage: takeImage,
                                          imageFile: rearImage,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Dashboard image
                                        SelectImageRow(
                                          title: "Dashboard",
                                          takeImage: takeImage,
                                          imageFile: dashboardImage,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Engine Image
                                        SelectImageRow(
                                          title: "Engine",
                                          takeImage: takeImage,
                                          imageFile: engineImage,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const FormFieldTitle(
                                            title: "Select Image:"),
                                        (appConfig.additonalImageCount != 0)
                                            ? Column(
                                                children: [
                                                  for (int i = 1;
                                                      i <=
                                                          appConfig
                                                              .additonalImageCount;
                                                      i++) ...[
                                                    if (i <= 4)
                                                      SelectImageRow(
                                                        title:
                                                            "Select Image $i :",
                                                        takeImage: takeImage,
                                                        imageFile:
                                                            getAdditionalImageFile(
                                                                    "image$i") ??
                                                                XFile(''),
                                                      ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                        (appConfig.additonalImageCount < 4)
                                            ?
                                            /* Align(
                                                alignment: Alignment.topLeft,
                                                child: ElevatedButton.icon(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              successDarkColor)),
                                                  icon: const Icon(
                                                    additonalIcon,
                                                  ),
                                                  onPressed: () {
                                                    appConfig
                                                        .additonalImageCount++;
                                                    setState(() {});
                                                  },
                                                  label: const Text(
                                                      'Additional Images'),
                                                ),
                                              )
                                              */

                                            Column(
                                                children: [
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  SizedBox(
                                                      height: 37,
                                                      width: 165,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            appConfig
                                                                .additonalImageCount++;
                                                            setState(() {});
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                taskbuttonColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Additional Images',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'meck',
                                                              fontSize: 13,
                                                              color: whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ))),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, top: 15, bottom: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 37,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print('saveee');
                                        setState(() {
                                          _validate = vehicleNumberController
                                              .text.isEmpty;
                                          _mobileValidate =
                                              phoneNumberController
                                                  .text.isEmpty;
                                          _nameValidate =
                                              fullNameController.text.isEmpty;
                                          vehiclefFocusNode.requestFocus();
                                        });

                                        if (_formKey.currentState!.validate()) {
                                          Map<String, dynamic> formData = {
                                             "id": "",
                                            "job_sheet_id": "001-001",
                                            "full_name": fullNameController.text
                                                .toString(),
                                            "address": adressController.text
                                                .toString(),
                                            "email":
                                                emailController.text.toString(),
                                            "mobile_number":
                                                phoneNumberController.text
                                                    .toString(),
                                            "alternet_number":
                                                _alternatePhoneNumber.text,
                                            "vehicle_number":
                                                vehicleNumberController.text
                                                    .toString(),
                                            "vehicle_name":
                                                vehicleNameController.text
                                                    .toString(),
                                            "manufacturers":
                                                (manufacturerController == "")
                                                    ? ""
                                                    : manufacturerController
                                                        .toString(),
                                            "status":
                                                (statusListController == "")
                                                    ? "New Job"
                                                    : statusListController
                                                        .toString(),
                                            "kms":
                                                kmsController.text.toString(),
                                            "fuel": (fuelController == "")
                                                ? ""
                                                : fuelController.toString(),
                                            "items":
                                                "[${jsonEncode(valuejack)}, ${jsonEncode(valuestep)},${jsonEncode(valuetool)},${jsonEncode(valuetap)}, ${jsonEncode(valuebattery)},${jsonEncode(valuerh)},${jsonEncode(valuelh)},${jsonEncode(valuemat)},${jsonEncode(valueMudFlap)}]",
                                            "customer_complaints":
                                                jsonEncode(tasksList),
                                            "task_to_do": "",
                                            "vehicle_front":
                                                (frontImage.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_right_hand":
                                                (rightHandSideImage
                                                        .path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_left_hand":
                                                (leftHandSideImage
                                                        .path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_rear":
                                                (rearImage.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_dashboard":
                                                (dashboardImage.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_dickey":
                                                (engineImage.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_image1":
                                                (imageOne.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_image2":
                                                (imageTwo.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_image3":
                                                (imageThree.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "vehicle_image4":
                                                (imageFour.path.isNotEmpty)
                                                    ? "1"
                                                    : "0",
                                            "assign_mechanics":
                                                jsonEncode(assignMechanicList),
                                          };
                                          context.read<JobSheetBloc>().add(
                                              AddJobSheet(
                                                  formData: formData,
                                                  frontImage: frontImage,
                                                  rightHandSideImage:
                                                      rightHandSideImage,
                                                  leftHandSideImage:
                                                      leftHandSideImage,
                                                  rearImage: rearImage,
                                                  dashboardImage:
                                                      dashboardImage,
                                                  engineImage: engineImage,
                                                  image1: imageOne,
                                                  image2: imageTwo,
                                                  image3: imageThree,
                                                  image4: imageFour));

                                          setState(() {
                                            appConfig.toastCount = 0;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: const Text(
                                        'SAVE',
                                        style: TextStyle(
                                          fontFamily: 'meck',
                                          fontSize: 14,
                                          color: blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Clear',
                                        style: TextStyle(color: blueColor),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )))));
  }

  addTask() {
    setState(() {
      dynamic newTask = {
        'task': taskController.text,
        'status': 0,
      };
      if (newTask['task'].isNotEmpty) {
        tasksList.add(newTask);
        taskController.clear();
      }
    });
  }

  void editTask(int index, String task) {
    taskController.text = task;
    taskController.selection = TextSelection.fromPosition(
      TextPosition(offset: taskController.text.length),
    );
    showUpdateButton = true;
    updateIndex = index;
    setState(() {});
  }

  void updateTask() {
    if (taskController.text.isNotEmpty) {
      tasksList[updateIndex] = {
        'status': tasksList[updateIndex]['status'],
        'task': taskController.text
      };
      taskController.clear();
    } else {
      deleteTask(updateIndex, taskController.text);
    }
    setState(() {
      showUpdateButton = false;
    });
  }

  void deleteTask(int index, String task) {
    setState(() {
      tasksList.removeWhere((item) => item['task'] == task);
      if (index == updateIndex) {
        showUpdateButton = false;
        updateIndex = -1;
        taskController.clear();
      }
    });
  }

  Future<void> takeImage(XFile? imageType) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      setState(() {
        if (imageType == frontImage) {
          frontImage = pickedFile;
        } else if (imageType == rightHandSideImage) {
          rightHandSideImage = pickedFile;
        } else if (imageType == leftHandSideImage) {
          leftHandSideImage = pickedFile;
        } else if (imageType == rearImage) {
          rearImage = pickedFile;
        } else if (imageType == dashboardImage) {
          dashboardImage = pickedFile;
        } else if (imageType == engineImage) {
          engineImage = pickedFile;
        } else if (imageType == imageOne) {
          imageOne = pickedFile;
        } else if (imageType == imageTwo) {
          imageTwo = pickedFile;
        } else if (imageType == imageThree) {
          imageThree = pickedFile;
        } else if (imageType == imageFour) {
          imageFour = pickedFile;
        }
      });
    }
  }

  XFile? getAdditionalImageFile(String fileType) {
    XFile? selectedFile;
    if (fileType == "image1") {
      selectedFile = imageOne;
    } else if (fileType == "image2") {
      selectedFile = imageTwo;
    } else if (fileType == "image3") {
      selectedFile = imageThree;
    } else if (fileType == "image4") {
      selectedFile = imageFour;
    }
    return selectedFile;
  }
}
