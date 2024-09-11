import 'package:flutter/material.dart';
import 'package:mech_manager/config/colors.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String count;
  //final IconData icon;
  final Widget container;
  final Color backgroundColor;
  final Color iconColor;
  

  const OverviewCard({
    required this.title,
    required this.count,
    required this.container,
   // required this.icon,
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
          Container(child: container,),
         // Icon(icon, size: 40, color: iconColor),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle( fontWeight: FontWeight.w700,fontSize: 14,color: textColor),
              ),
              Text(
                count,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
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
