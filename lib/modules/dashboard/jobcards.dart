import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const OverviewCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: iconColor),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '$count',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          )
         
        ],
      ),
    );
  }
}


class ResponsiveCard extends StatelessWidget {
  final Widget child;

  const ResponsiveCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
        
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),border: Border.all(color: Colors.grey.shade300)),

          child: child,
        );
      },
    );
  }
}
