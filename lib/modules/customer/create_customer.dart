import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/skeletone/form_field_title.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/customer/customer_listening.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({super.key});

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController alternateNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _nameValidate = false;
  bool _mobileValidate = false;

  final ValueNotifier<String> activeRouteNotifier = ValueNotifier<String>('/');
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetBloc, JobSheetState>(
      listener: (context, state) {
        if (state.status == jobSheetStatus.customerSuccess) {
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "customer added successfully",
            backgroundColor: successDarkColor,
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CustomerPage()));
        }
      },
      builder: (context, state) {
        return BaseLayout(
            key: _scaffoldKey,
            title: 'MechManager Admin',
            closeDrawer: _toggleDrawer,
            isDrawerOpen: _isDrawerOpen,
            activeRouteNotifier: activeRouteNotifier,
            body: Padding(
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
                            'Customer Create',
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, top: 15, bottom: 20),
                                child: Column(
                                  children: [
                                    const FormFieldTitle(
                                        title: "Customers Details:"),
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
                                                    "Full Name:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  Icon(Icons.star,
                                                      color: redColor, size: 8)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              TextField(
                                                controller: fullNameController,
                                                // focusNode: _validate
                                                //     ? vehiclefFocusNode
                                                //     : fieldFocusNode,

                                                style: TextStyle(fontSize: 13),
                                                // focusNode: labourFocusNode,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily: 'meck',
                                                      fontSize: 12),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                  errorText: _nameValidate
                                                      ? "The Full name field is required"
                                                      : null,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  isDense: true,
                                                  hintText: "Enter name",
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
                                                style: TextStyle(fontSize: 13),
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
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  isDense: true,
                                                  hintText: "Enter Email",
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
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Mobile Number:",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: blackColor),
                                                  ),
                                                  Icon(Icons.star,
                                                      color: redColor, size: 8)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              TextField(
                                                controller:
                                                    phoneNumberController,
                                                // focusNode: _validate
                                                //     ? vehiclefFocusNode
                                                //     : fieldFocusNode,

                                                style: TextStyle(fontSize: 13),
                                                // focusNode: labourFocusNode,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily: 'meck',
                                                      fontSize: 12),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                  errorText: _mobileValidate
                                                      ? "The Mobile number field is required"
                                                      : null,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  isDense: true,
                                                  hintText:
                                                      "Enter Mobile Number",
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
                                        // Space between the TextFields
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Alternate Number:",
                                                style: TextStyle(
                                                    fontSize: 12.5,
                                                    color: blackColor),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              TextField(
                                                controller:
                                                    alternateNumberController,
                                                style: TextStyle(fontSize: 13),
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
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  isDense: true,
                                                  hintText:
                                                      "Enter alternate number",
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
                                              Text(
                                                "Address:",
                                                style: TextStyle(
                                                    fontSize: 12.5,
                                                    color: blackColor),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              TextField(
                                                controller: addressController,
                                                style: TextStyle(fontSize: 13),
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily: 'Mulish',
                                                      fontSize: 14),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  isDense: true,
                                                  hintText: "Enter Address",
                                                  filled: true,
                                                  // errorText: _nameValidate
                                                  //     ? "The customer name field is required"
                                                  //     : null,
                                                  fillColor: textfieldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),

                                        Expanded(child: SizedBox.shrink())
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, bottom: 15),
                                child: SizedBox(
                                  height: 37,
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _nameValidate =
                                            fullNameController.text.isEmpty;
                                        _mobileValidate =
                                            phoneNumberController.text.isEmpty;
                                      });
                                      if (_formKey.currentState!.validate() &&
                                          !_nameValidate &&
                                          !_mobileValidate) {
                                        Map<String, dynamic> formData = {
                                          "id": "",
                                          "full_name": fullNameController.text
                                              .toString(),
                                          "email":
                                              emailController.text.toString(),
                                          "mobile_number": phoneNumberController
                                              .text
                                              .toString(),
                                          "alternet_number":
                                              alternateNumberController.text
                                                  .toString(),
                                          "address":
                                              addressController.text.toString(),
                                        };
                                        context.read<JobSheetBloc>().add(
                                            CreateCustomerEvent(
                                                formData: formData));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
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
                        )
                      ],
                    ),
                  )),
            ));
      },
    );
  }
}
