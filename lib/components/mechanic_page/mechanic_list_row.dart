import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/mechanic_listeningmodel.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/mechanics/mechanic_edit_page.dart';
import 'package:mech_manager/modules/mechanics/mechanics_listening.dart';

class MechanicListRow extends StatefulWidget {
  final MechanicListingModel? mechanictlist;
  const MechanicListRow({super.key, this.mechanictlist});

  @override
  State<MechanicListRow> createState() => _MechanicListRowState();
}

class _MechanicListRowState extends State<MechanicListRow> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context
            .read<JobSheetDetailsBloc>()
            .add(GetMechanicById(id: widget.mechanictlist!.id.toString()));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MechanicEditPage()));
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
                                '${widget.mechanictlist!.mechanicName.toString()}',
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
                                        GetMechanicById(
                                            id: widget.mechanictlist!.id
                                                .toString()));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MechanicEditPage()));
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
                    Text(
                      "Task Description:${widget.mechanictlist!.taskDescription.toString()}",
                      style: TextStyle(
                          color: blackColorDark,
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700),
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
                        context.read<JobSheetBloc>().add(DeleteMechanic(
                            id: widget.mechanictlist!.id.toString()));
                        CenterLoader.show(context);
                        await Future.delayed(const Duration(seconds: 3));
                        setState(() {
                          context.read<JobSheetBloc>().add(const FetchMechanics(
                              status: jobSheetStatus.success));
                        });
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_LONG,
                            msg: "Mechanic deleted succesfully",
                            backgroundColor: successDarkColor);
                        CenterLoader.hide();
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MechanicsPage()));
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
