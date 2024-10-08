import 'package:flutter/material.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/spare_part_model.dart';

class SparePartListRow extends StatefulWidget {
  final SparePartModel? sparepartlist;
  const SparePartListRow({super.key, this.sparepartlist});

  @override
  State<SparePartListRow> createState() => _SparePartListRowState();
}

class _SparePartListRowState extends State<SparePartListRow> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.sparepartlist!.productName.toString()}',
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Sales Price:${widget.sparepartlist!.productPrice.toString()}",
                    style: TextStyle(
                        color: blackColorDark,
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
