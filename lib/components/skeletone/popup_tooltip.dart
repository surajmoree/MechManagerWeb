// import 'package:flutter/material.dart';

// class PopupWithTooltip extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return 
//           PopupMenuButton<int>(
//             shape: TooltipShape(), // Custom shape for the tooltip
//             icon: CircleAvatar(),
//             onSelected: (value) {
//               // Handle selection
//             },
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: 1,
//                 child: Row(
//                   children: [
//                     Icon(Icons.settings, color: Colors.white),
//                     SizedBox(width: 10),
//                     Text("Settings", style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 2,
//                 child: Row(
//                   children: [
//                     Icon(Icons.logout, color: Colors.white),
//                     SizedBox(width: 10),
//                     Text("Logout", style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//             ],
//             color: Colors.black87, // Popup background color
            
//           );
       
      
    
//   }
// }

// class TooltipShape extends ShapeBorder {
//   @override
//   EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     const triangleHeight = 10.0;
//     const triangleWidth = 20.0;
//     final path = Path();

//     // Start from the top left corner of the popup
//     path.moveTo(rect.left, rect.top + triangleHeight);
//     // Add the rectangle for the menu
//     path.lineTo(rect.right, rect.top + triangleHeight);
//     path.lineTo(rect.right, rect.bottom);
//     path.lineTo(rect.left, rect.bottom);
//     path.close();

//     // Draw the triangle at the top right corner
//     final trianglePath = Path();
//     trianglePath.moveTo(rect.right - 25, rect.top + triangleHeight); // Adjust positioning here
//     trianglePath.lineTo(rect.right - 15, rect.top); // Adjust width and height here
//     trianglePath.lineTo(rect.right - 5, rect.top + triangleHeight);
//     trianglePath.close();

//     path.addPath(trianglePath, Offset.zero);

//     return path;
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
//     final paint = Paint()..color = Colors.black87;
//     final path = getOuterPath(rect, textDirection: textDirection);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   ShapeBorder scale(double t) => this;

//   @override
//   Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
//     // Return an empty path or similar to outer path if necessary
//     return Path();
//   }
// }




