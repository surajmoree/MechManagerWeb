import 'package:flutter/material.dart';

class SelectImageTitle extends StatelessWidget {
  final String title;
  const SelectImageTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
    );
  }
}