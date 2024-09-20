import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

class EditCustomerByEstimate extends StatefulWidget {
  int? id;
  String? fullname;
  String? address;
  String? email;
  String? phoneno;
  EditCustomerByEstimate(
      {super.key,
      this.id,
      this.address,
      this.email,
      this.fullname,
      this.phoneno});

  @override
  State<EditCustomerByEstimate> createState() => _EditCustomerByEstimateState();
}

class _EditCustomerByEstimateState extends State<EditCustomerByEstimate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool nameValidate = false;
  bool mobileValidate = false;
  int? flagId;
  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  assignValues(JobSheetDetailsState state) {
    setState(() {
      // _fullNameController.text = state.estimateModel!.fullName.toString();
      // _addressController.text = state.estimateModel!.address.toString();
      // _emailController.text = state.estimateModel!.email.toString();
      // _phoneController.text = state.estimateModel!.mobileNumber.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flagId = widget.id;
    _fullNameController.text = widget.fullname.toString();
    _addressController.text = widget.address.toString();
    _emailController.text = widget.email.toString();
    _phoneController.text = widget.phoneno.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.updated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Customer details updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<JobSheetDetailsBloc>().add(GetEstimateDetailsByEstimate(
              id: state.estimateModel!.estimateId.toString()));
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 430,
          width: 450,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Edit Customer Details',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(clearIcon))
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "Full Name :",
                            style: TextStyle(fontSize: 12.5, color: blackColor),
                          ),
                          Icon(Icons.star, color: redColor, size: 8)
                        ],
                      ),
                      TextField(
                        controller: _fullNameController,
                        // focusNode: fieldFocusNode,
                        style: TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          isDense: true,
                          hintText: "Enter first name",
                          filled: true,
                          fillColor: textfieldColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Address:",
                        style: TextStyle(fontSize: 12.5, color: blackColor),
                      ),
                      TextField(
                        controller: _addressController,
                        // focusNode: fieldFocusNode,
                        style: TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          isDense: true,
                          hintText: "Enter address",
                          filled: true,
                          fillColor: textfieldColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Email:",
                        style: TextStyle(fontSize: 12.5, color: blackColor),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TextField(
                        controller: _emailController,
                        // focusNode: fieldFocusNode,
                        style: TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          isDense: true,
                          hintText: "Enter email",
                          filled: true,
                          fillColor: textfieldColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Phone Number:",
                            style: TextStyle(fontSize: 12.5, color: blackColor),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Icon(Icons.star, color: redColor, size: 8)
                        ],
                      ),
                      TextField(
                        controller: _phoneController,
                        style: TextStyle(fontSize: 13),
                        // focusNode: fieldFocusNode,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          isDense: true,
                          hintText: "0000000000",
                          filled: true,
                          fillColor: textfieldColor,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 207, 207, 207),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                  
                                      GestureDetector(
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: blueColor),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      height: 37,
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                              setState(() {
                                nameValidate = _fullNameController.text.isEmpty;
                                mobileValidate = _phoneController.text.isEmpty;
                              });
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> formData = {
                                  "full_name":
                                      _fullNameController.text.toString(),
                                  "address": _addressController.text.toString(),
                                  "email": _emailController.text.toString(),
                                  "mobile_number":
                                      _phoneController.text.toString(),
                                  "filter": "Estimate",
                                  "id_flag": flagId
                                };
                  
                                context.read<JobSheetDetailsBloc>().add(
                                    UpdateCustomer(
                                        id: state.estimateModel!.customerId
                                            .toString(),
                                        formData: formData));
                              }
                            });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: savebuttoncolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                            fontFamily: 'meck',
                                            fontSize: 14,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                   
                                   
                                  ],
                                ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
