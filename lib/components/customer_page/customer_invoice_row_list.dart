import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/customer_info_invoice_list_model.dart';
import 'package:mech_manager/modules/invoice/invoice_page.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';

class CustomerInvoiceRowList extends StatefulWidget {
  CustomerInfoInvoiceListModel? invoicelistData;

  CustomerInvoiceRowList({super.key, this.invoicelistData});

  @override
  State<CustomerInvoiceRowList> createState() => _CustomerInvoiceRowListState();
}

class _CustomerInvoiceRowListState extends State<CustomerInvoiceRowList> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (widget.invoicelistData == null) {
      return Text('No data available');
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          context.read<JobSheetDetailsBloc>().add(
              GetInvoiceByInvoice(id: widget.invoicelistData!.id.toString()));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InvoicePage()));
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
                          (widget.invoicelistData!.invoiceNumber
                                      .toString()
                                      .length ==
                                  1)
                              ? Row(
                                  children: [
                                    Text(
                                      '#000${widget.invoicelistData!.invoiceNumber.toString()}',
                                      style: const TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(' - '),
                                    Text(
                                      widget.invoicelistData!.fullName
                                          .toString(),
                                      style: TextStyle(
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
                                        '#00${widget.invoicelistData!.invoiceNumber.toString()}',
                                        style: const TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    Text(' - '),
                                    Text(
                                      widget.invoicelistData!.fullName
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 35,
                        height: 20,
                        child: GestureDetector(
                          onTap: () {
                            context.read<JobSheetDetailsBloc>().add(
                                GetInvoiceByInvoice(
                                    id: widget.invoicelistData!.id.toString()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InvoicePage()));
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
                      widget.invoicelistData!.vehicleNumber.toString(),
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
                        (widget.invoicelistData!.invoiceTotal == 'null')
                            ? const Text(
                                '0',
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                double.parse(
                                        widget.invoicelistData!.invoiceTotal!)
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
                      widget.invoicelistData!.vehicleName.toString(),
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
