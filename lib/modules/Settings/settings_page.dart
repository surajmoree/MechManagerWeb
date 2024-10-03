import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/profile_image.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/components/skeletone/form_field_title.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<FormState>();
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  String _userImage = "";
  TextEditingController workshopnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController vpaController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  String stateController = '';
  String createdDate = "";
  String createdTime = "";
  String deletedAt = "";
  String subscribEnd = "";
  String subscribStart = "";
  String updatedAt = "";
  String companylogothumb = "";
  int? id;
  XFile profileImage = XFile('');
  bool _validWorkshopname = false;
  bool isLoading = false;
  final FocusNode workshopFocusNode = FocusNode();
  bool _isExpandedCard = false;
  bool _passwordValid = false;
  bool _confpasswordValid = false;

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

  void _isCardExpand() {
    if (_isExpandedCard) {
      setState(() {
        _isExpandedCard = false;
      });
    } else {
      setState(() {
        _isExpandedCard = true;
      });
    }
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
    setState(() {
      workshopnameController.text = state.profilModel!.companyname.toString();
      emailController.text = state.profilModel!.email.toString();
      mobileNumberController.text = state.profilModel!.mobileNumber.toString();
      // streetAddressController.text =
      // state.profilModel!.address.toString();

      final addressMap = state.profilModel!.address;
      streetAddressController.text = addressMap!['street'].toString();
      cityController.text = addressMap['city'].toString();
      //stateController = addressMap['state'].toString();
      stateController = (addressMap['state'].toString().isEmpty)
          ? ''
          : addressMap['state'].toString();
      pincodeController.text = addressMap['pincode'].toString();
      bankNameController.text = state.profilModel!.bankName.toString();
      accountNoController.text = state.profilModel!.accountNumber.toString();
      ifscController.text = state.profilModel!.ifsc.toString();
      branchNameController.text = state.profilModel!.branchName.toString();
      vpaController.text = state.profilModel!.vpa.toString();
      currencyController.text = state.profilModel!.currency.toString();
      companylogothumb = state.profilModel!.companyLogoThumb.toString();
      // image1 = state.updateProfileModel!.image.toString();
      createdDate = state.profilModel!.createdAtDate.toString();
      createdTime = state.profilModel!.createdAtTime.toString();
      deletedAt = state.profilModel!.deletedAt.toString();
      subscribEnd = state.profilModel!.subscriptionEnd.toString();
      subscribStart = state.profilModel!.subscriptionStart.toString();
      updatedAt = state.profilModel!.updatedAt.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.updated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Profile updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<ProfileSectionBloc>().add(const FetchProfileInfo());
          Navigator.pushNamed(context, "/dashboard_page");
        } else if (state.status == JobSheetDetailsStatus.updating) {
          CenterLoader.show(context);
        }
        if (state.status == JobSheetDetailsStatus.success) {
          assignValues(state);
        }

//ProfileSectionStatus
/*
        if (state.status == ProfileSectionStatus.success) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Password change Successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          Navigator.pushNamed(context, "/dashboard_page");
        }
        */
      },
      builder: (context, state) {
        return BaseLayout(
          key: _scaffoldKey,
          title: 'MechManager Admin',
          closeDrawer: _toggleDrawer,
          isDrawerOpen: _isDrawerOpen,
          showFloatingActionButton: false,
          activeRouteNotifier: activeRouteNotifier,
          body: (state.status == JobSheetDetailsStatus.initial ||
                  state.status == JobSheetDetailsStatus.loading)
              ? const CenterLoader()
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formKey,
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
                              'Update profile',
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
                                side: BorderSide(color: Colors.grey.shade300)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side - Image upload section
                                SizedBox(
                                  width: 220,
                                  child: ProfileImage(
                                    takeImage: takeImage,
                                    imageFile: profileImage,
                                    existedImageUrl: companylogothumb,
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Workshop Name
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                          top: 15,
                                        ),
                                        child: Column(
                                          children: [
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
                                                            "Workshop Name:",
                                                            style: TextStyle(
                                                                fontSize: 12.5,
                                                                color:
                                                                    blackColor),
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
                                                            workshopnameController,
                                                        focusNode:
                                                            workshopFocusNode,

                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        //   focusNode: labourFocusNode,
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
                                                          errorText:
                                                              _validWorkshopname
                                                                  ? "The Workshop Name field is required"
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter workshop name",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Email or Username:",
                                                            style: TextStyle(
                                                                fontSize: 12.5,
                                                                color:
                                                                    blackColor),
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
                                                        readOnly: true,
                                                        controller:
                                                            emailController,
                                                        // focusNode: _validate
                                                        //     ? vehiclefFocusNode
                                                        //     : fieldFocusNode,

                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        //   focusNode: labourFocusNode,
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
                                                          // errorText: _nameValidate
                                                          //     ? "Please enter  labour name"
                                                          //     : null,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter email ",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Mobile:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            mobileNumberController,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter Mobile",
                                                          filled: true,
                                                          // errorText: _nameValidate
                                                          //     ? "The customer name field is required"
                                                          //     : null,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      // Street Address and City
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Street Address:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            streetAddressController,
                                                        // focusNode: _validate
                                                        //     ? vehiclefFocusNode
                                                        //     : fieldFocusNode,

                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        //   focusNode: labourFocusNode,
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
                                                          // errorText: _nameValidate
                                                          //     ? "Please enter  labour name"
                                                          //     : null,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter Street Address",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "City:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            cityController,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        decoration:
                                                            const InputDecoration(
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter City",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "State:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      // DropdownButton<
                                                      //     String>(
                                                      //   value: stateController
                                                      //           .isNotEmpty
                                                      //       ? stateController
                                                      //       : null,
                                                      //   isExpanded: true,

                                                      //   icon: Icon(
                                                      //     Icons
                                                      //         .arrow_drop_down,
                                                      //     color:
                                                      //         Colors.blue,
                                                      //   ),
                                                      //   items: stateList.map<
                                                      //           DropdownMenuItem<
                                                      //               String>>(
                                                      //       (value) {
                                                      //     return DropdownMenuItem<
                                                      //         String>(
                                                      //       value: value
                                                      //           .toString(),
                                                      //       child: Text(
                                                      //         value,
                                                      //         style: const TextStyle(
                                                      //             fontSize:
                                                      //                 13),
                                                      //       ),
                                                      //     );
                                                      //   }).toList(),
                                                      //   onChanged: (value) {
                                                      //     setState(() {
                                                      //       stateController =
                                                      //           value
                                                      //               .toString();
                                                      //     });
                                                      //   },
                                                      //   dropdownColor:
                                                      //       textfieldColor, // Same background color for dropdown
                                                      // )

                                                      DropdownButtonFormField2(
                                                        iconStyleData: IconStyleData(
                                                            icon: Icon(null),
                                                            iconDisabledColor:
                                                                Colors
                                                                    .transparent),
                                                        value: stateController
                                                                .isNotEmpty
                                                            ? stateController
                                                            : null,
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                            vertical: 10.5,
                                                          ),
                                                          isDense: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                        items: stateList.map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value
                                                                .toString(),
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
                                                            stateController =
                                                                value!
                                                                    .toString();
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
                                      SizedBox(height: 16),
                                      // Pincode and Mobile
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Pincode:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            pincodeController,
                                                        // focusNode: _validate
                                                        //     ? vehiclefFocusNode
                                                        //     : fieldFocusNode,

                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        //   focusNode: labourFocusNode,
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
                                                          // errorText: _nameValidate
                                                          //     ? "Please enter  labour name"
                                                          //     : null,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter Pincode",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Bank Name:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            bankNameController,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        decoration:
                                                            const InputDecoration(
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter Bank Name",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Account Number:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            accountNoController,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter Account Number",
                                                          filled: true,
                                                          // errorText: _nameValidate
                                                          //     ? "The customer name field is required"
                                                          //     : null,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      // State Dropdown
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "IFSC:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            ifscController,
                                                        // focusNode: _validate
                                                        //     ? vehiclefFocusNode
                                                        //     : fieldFocusNode,

                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        //   focusNode: labourFocusNode,
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
                                                          // errorText: _nameValidate
                                                          //     ? "Please enter  labour name"
                                                          //     : null,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter IFSC",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Branch:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            branchNameController,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        decoration:
                                                            const InputDecoration(
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText:
                                                              "Enter Branch",
                                                          filled: true,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "VPA:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            vpaController,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText: "Enter VPA",
                                                          filled: true,
                                                          // errorText: _nameValidate
                                                          //     ? "The customer name field is required"
                                                          //     : null,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Currency:",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: blackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            currencyController,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          // hintText: "Enter VPA",
                                                          filled: true,
                                                          // errorText: _nameValidate
                                                          //     ? "The customer name field is required"
                                                          //     : null,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                    child: SizedBox.shrink()),
                                                SizedBox(width: 16),
                                                Expanded(
                                                    child: SizedBox.shrink()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Submit button
                                      SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        child: SizedBox(
                                          height: 37,
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _validWorkshopname =
                                                    workshopnameController
                                                        .text.isEmpty;

                                                workshopFocusNode
                                                    .requestFocus();
                                              });
                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  !_validWorkshopname) {
                                                Map<String, String> addressMap =
                                                    {
                                                  "street":
                                                      streetAddressController
                                                          .text
                                                          .toString(),
                                                  "city": cityController.text
                                                      .toString(),
                                                  "state": stateController
                                                      .toString(),
                                                  "pincode": pincodeController
                                                      .text
                                                      .toString(),
                                                };

                                                Map<String, dynamic> formData =
                                                    {
                                                  "id": id,
                                                  "company_name":
                                                      workshopnameController
                                                          .text
                                                          .toString(),
                                                  "email": emailController.text
                                                      .toString(),
                                                  "mobile_number":
                                                      mobileNumberController
                                                          .text
                                                          .toString(),
                                                  "address":
                                                      jsonEncode(addressMap),
                                                  "bank_name":
                                                      bankNameController.text
                                                          .toString(),
                                                  "act_no": accountNoController
                                                      .text
                                                      .toString(),
                                                  "ifsc": ifscController.text
                                                      .toString(),
                                                  "brach_name":
                                                      branchNameController.text
                                                          .toString(),
                                                  "vpa": vpaController.text
                                                      .toString(),
                                                  "currency": currencyController
                                                      .text
                                                      .toString(),
                                                  "company_logo": state
                                                      .profilModel!.companyLogo,
                                                  "company_logo_thumb": state
                                                      .profilModel!
                                                      .companyLogoThumb,
                                                  //   "image1": state.updateProfileModel!.image,
                                                  "created_at_date": state
                                                      .profilModel!
                                                      .createdAtDate,
                                                  "created_at_time": state
                                                      .profilModel!
                                                      .createdAtTime,
                                                  "deleted_at": state
                                                      .profilModel!.deletedAt,
                                                  "sub_end": state.profilModel!
                                                      .subscriptionEnd,
                                                  "sub_start": state
                                                      .profilModel!
                                                      .subscriptionStart,
                                                  "updated_at": state
                                                      .profilModel!.updatedAt,
                                                };

                                                context
                                                    .read<JobSheetDetailsBloc>()
                                                    .add(UpdateProfile(
                                                      id: state.profilModel!.id
                                                          .toString(),
                                                      profileImage,
                                                      formData: formData,
                                                    ));
                                              }
                                              // if (_formKey.currentState!.validate() &&
                                              //     !_nameValidate) {
                                              //   Map<String, dynamic> formData = {
                                              //     "id": "",
                                              //     "labour_name":
                                              //         labourNameController.text.toString(),
                                              //     "task_description":
                                              //         labourDSescriptionController.text
                                              //             .toString(),
                                              //     "labour_rate":
                                              //         costController.text.toString(),
                                              //   };
                                              //   context.read<JobSheetBloc>().add(
                                              //       CreateLabourEvent(formData: formData));
                                              // }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                fontFamily: 'meck',
                                                fontSize: 14,
                                                color: blackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCardExpand();
                              });
                              print('shxjasxjn');
                            },
                            child: Card(
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
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FormFieldTitle(
                                                  title: "Change Password:"),
                                              Icon(_isExpandedCard
                                                  ? Icons.expand_less
                                                  : Icons.expand_more)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_isExpandedCard)
                                      Divider(
                                        color:
                                            Color.fromARGB(255, 207, 207, 207),
                                      ),
                                    if (_isExpandedCard)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18,
                                            right: 18,
                                            top: 15,
                                            bottom: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Password:",
                                                            style: TextStyle(
                                                                fontSize: 12.5,
                                                                color:
                                                                    blackColor),
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
                                                            passwordController,
                                                        // focusNode: mechanicFocusNode,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          hintText: "Password",
                                                          filled: true,
                                                          errorText: _passwordValid
                                                              ? "The password field is required"
                                                              : null,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Confirm Password:",
                                                            style: TextStyle(
                                                                fontSize: 12.5,
                                                                color:
                                                                    blackColor),
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
                                                            confPasswordController,
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
                                                          isDense: true,
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
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          hintText:
                                                              "Confirm Password",
                                                          filled: true,
                                                          errorText:
                                                              _confpasswordValid
                                                                  ? "The confirm password field is required"
                                                                  : null,
                                                          fillColor:
                                                              textfieldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width:
                                                        20), // Space between the TextFields
                                                Expanded(
                                                    child: SizedBox.shrink()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (_isExpandedCard)
                                      BlocConsumer<ProfileSectionBloc,
                                          ProfileSectionState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          final id =
                                              state.profileModel!.id.toString();
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18,
                                                right: 18,
                                                bottom: 15),
                                            child: SizedBox(
                                              height: 37,
                                              width: 100,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _passwordValid =
                                                        passwordController
                                                            .text.isEmpty;
                                                    _confpasswordValid =
                                                        confPasswordController
                                                            .text.isEmpty;
                                                  });
                                                  // if (_scaffoldKey.currentState!
                                                  //         .validate() &&
                                                  //     _passwordValid &&
                                                  //     _confpasswordValid) {
                                                  Map<String, dynamic>
                                                      formData = {
                                                    //  "id": "",
                                                    "password":
                                                        passwordController.text
                                                            .toString(),
                                                    "confirmPassword":
                                                        confPasswordController
                                                            .text
                                                            .toString(),
                                                  };
                                                  context
                                                      .read<
                                                          ProfileSectionBloc>()
                                                      .add(PasswordUpdate(
                                                        id: id,
                                                        formData: formData,
                                                      ));
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Password change Successfully",
                                                      backgroundColor:
                                                          successColor,
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                  context
                                                      .read<
                                                          ProfileSectionBloc>()
                                                      .add(
                                                          const FetchProfileInfo());
                                                  Navigator.pushNamed(context,
                                                      "/dashboard_page");
                                                  // }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                    fontFamily: 'meck',
                                                    fontSize: 14,
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                  ],
                                )),
                          ),

                           SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future<void> takeImage(XFile? imageType) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      setState(() {
        profileImage = XFile(pickedFile.path);
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = false;
      });
    }
  }
}
