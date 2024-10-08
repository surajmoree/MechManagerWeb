import 'package:flutter/material.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/models/stock_listening_model.dart';

class StockListRow extends StatelessWidget {
  final StockListeningModel? stoklist;

  const StockListRow({super.key, this.stoklist});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      shadowColor: greyColor,
      color: whiteColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${stoklist?.sparePartName ?? "No Name"}',
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}