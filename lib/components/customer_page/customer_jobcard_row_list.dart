import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/customer_info_jobcard_list_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';

class CustomersJobCardRowList extends StatefulWidget {
  final CustomerInfoJobCardListModel? listData;

  // Accept the list data through the constructor
  CustomersJobCardRowList({Key? key, this.listData}) : super(key: key);

  @override
  State<CustomersJobCardRowList> createState() =>
      _CustomersJobCardRowListState();
}

class _CustomersJobCardRowListState extends State<CustomersJobCardRowList> {
  @override
  Widget build(BuildContext context) {
    // Check if listData is null before rendering
    if (widget.listData == null) {
      return Text('No data available');
    }

    // Render the actual data passed into the widget
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          context
              .read<JobSheetDetailsBloc>()
              .add(GetJobSheetDetails(id: widget.listData!.id.toString()));
          Navigator.pushNamed(context, '/job_sheet_details');
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
                    Text(
                      widget.listData!.customerName.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                        width: 35,
                        height: 20,
                        child: GestureDetector(
                          onTap: () {
                            context.read<JobSheetDetailsBloc>().add(
                                GetJobSheetDetails(
                                    id: widget.listData!.id.toString()));
                            Navigator.pushNamed(context, '/job_sheet_details');
                          },
                          child: Text(
                            '',
                            style: TextStyle(color: blueColor, fontSize: 16),
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Created Date:",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 12, color: blackColorLight),
                          ),
                          widget.listData!.createdDate.toString().isNotEmpty
                              ? Row(
                                  children: [
                                    Text(
                                      widget.listData!.createdDate.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      widget.listData!.createdTime.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 13, color: blackColorDark),
                                    )
                                  ],
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Vehicle Name:",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 12, color: blackColorLight),
                          ),
                          widget.listData!.vehicleName.toString().isNotEmpty
                              ? Text(widget.listData!.vehicleName.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 13, color: blackColorDark))
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Vehical Number:",
                            style: TextStyle(
                              fontSize: 12,
                              color: blackColorLight,
                            ),
                          ),
                          widget.listData!.vehicleNumber.toString().isNotEmpty
                              ? Text(
                                  widget.listData!.vehicleNumber
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 13,
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
                              fontSize: 12,
                              color: blackColorLight,
                            ),
                          ),
                          widget.listData!.vehicleManufat.toString().isNotEmpty
                              ? Text(
                                  widget.listData!.vehicleManufat.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: blackColorDark,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    )
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
