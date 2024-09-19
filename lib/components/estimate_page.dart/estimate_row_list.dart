import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/estimate_listiening_model.dart';
import 'package:mech_manager/modules/estimate/estimate_listening.dart';
import 'package:mech_manager/modules/estimate/estimate_page.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';

class EstimateListRow extends StatefulWidget {
  final EstimateListingModel? estimateList;

  const EstimateListRow({super.key, this.estimateList});
  @override
  State<EstimateListRow> createState() => _EstimateListRowState();
}

class _EstimateListRowState extends State<EstimateListRow> {
  final _formKey = GlobalKey<FormState>();
  
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context.read<JobSheetDetailsBloc>().add(GetEstimateDetailsByEstimate(
            id: widget.estimateList!.id.toString()));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EstimatePage()));
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
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            (widget.estimateList!.estimateNumber
                                        .toString()
                                        .length ==
                                    1)
                                ? Row(
                                    children: [
                                      Text(
                                        '#000${widget.estimateList!.estimateNumber.toString()}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(' - '),
                                      Text(
                                        widget.estimateList!.fullname
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : (widget.estimateList!.estimateNumber
                                            .toString()
                                            .length ==
                                        3)
                                    ? Row(
                                        children: [
                                          Text(
                                            '#0${widget.estimateList!.estimateNumber.toString()}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: textColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(' - '),
                                          Text(
                                            widget.estimateList!.fullname
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: textColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            '#00${widget.estimateList!.estimateNumber.toString()}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: textColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Text(' - '),
                                          Text(
                                            widget.estimateList!.fullname
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: textColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
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
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const EditJobSheet()));
                                  // context.read<JobSheetDetailsBloc>().add(
                                  //     GetJobSheetDetails(
                                  //         id: widget.jobSheetDetail!.id
                                  //             .toString()));
                                },
                                child: Text(
                                  '',
                                  style:
                                      TextStyle(color: blueColor, fontSize: 16),
                                )),
                            GestureDetector(
                              onTap: () {
                                showExitConfirmation(context);
                                //   PopupMenuButton(
                                //   itemBuilder: (context) => <PopupMenuEntry>[

                                //     PopupMenuItem(
                                //       value: 'delete',
                                //       child: Text(
                                //         'Delete',
                                //         style: TextStyle(
                                //             fontSize: screenHeight * 0.021,
                                //             fontWeight: FontWeight.w500,
                                //             color: blackColorDark),
                                //       ),
                                //     ),
                                //   ],
                                //   onSelected: (value) {
                                //     if (value == 'delete') {
                                //       showExitConfirmation(context);
                                //     }
                                //   },
                                //   child: const Icon(
                                //     verticleDot,
                                //     color: hintTextColor,
                                //   ),
                                // );
                              },
                              child: Text(
                                '',
                                style: TextStyle(color: redColor, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 207, 207, 207),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.estimateList!.vehicleNumber.toString(),
                        style: TextStyle(
                            color: blackColorDark,
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          const Icon(
                            currency,
                            size: 17,
                            color: blackColor,
                          ),
                          (widget.estimateList!.estimateTotal == 'null')
                              ? const Text(
                                  '0',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  double.parse(
                                          widget.estimateList!.estimateTotal!)
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                      // color: successColor,
                                      color: blackColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.estimateList!.vehicleName.toString(),
                    style: TextStyle(
                        fontSize: screenHeight * 0.021,
                        color: blackColorLight,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )),
          )),
    );
  }

  Future<void> showExitConfirmation(BuildContext context) async {
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
                        context.read<JobSheetBloc>().add(DeleteEstimate(
                            id: widget.estimateList!.id.toString()));
                        CenterLoader.show(context);
                        await Future.delayed(const Duration(seconds: 3));
                        setState(() {
                          context
                              .read<JobSheetBloc>()
                              .add(const FetchEstimateList(
                                status: jobSheetStatus.success,
                              ));
                        });
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_LONG,
                            msg: "Estimate deleted succesfully",
                            backgroundColor: successDarkColor);
                        CenterLoader.hide();
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EstimateListing()));
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
