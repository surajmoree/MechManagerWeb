import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

class EditVehicleBox extends StatefulWidget {
  int? id;
  String? vehicleNumber;
  String? vehicleName;
  String? manufacturers;
  EditVehicleBox(
      {super.key,
      this.id,
      this.manufacturers,
      this.vehicleName,
      this.vehicleNumber});

  @override
  State<EditVehicleBox> createState() => _EditVehicleBoxState();
}

class _EditVehicleBoxState extends State<EditVehicleBox> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  String manufacturerController = '';
  bool validate = false;
  int? flagId;
  @override
  void dispose() {
    vehicleNameController.dispose();
    vehicleNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flagId = widget.id;
    vehicleNameController.text = widget.vehicleName.toString();
    vehicleNumberController.text = widget.vehicleNumber.toString();
    manufacturerController = (widget.manufacturers.toString().isEmpty)
        ? ''
        : widget.manufacturers.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.updated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Vehicle details updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<JobSheetDetailsBloc>().add(GetEstimateDetailsByEstimate(
              id: state.estimateModel!.estimateId.toString()));
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 350,
          width: 450,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Edit Vehicle Details',
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
                      const SizedBox(
                        height: 6,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Vehicle Number:",
                            style: TextStyle(fontSize: 12.5, color: blackColor),
                          ),
                          Icon(Icons.star, color: redColor, size: 8)
                        ],
                      ),
                      TextField(
                        controller: vehicleNumberController,
                        // focusNode: fieldFocusNode,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: hintTextColor,
                                fontFamily: 'Mulish',
                                fontSize: 14),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            errorText: validate
                                ? "The Vehicle Number field is reqired"
                                : null,
                            isDense: true,
                            hintText: "Enter vehicle number",
                            filled: true,
                            fillColor: lightGreyColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Vehicle Name:',
                        style: TextStyle(fontSize: 12.5, color: blackColor),
                      ),
                      TextField(
                        controller: vehicleNameController,
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
                          filled: true,
                          fillColor: textfieldColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Manufacturers:',
                        style: TextStyle(fontSize: 12.5, color: blackColor),
                      ),
                      DropdownButtonFormField2(
                        value: manufacturerController.isNotEmpty
                            ? manufacturerController
                            : null,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 10),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: textfieldColor,
                        ),
                        hint: const Text(""),

                        // dropdownMaxHeight: 450,
                        isExpanded: true,
                        items: manufacturerCompaniesList
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 13,
                                // wordSpacing: 3,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            manufacturerController = value!.toString();
                          });
                        },
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
                              validate = vehicleNumberController.text.isEmpty;
                            });
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> formData = {
                                "vehicle_number":
                                    vehicleNumberController.text.toString(),
                                "vehicle_name":
                                    vehicleNameController.text.toString(),
                                "manufacturers":
                                    manufacturerController.toString(),
                                "filter": "Estimate",
                                "id_flag": flagId
                              };
                              context.read<JobSheetDetailsBloc>().add(
                                  UpdateVehicle(
                                      id: state.estimateModel!.vehicleId
                                          .toString(),
                                      formData: formData));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: savebuttoncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
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
