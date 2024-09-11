import 'dart:convert';
import 'dart:io';

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
import 'package:mech_manager/models/mechanic_model.dart';
import 'package:mech_manager/models/vehicle_model.dart';
import 'package:mech_manager/modules/dashboard/dashboard_page.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_state.dart';
import 'package:mech_manager/modules/job_sheet/job_sheet_listening.dart';

class EditJobSheet extends StatefulWidget {
  const EditJobSheet({super.key});

  @override
  State<EditJobSheet> createState() => _EditJobSheetState();
}

class _EditJobSheetState extends State<EditJobSheet>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  List<dynamic> vehicalImages = [];
  List<dynamic> selectedDocsFiles = <dynamic>[];
  // FilePickerResult? allDocs;
  List<File>? selectedDocs = [];
  List<String>? imageName = <String>[];
  List<Image?> selectedImage = List.filled(6, null);
  bool? showUpdateButton = false;
  bool task = false;
  dynamic valuejack = {'name': "Jack & Tommy", 'checked': true, 'value': ""};
  dynamic valuestep = {'name': "Stepney", 'checked': true, 'value': ""};
  dynamic valuetool = {'name': "Tool Kit", 'checked': true, 'value': ""};
  dynamic valuetap = {'name': "Tape", 'checked': true, 'value': ""};
  dynamic valuebattery = {'name': "Battery", 'checked': true, 'value': ""};
  dynamic valuerh = {'name': "Mirror RH", 'checked': true, 'value': ""};
  dynamic valuelh = {'name': "Mirror LH", 'checked': true, 'value': ""};
  dynamic valuemat = {'name': "Mats", 'checked': true, 'value': ""};
  dynamic valueMudFlap = {'name': "Mud Flap", 'checked': true, 'value': ""};
  // dynamic valueWheelcap = {'name': "Wheelcap", 'checked': true, 'value': ""};
  TextEditingController _wheelcapController = TextEditingController();
  TextEditingController _alternatePhoneNumber = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _kmsController = TextEditingController();
  TextEditingController _customerComplaintController = TextEditingController();
  TextEditingController _taskToDoController = TextEditingController();
  TextEditingController _assignMechanicController = TextEditingController();
  TextEditingController _taskController = TextEditingController();
  TextEditingController _mudFlapController = TextEditingController();
  TextEditingController _matevalueController = TextEditingController();
  TextEditingController batteryNameController = TextEditingController();
  List<String> batteryBrandsWithoutDuplicates = batteryBrands.toSet().toList();

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

