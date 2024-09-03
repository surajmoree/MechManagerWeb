import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/edit_jobsheet/edit_job_sheet.dart';
import 'package:mech_manager/modules/job_sheet/job_sheet_listening.dart';

class JobSheetRow extends StatefulWidget {
  final JobSheetModel? jobSheetDetail;

  const JobSheetRow({super.key, this.jobSheetDetail});
  @override
  State<JobSheetRow> createState() => _JobSheetRowState();
}

class _JobSheetRowState extends State<JobSheetRow> {
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String countryCode = '+91';
  String whatsappUrl = "";
  String selectedStatus = "";

  bool showServicingDateField = false;

  void initState() {
    super.initState();
    selectedStatus = widget.jobSheetDetail!.vehicleStatus!;
    _checkAndShowServicingDate(selectedStatus);
  }

  void _checkAndShowServicingDate(String status) {
    setState(() {
      showServicingDateField = status == "Work Completed" ||
          status == "Ready for Delivery" ||
          status == "Delivered / Closed" ||
          status == "On Hold";
    });
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.grey.shade300)),
        shadowColor: greyColor,
        color: whiteColor,
        elevation: 0,
        child: Container(
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            //  padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Wrap(
                              children: [
                                Text(
                                  widget.jobSheetDetail!.customerName
                                      .toString(),
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontFamily: 'Mulish',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditJobSheet()));
                                context.read<JobSheetDetailsBloc>().add(
                                    GetJobSheetDetails(
                                        id: widget.jobSheetDetail!.id
                                            .toString()));
                              },
                              child: Icon(
                                editIcon,
                                color: blueColor,
                                size: 20,
                              ),
                            ),
                            Icon(
                              estimateIcon,
                              color: Colors.green,
                              size: 20,
                            ),
                            // Image.asset(
                            //   'assets/icons/trash.png',
                            //   height: 15,
                            //   width: 15,
                            // ),
                            //estimateIcon
                            GestureDetector(
                              onTap: () {
                                showDeleteConfirmation(context);
                              },
                              child: Icon(
                                trashIcon,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      mailIcon,
                      color: blackColorLight,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(widget.jobSheetDetail!.customerEmail.toString())
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      call,
                      color: blackColorLight,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(widget.jobSheetDetail!.customerMobileNumber.toString())
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Created Date:",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 15, color: blackColorLight),
                          ),
                          widget.jobSheetDetail!.createdAtDate
                                  .toString()
                                  .isNotEmpty
                              ? Row(
                                  children: [
                                    Text(
                                      widget.jobSheetDetail!.createdAtDate
                                          .toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 15, color: blackColorDark),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      widget.jobSheetDetail!.createdAtTime
                                          .toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 15, color: blackColorDark),
                                    )
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const Text(
                            "Created Date:",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 15, color: blackColorLight),
                          ),
                          widget.jobSheetDetail!.vehicleName
                                  .toString()
                                  .isNotEmpty
                              ? Text(
                                  widget.jobSheetDetail!.vehicleName.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 15, color: blackColorDark))
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Status:",
                            style:
                                TextStyle(fontSize: 15, color: blackColorLight),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          statusDropDown(widget.jobSheetDetail!.vehicleStatus!),
                        ],
                      ),
                    ),
                    SizedBox(width: 60,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Vehical Number:",
                            style: TextStyle(
                              fontSize: 15,
                              color: blackColorLight,
                            ),
                          ),
                          widget.jobSheetDetail!.vehicleNumber
                                  .toString()
                                  .isNotEmpty
                              ? Text(
                                  widget.jobSheetDetail!.vehicleNumber
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: blackColorDark,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Vehical Manufacturer:",
                            style: TextStyle(
                              fontSize: 15,
                              color: blackColorLight,
                            ),
                          ),
                          widget.jobSheetDetail!.vehicleManufacturers
                                  .toString()
                                  .isNotEmpty
                              ? Text(
                                  widget.jobSheetDetail!.vehicleManufacturers
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: blackColorDark,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Mechanics:",
                            style:
                                TextStyle(fontSize: 15, color: blackColorLight),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Wrap(
                                children: [
                                  for (var mechanic in widget
                                      .jobSheetDetail!.assignMechanics!) ...[
                                    Container(
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: lightyellowColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        mechanic['value'],
                                        maxLines: 4,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: blackColorDark,
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showStatusConfirmation(
      BuildContext context, String newValue) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '''Are you sure you want to mark this job card as "${newValue}"?''',
              style: const TextStyle(color: blackColorDark, fontSize: 15),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  _updateStatus(newValue);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, foregroundColor: blackColor),
                child: const Text("Yes"),
              ),
              OutlinedButton(
                onPressed: () {
                  newValue = widget.jobSheetDetail!.vehicleStatus!;
                  context.read<JobSheetBloc>().add(
                      const FetchJobSheets(status: jobSheetStatus.success));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobSheetListing()),
                  );
                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: whiteColor,
                    side: const BorderSide(color: primaryColor, width: 1)),
                child: const Text(
                  "No",
                  style: TextStyle(color: blackColor),
                ),
              ),
            ],
          );
        });
  }

  statusDropDown(String dropdownValue) {
    return DropdownMenu<String>(
        menuHeight: 200,
        menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(lightGreyColor)),
        inputDecorationTheme: InputDecorationTheme(
          constraints: BoxConstraints.tight(
            Size.fromHeight(40),
          ),
          isDense: true,

          // contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
        ),
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        initialSelection:
            dropdownValue.isNotEmpty ? dropdownValue.toString() : "New Job",
        onSelected: (value) {
          setState(() {
            selectedStatus = value!;
            _checkAndShowServicingDate(selectedStatus);
          });
          showStatusConfirmation(context, value!);
        },
        dropdownMenuEntries: statusList.map((String status) {
          return DropdownMenuEntry(
            style: ButtonStyle(
                //backgroundColor: MaterialStateProperty.all(redColor),
                ),
            value: status,
            label: status,
          );
        }).toList());
  }

  void _updateStatus(String newValue) {
    widget.jobSheetDetail!.vehicleStatus = newValue;
    Map<String, dynamic> formdata = {
      "status": widget.jobSheetDetail!.vehicleStatus,
    };
    // context.read<JobSheetDetailsBloc>().add(
    //       UpdateJobSheetStatus(
    //         id: widget.jobSheetDetail!.id.toString(),
    //         formData: formdata,
    //       ),
    //     );
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_SHORT,
      msg: "Job card status updated successfully",
      backgroundColor: successDarkColor,
    );
  }

//showDeleteConfirmation
  Future<void> showDeleteConfirmation(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            title: const Text(
              "Delete Job Card",
              style: TextStyle(
                  fontSize: 16,
                  color: blackColorDark,
                  fontWeight: FontWeight.bold),
            ),
            //   content: Text('Are you sure you want to delete?'),
            content: Container(
              width: 370,
              child: Text('Are you sure you want to delete?'),
            ),

            actions: [
              const Divider(
                color: hintTextColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancle',
                        style: TextStyle(color: blueColor),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: redColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<JobSheetBloc>().add(DeleteJobSheet(
                            id: widget.jobSheetDetail!.id.toString()));
                        CenterLoader.show(context);
                        await Future.delayed(const Duration(seconds: 3));
                        setState(() {
                          context.read<JobSheetBloc>().add(const FetchJobSheets(
                              status: jobSheetStatus.success));
                        });
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_LONG,
                            msg: "Job card deleted succesfully",
                            backgroundColor: successDarkColor);
                        CenterLoader.hide();
                        setState(() {
                          Navigator.pushNamed(context, '/job_sheet_listing');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: redColor,
                          foregroundColor: whiteColor),
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
