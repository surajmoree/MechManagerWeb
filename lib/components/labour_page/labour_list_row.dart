import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/labour_listeningmodel.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/labours/labour_edit.dart';
import 'package:mech_manager/modules/labours/labours_listening.dart';

class LabourListRow extends StatefulWidget {
  final LabourModelListingModel? labourModel;

  const LabourListRow({super.key, this.labourModel});

  @override
  State<LabourListRow> createState() => _LabourListRowState();
}

class _LabourListRowState extends State<LabourListRow> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context
            .read<JobSheetDetailsBloc>()
            .add(GetLabourById(id: widget.labourModel!.id.toString()));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EditLabour()));
      },
      child: Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade300)),
            shadowColor: greyColor,
            color: whiteColor,
            elevation: 0,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                '${widget.labourModel!.labourName.toString()}',
                                style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 70,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<JobSheetDetailsBloc>().add(
                                        GetLabourById(
                                            id: widget.labourModel!.id
                                                .toString()));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditLabour()));
                                  },
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: blueColor, fontSize: 16),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    deleteConfirmation(context);
                                  },
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: redColor, fontSize: 16),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Labour cost:${widget.labourModel!.labourRate.toString()}",
                      style: TextStyle(
                          color: blackColorDark,
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Labour description:${widget.labourModel!.taskDescription.toString()}",
                      style: TextStyle(
                          color: blackColorDark,
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<void> deleteConfirmation(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            title: const Text(
              "Are you sure you want to delete?",
              style: TextStyle(
                  color: blackColorDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
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
                        context.read<JobSheetBloc>().add(DeleteLabour(
                            id: widget.labourModel!.id.toString()));
                        CenterLoader.show(context);
                        await Future.delayed(const Duration(seconds: 3));
                        setState(() {
                          context.read<JobSheetBloc>().add(const FetchLabour(
                              status: jobSheetStatus.success));
                        });
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_LONG,
                            msg: "labour deleted succesfully",
                            backgroundColor: successDarkColor);
                        CenterLoader.hide();
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LaboursPage()));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: redColor,
                          foregroundColor: whiteColor),
                      child: const Text("Delete"),
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
