import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/profile_image.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

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
        if (state.status == JobSheetDetailsStatus.success) {
          assignValues(state);
        }
      },
      builder: (context, state) {
        return BaseLayout(
          title: 'MechManager Admin',
          closeDrawer: _toggleDrawer,
          isDrawerOpen: _isDrawerOpen,
          showFloatingActionButton: false,
          activeRouteNotifier: activeRouteNotifier,
          body:
              (state.status == JobSheetDetailsStatus.initial ||
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
                                    side: BorderSide(
                                        color: Colors.grey.shade300)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left side - Image upload section
                                    SizedBox(
                                      width: 250,
                                      child: ProfileImage(
                                        takeImage: takeImage,
                                        imageFile: profileImage,
                                        existedImageUrl: companylogothumb,
                                      ),
                                    ),
                                    /*
                      SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            // Image widget (replace with your own image logic)
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/logo.png'), // Replace with your image asset
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Handle image selection
                              },
                              style: ElevatedButton.styleFrom(
                                  //   primary: Colors.yellow[700], // Button color
                                  ),
                              child: Text("Select Image",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                      */

                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                                    fontSize:
                                                                        12.5,
                                                                    color:
                                                                        blackColor),
                                                              ),
                                                              Icon(Icons.star,
                                                                  color:
                                                                      redColor,
                                                                  size: 8)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          TextField(
                                                            controller:
                                                                workshopnameController,
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              // errorText: _nameValidate
                                                              //     ? "Please enter  labour name"
                                                              //     : null,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                    fontSize:
                                                                        12.5,
                                                                    color:
                                                                        blackColor),
                                                              ),
                                                              Icon(Icons.star,
                                                                  color:
                                                                      redColor,
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              // errorText: _nameValidate
                                                              //     ? "Please enter  labour name"
                                                              //     : null,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              // errorText: _nameValidate
                                                              //     ? "Please enter  labour name"
                                                              //     : null,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                            iconStyleData:
                                                                IconStyleData(
                                                                    icon: Icon(
                                                                        null),
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
                                                                borderRadius: BorderRadius
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
                                                                    fontSize:
                                                                        13,
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              // errorText: _nameValidate
                                                              //     ? "Please enter  labour name"
                                                              //     : null,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              // errorText: _nameValidate
                                                              //     ? "Please enter  labour name"
                                                              //     : null,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                                  "Enter VPA",
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
                                                                color:
                                                                    blackColor),
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
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
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
                                                        child:
                                                            SizedBox.shrink()),
                                                    SizedBox(width: 16),
                                                    Expanded(
                                                        child:
                                                            SizedBox.shrink()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Submit button
                                          SizedBox(height: 16),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18,
                                                right: 18,
                                                bottom: 15),
                                            child: SizedBox(
                                              height: 37,
                                              width: 100,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // setState(() {
                                                  //   _nameValidate =
                                                  //       labourNameController.text.isEmpty;

                                                  //   labourFocusNode.requestFocus();
                                                  // });
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
        profileImage = pickedFile;
      });
    }
  }
}
