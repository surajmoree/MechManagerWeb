import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/customer_listening_model.dart';
import 'package:mech_manager/modules/customer/customer_detail_page.dart';
import 'package:mech_manager/modules/customer/edit_customer.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';

class CustomerRowList extends StatefulWidget {
  CustomerListingModel? customerModel;
  CustomerRowList({super.key, this.customerModel});

  @override
  State<CustomerRowList> createState() => _CustomerRowListState();
}

class _CustomerRowListState extends State<CustomerRowList> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context
            .read<JobSheetDetailsBloc>()
            .add(GetCustomerById(id: widget.customerModel!.id.toString()));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomerDetailPage()));
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
                                '${widget.customerModel!.fullName.toString()}',
                                style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
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
                                    GetCustomerById(
                                        id: widget.customerModel!.id
                                            .toString()));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditCustomer()));
                              },
                              child: Text(
                                '',
                                style:
                                    TextStyle(color: blueColor, fontSize: 16),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Phone:${widget.customerModel!.mobileNumber.toString()}",
                      style: TextStyle(
                          color: blackColorDark,
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Email:${widget.customerModel!.email.toString()}",
                      style: TextStyle(
                          color: blackColorDark,
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Address:${widget.customerModel!.address.toString()}",
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
}
