import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/customer_info_estimate_list_model.dart';
import 'package:mech_manager/modules/estimate/estimate_page.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';

class CustomerEstimateRowList extends StatefulWidget {
  CustomerInfoEstimateListModel? estimatelistData;

  CustomerEstimateRowList({super.key, this.estimatelistData});
  @override
  State<CustomerEstimateRowList> createState() =>
      _CustomerEstimateRowListState();
}

class _CustomerEstimateRowListState extends State<CustomerEstimateRowList> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (widget.estimatelistData == null) {
      return Text('No data available');
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          context.read<JobSheetDetailsBloc>().add(GetEstimateDetailsByEstimate(
              id: widget.estimatelistData!.id.toString()));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EstimatePage()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          shadowColor: Colors.grey,
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          (widget.estimatelistData!.estimateNumber
                                      .toString()
                                      .length ==
                                  1)
                              ? Row(
                                  children: [
                                    Text(
                                      '#000${widget.estimatelistData!.estimateNumber.toString()}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(' - '),
                                    Text(
                                      widget.estimatelistData!.fullName
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : (widget.estimatelistData!.estimateNumber
                                          .toString()
                                          .length ==
                                      3)
                                  ? Row(
                                      children: [
                                        Text(
                                          '#0${widget.estimatelistData!.estimateNumber.toString()}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: textColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(' - '),
                                        Text(
                                          widget.estimatelistData!.fullName
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
                                          '#00${widget.estimatelistData!.estimateNumber.toString()}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: textColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(' - '),
                                        Text(
                                          widget.estimatelistData!.fullName
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
                        width: 35,
                        height: 20,
                        child: GestureDetector(
                          onTap: () {
                            context.read<JobSheetDetailsBloc>().add(
                                GetEstimateDetailsByEstimate(
                                    id: widget.estimatelistData!.id
                                        .toString()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EstimatePage()));
                          },
                          child: Text(
                            '',
                            style: TextStyle(color: blueColor, fontSize: 16),
                          ),
                        ))
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
                      widget.estimatelistData!.vehicleNumber.toString(),
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
                        (widget.estimatelistData!.estimateTotal == 'null')
                            ? const Text(
                                '0',
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                double.parse(
                                        widget.estimatelistData!.estimateTotal!)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.estimatelistData!.vehicleName.toString(),
                      style: TextStyle(
                          fontSize: screenHeight * 0.021,
                          color: blackColorLight,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