//   XFile? frontImage;
// XFile? rightHandSideImage;
// XFile? leftHandSideImage;
// XFile? rearImage;
// XFile? dashboardImage;
// XFile? engineImage;
// XFile? imageOne;
// XFile? imageTwo;
// XFile? imageThree;
// XFile? imageFour;

  // Existing urls
  String frontExistedImageUrl = "";
  String rightHandExistedImageUrl = "";
  String leftHandExistedImageUrl = "";
  String rearExistedImageUrl = "";
  String dashboardExistedImageUrl = "";
  String engineExistedImageUrl = "";
  String image1ExistedImageUrl = "";
  String image2ExistedImageUrl = "";
  String image3ExistedImageUrl = "";
  String image4ExistedImageUrl = "";

  // Additonal Images
  XFile imageOne = XFile("");
  XFile imageTwo = XFile("");
  XFile imageThree = XFile("");
  XFile imageFour = XFile("");

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _nameValidate = false;
  bool _mobileValidate = false;
  List<dynamic> assignMechanicList = [];
  List<dynamic> tasksList = [];

  int updateIndex = 0;
  int additonalImageThumbCount = 0;
  bool isLoading = false;
  assignValue(JobSheetDetailsState state) {
    setState(() {
      _vehicleNumberController.text =
          state.jobSheetDetails!.vehicleNumber.toString();
      _vehicleNameController.text =
          state.jobSheetDetails!.vehicleName.toString();
      manufacturerController =
          (state.jobSheetDetails!.manufacturers.toString().isEmpty)
              ? ''
              : state.jobSheetDetails!.manufacturers.toString();
      _fullNameController.text = state.jobSheetDetails!.fullName.toString();
      _adressController.text = state.jobSheetDetails!.address.toString();
      _emailController.text = state.jobSheetDetails!.email.toString();
      _phoneNumberController.text =
          state.jobSheetDetails!.mobileNumber.toString();
      _alternatePhoneNumber.text =
          state.jobSheetDetails!.alternateMobileNumber.toString();
      _kmsController.text = state.jobSheetDetails!.kms.toString();
      fuelController = (state.jobSheetDetails!.fuel.toString().isEmpty)
          ? ''
          : state.jobSheetDetails!.fuel.toString();

      valuejack = state.jobSheetDetails!.items![0];
      valuestep = state.jobSheetDetails!.items![1];
      valuetool = state.jobSheetDetails!.items![2];
      valuetap = state.jobSheetDetails!.items![3];
      valuebattery = state.jobSheetDetails!.items![4];
      valuerh = state.jobSheetDetails!.items![5];
      valuelh = state.jobSheetDetails!.items![6];
      valuemat = state.jobSheetDetails!.items![7];
      valueMudFlap = state.jobSheetDetails!.items![8];

      // valueWheelcap = state.jobSheetDetails!.items![9];

      batteryCompanyController =
          state.jobSheetDetails!.items![4]['value'].toString();
      _matevalueController.text =
          state.jobSheetDetails!.items![7]['value'].toString();
      _mudFlapController.text =
          state.jobSheetDetails!.items![8]['value'].toString();

      // _wheelcapController.text =
      //     state.jobSheetDetails!.items![9]['value'].toString();
      tasksList = state.jobSheetDetails!.customerComplaints!;

      assignMechanicList = state.jobSheetDetails!.assignMechanics!;

      frontExistedImageUrl =
          state.jobSheetDetails!.vehicleFrontThumb.toString();
      rightHandExistedImageUrl =
          state.jobSheetDetails!.vehicleRightThumb.toString();
      leftHandExistedImageUrl =
          state.jobSheetDetails!.vehicleLeftThumb.toString();
      rearExistedImageUrl = state.jobSheetDetails!.vehicleRearThumb.toString();
      dashboardExistedImageUrl =
          state.jobSheetDetails!.vehicleDashboardThumb.toString();
      engineExistedImageUrl =
          state.jobSheetDetails!.vehicleDickeyThumb.toString();
      image1ExistedImageUrl = state.jobSheetDetails!.image1Thumb.toString();
      image2ExistedImageUrl = state.jobSheetDetails!.image2Thumb.toString();
      image3ExistedImageUrl = state.jobSheetDetails!.image3Thumb.toString();
      image4ExistedImageUrl = state.jobSheetDetails!.image4Thumb.toString();

      //extra added images

      if (state.jobSheetDetails!.image1Thumb!.runtimeType != Null) {
        additonalImageThumbCount++;
      } else if (state.jobSheetDetails!.image2Thumb!.runtimeType != Null) {
        additonalImageThumbCount++;
      } else if (state.jobSheetDetails!.image3Thumb!.runtimeType != Null) {
        additonalImageThumbCount++;
      } else if (state.jobSheetDetails!.image4Thumb!.runtimeType != Null) {
        additonalImageThumbCount++;
      }
      appConfig.additonalImageCount = additonalImageThumbCount;
    });
  }

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
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
        listener: (context, state) {
      if (state.status == JobSheetDetailsStatus.jobcardUpdated) {
        CenterLoader.hide();
        Fluttertoast.showToast(
            msg: "Job card updated successfully",
            backgroundColor: successColor,
            toastLength: Toast.LENGTH_SHORT);
        Navigator.pushNamed(context, "/job_sheet_listing");
      } else if (state.status == JobSheetDetailsStatus.updating) {
        CenterLoader.show(context);
      }
      if (state.status == JobSheetDetailsStatus.success) {
        assignValue(state);
      }
    }, builder: (context, state) {
      return WillPopScope(
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
            activeRouteNotifier: activeRouteNotifier,
            title: 'MechMenager Admin',
            closeDrawer: _toggleDrawer,
            isDrawerOpen: _isDrawerOpen,
            routeWidgets: [
              GestureDetector(
                onTap: () {
                  activeRouteNotifier.value = "/dashboard_page";
                  //  Navigator.pushNamed(context, '/dashboard_page');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashboardPage()));
                },
                child: const Text(
                  "Home",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const Text(" / "),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobSheetListing()));
                },
                child: const Text(
                  "Job Card",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const Text(" / "),
              const Text(
                "Update",
                style: TextStyle(color: greyColor),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobSheetListing()));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(color: blueColor),
                    ),
                  ],
                ),
              )
            ],
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
                                                    return Autocomplete(
                                                      optionsBuilder:
                                                          (TextEditingValue
                                                              textEditingValue) {
                                                        if (textEditingValue
                                                                .text ==
                                                            '') {
                                                          return const Iterable<
                                                              VehicleModel>.empty();
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
                                                              _fieldTextEditingController,
                                                          FocusNode
                                                              fieldFocusNode,
                                                          VoidCallback
                                                              onFieldSubmitted) {
                                                        if (_vehicleNumberController
                                                            .text.isEmpty) {
                                                          _vehicleNumberController =
                                                              _fieldTextEditingController;
                                                        }

                                                        return TextField(
                                                          controller:
                                                              _vehicleNumberController,
                                                          focusNode:
                                                              fieldFocusNode,
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
                                                            }
                                                          },
                                                        );
                                                      },
                                                      onSelected: (suggestion) {
                                                        setState(() {
                                                          _vehicleNumberController
                                                                  .text =
                                                              suggestion
                                                                  .vehiclenumber!;

                                                          _vehicleNameController
                                                                  .text =
                                                              suggestion
                                                                  .vehiclename!;

                                                          _fullNameController
                                                                  .text =
                                                              suggestion
                                                                  .fullName!;

                                                          _adressController
                                                                  .text =
                                                              suggestion
                                                                  .address!;

                                                          _emailController
                                                                  .text =
                                                              suggestion.email!;

                                                          _phoneNumberController
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
                                                          _vehicleNumberController
                                                                  .selection =
                                                              TextSelection.fromPosition(
                                                                  TextPosition(
                                                                      offset: _vehicleNumberController
                                                                          .text
                                                                          .length));
                                                        });
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
                                                    "Vehical name:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _vehicleNameController,
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
                                                  TextField(
                                                    controller:
                                                        _fullNameController,
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
                                                          "Enter first name",
                                                      filled: true,
                                                      fillColor: textfieldColor,
                                                    ),
                                                  ),
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
                                                        _adressController,
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
                                                    controller:
                                                        _emailController,
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
                                                        _phoneNumberController,
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
                                                    controller: _kmsController,
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
                                                    value: fuelController,
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
                                                                  _mudFlapController,
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
                                                                _mudFlapController
                                                                        .text =
                                                                    value;
                                                                _mudFlapController
                                                                        .value =
                                                                    _mudFlapController
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
                                                                    //  if (!value) {
                                                                    //   _matevalueController
                                                                    //       .text = "";
                                                                    //   valuemat['value'] =
                                                                    //       "";
                                                                    // }
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
                                                                  _matevalueController,
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
                                                                _matevalueController
                                                                        .text =
                                                                    value;
                                                                _matevalueController
                                                                        .value =
                                                                    _matevalueController
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
                                        BlocBuilder<SearchBloc, SearchState>(
                                            builder: (context, state) {
                                          return Autocomplete<
                                              CustomerComplaintModel>(
                                            optionsBuilder: (TextEditingValue
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
                                                      .contains(textEditingValue
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
                                                FocusNode fieldFocusNode,
                                                VoidCallback onFieldSubmitted) {
                                              _taskController =
                                                  fieldTextEditingController;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                    child: TextField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center, // Ensures text is vertically centered
                                                      keyboardType:
                                                          TextInputType.text,
                                                      focusNode: fieldFocusNode,
                                                      controller:
                                                          fieldTextEditingController,
                                                      decoration:
                                                          InputDecoration(
                                                        suffix:
                                                            (showUpdateButton ==
                                                                    false)
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets
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
                                                                          setState(
                                                                              () {
                                                                            task =
                                                                                _taskController.text.isEmpty;
                                                                          });
                                                                          addTask();
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              taskbuttonColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'Add Task',
                                                                            style:
                                                                                TextStyle(fontSize: 12, color: whiteColor),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          140,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () =>
                                                                                updateTask(),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              primaryColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child: const Text(
                                                                            'Update Task'),
                                                                      ),
                                                                    ),
                                                                  ),

                                                        hintStyle:
                                                            const TextStyle(
                                                          color: hintTextColor,
                                                          fontFamily: 'Mulish',
                                                          fontSize: 14,
                                                        ),
                                                        // contentPadding:
                                                        //     EdgeInsets.symmetric(
                                                        //         vertical: 8,
                                                        //         horizontal: 16),
                                                        isDense: true,
                                                        hintText: "Enter task",
                                                        filled: true,
                                                        fillColor:
                                                            textfieldColor,
                                                        errorText: task
                                                            ? "Enter Complaints or tasks to do"
                                                            : null,
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
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            onSelected: (suggestion) {
                                              _taskController.text =
                                                  suggestion.customerComplaint!;
                                              setState(() {
                                                task = _taskController
                                                    .text.isEmpty;
                                              });
                                              var checkTaskAvailable =
                                                  tasksList.where((element) =>
                                                      element['task'] ==
                                                      suggestion
                                                          .customerComplaint);
                                              if (checkTaskAvailable.isEmpty) {
                                                addTask();
                                              } else {
                                                _taskController.clear();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "This task is allready existed");
                                              }
                                            },
                                          );
                                        }),
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
                                                          child: Text(
                                                            '',
                                                            style: TextStyle(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        // IconButton(
                                                        //   icon: const Icon(
                                                        //     Icons.edit,
                                                        //     color: blueColor,
                                                        //     size: 18,
                                                        //   ),
                                                        //   onPressed: () {
                                                        //     editTask(
                                                        //         i,
                                                        //         tasksList[i]
                                                        //             ['task']);
                                                        //   },
                                                        //   color: primaryColor,
                                                        // ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            deleteTask(
                                                                i,
                                                                tasksList[i]
                                                                    ['task']);
                                                          },
                                                          child: Text(
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
                                            SizedBox(
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
                                              _assignMechanicController =
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
                                              _assignMechanicController.clear();
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
                                          existedImageUrl: frontExistedImageUrl,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Right hand side
                                        SelectImageRow(
                                            title: "Right Hand Side",
                                            takeImage: takeImage,
                                            imageFile: rightHandSideImage,
                                            existedImageUrl:
                                                rightHandExistedImageUrl),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // left hand side
                                        SelectImageRow(
                                            title: "Left Hand Side",
                                            takeImage: takeImage,
                                            imageFile: leftHandSideImage,
                                            existedImageUrl:
                                                leftHandExistedImageUrl),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Rear Image
                                        SelectImageRow(
                                            title: "Rear",
                                            takeImage: takeImage,
                                            imageFile: rearImage,
                                            existedImageUrl:
                                                rearExistedImageUrl),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Dashboard image
                                        SelectImageRow(
                                            title: "Dashboard",
                                            takeImage: takeImage,
                                            imageFile: dashboardImage,
                                            existedImageUrl:
                                                dashboardExistedImageUrl),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // Engine Image
                                        SelectImageRow(
                                            title: "Engine",
                                            takeImage: takeImage,
                                            imageFile: engineImage,
                                            existedImageUrl:
                                                engineExistedImageUrl),
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
                                      children: [
                                        const FormFieldTitle(
                                            title: "Additional Images:"),
                                        SelectImageRow(
                                          title: "Additional Image 1 :",
                                          takeImage: takeImage,
                                          imageFile: getAdditionalImageFile(
                                                  "image1") ??
                                              XFile(''),
                                          existedImageUrl:
                                              image1ExistedImageUrl,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SelectImageRow(
                                          title: "Additional Image 2 :",
                                          takeImage: takeImage,
                                          imageFile: getAdditionalImageFile(
                                                  "image2") ??
                                              XFile(''),
                                          existedImageUrl:
                                              image2ExistedImageUrl,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SelectImageRow(
                                          title: "Additional Image 3 :",
                                          takeImage: takeImage,
                                          imageFile: getAdditionalImageFile(
                                                  "image3") ??
                                              XFile(''),
                                          existedImageUrl:
                                              image3ExistedImageUrl,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SelectImageRow(
                                          title: "Additional Image 4 :",
                                          takeImage: takeImage,
                                          imageFile: getAdditionalImageFile(
                                                  "image4") ??
                                              XFile(''),
                                          existedImageUrl:
                                              image4ExistedImageUrl,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
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
                                          _validate = _vehicleNumberController
                                              .text.isEmpty;
                                          _mobileValidate =
                                              _phoneNumberController
                                                  .text.isEmpty;
                                          _nameValidate =
                                              _fullNameController.text.isEmpty;
                                        });
                                        if (_formKey.currentState!.validate() &&
                                            !_validate &&
                                            !_nameValidate &&
                                            !_mobileValidate) {
                                          Map<String, dynamic> formData = {
                                            "address": _adressController.text
                                                .toString(),
                                            "assign_mechanics":
                                                jsonEncode(assignMechanicList),
                                            "created_at_date": state
                                                .jobSheetDetails!.createdAtDate
                                                .toString(),
                                            "created_at_time": state
                                                .jobSheetDetails!.createdAtTime
                                                .toString(),
                                            "customer_complaints":
                                                jsonEncode(tasksList),
                                            "dashbord_img": state
                                                .jobSheetDetails!.dashboardImg,
                                            "deleted_at": state
                                                .jobSheetDetails!.deletedAt,
                                            "dickey_img": state
                                                .jobSheetDetails!.dickeyImg,
                                            "email": _emailController.text,
                                            "front_img":
                                                "1714658914521-b478ib.jpg",
                                            "fuel": fuelController.toString(),
                                            "full_name": _fullNameController
                                                .text
                                                .toString(),
                                            "id": state.jobSheetDetails!.id,
                                            "image1_img": state
                                                .jobSheetDetails!.image1Img,
                                            "image1_thumb": state
                                                .jobSheetDetails!.image1Thumb,
                                            "image2_img": state
                                                .jobSheetDetails!.image2Img,
                                            "image2_thumb": state
                                                .jobSheetDetails!.image2Thumb,
                                            "image3_img": state
                                                .jobSheetDetails!.image3Img,
                                            "image3_thumb": state
                                                .jobSheetDetails!.image3Thumb,
                                            "image4_img": state
                                                .jobSheetDetails!.image4Img,
                                            "image4_thumb": state
                                                .jobSheetDetails!.image4Thumb,
                                            "items":
                                                "[${jsonEncode(valuejack)}, ${jsonEncode(valuestep)},${jsonEncode(valuetool)},${jsonEncode(valuetap)}, ${jsonEncode(valuebattery)},${jsonEncode(valuerh)},${jsonEncode(valuelh)},${jsonEncode(valuemat)},${jsonEncode(valueMudFlap)}]",
                                            "job_sheet_id":
                                                "${state.jobSheetDetails!.jobSheetId}",
                                            "kms": _kmsController.text,
                                            "left_img":
                                                state.jobSheetDetails!.leftImg,
                                            "manufacturers":
                                                manufacturerController,
                                            "status": statusListController,
                                            "mobile_number":
                                                _phoneNumberController.text,
                                            "alternet_number":
                                                _alternatePhoneNumber.text,
                                            "rear_img":
                                                state.jobSheetDetails!.rearImg,
                                            "right_img":
                                                state.jobSheetDetails!.rightImg,
                                            "updated_at": state
                                                .jobSheetDetails!.updatedAt,
                                            "vehicle_dashbord_thumb": state
                                                .jobSheetDetails!
                                                .vehicleDashboardThumb,
                                            "vehicle_dickey_thumb": state
                                                .jobSheetDetails!
                                                .vehicleDickeyThumb,
                                            "vehicle_front_thumb": state
                                                .jobSheetDetails!
                                                .vehicleFrontThumb,
                                            "vehicle_left_thumb": state
                                                .jobSheetDetails!
                                                .vehicleLeftThumb,
                                            "vehicle_name":
                                                _vehicleNameController.text,
                                            "vehicle_number":
                                                _vehicleNumberController.text,
                                            "vehicle_rear_thumb": state
                                                .jobSheetDetails!
                                                .vehicleRearThumb,
                                            "vehicle_right_thumb": state
                                                .jobSheetDetails!
                                                .vehicleRightThumb,
                                            "vehicle_dashboard_img": state
                                                .jobSheetDetails!.dashboardImg,
                                            "vehicle_dickey_img": state
                                                .jobSheetDetails!.dickeyImg,
                                            "vehicle_rear_img":
                                                state.jobSheetDetails!.rearImg,
                                            "vehicle_left_hand_img":
                                                state.jobSheetDetails!.leftImg,
                                            "vehicle_right_hand_img":
                                                state.jobSheetDetails!.rightImg,
                                            "vehicle_front_img":
                                                state.jobSheetDetails!.frontImg,
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
                                            "image1": state
                                                .jobSheetDetails!.image1Img,
                                            "image2": state
                                                .jobSheetDetails!.image2Img,
                                            "image3": state
                                                .jobSheetDetails!.image3Img,
                                            "image4":
                                                state.jobSheetDetails!.image4Img
                                          };
                                          context
                                              .read<JobSheetDetailsBloc>()
                                              .add(UpdateJobSheet(
                                                  id: state.jobSheetDetails!.id
                                                      .toString(),
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(color: blueColor),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))),
      );
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

  addTask() {
    setState(() {
      dynamic newTask = {
        'task': _taskController.text,
        'status': 0,
      };
      if (newTask['task'].isNotEmpty) {
        tasksList.add(newTask);
        _taskController.clear();
      }
    });
  }

  void editTask(int index, String task) {
    _taskController.text = task;
    _taskController.selection = TextSelection.fromPosition(
      TextPosition(offset: _taskController.text.length),
    );
    showUpdateButton = true;
    updateIndex = index;
    setState(() {});
  }

  void updateTask() {
    if (_taskController.text.isNotEmpty) {
      tasksList[updateIndex] = {
        'status': tasksList[updateIndex]['status'],
        'task': _taskController.text
      };
      _taskController.clear();
    } else {
      deleteTask(updateIndex, _taskController.text);
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
        _taskController.clear();
      }
    });
  }
}
