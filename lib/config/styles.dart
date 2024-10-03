//  PopupMenuButton(
//                                                         itemBuilder: (context) =>
//                                                             <PopupMenuEntry>[
//                                                           const PopupMenuItem(
//                                                             value:
//                                                                 'edit customer',
//                                                             child: Text(
//                                                                 'Edit Customer'),
//                                                           ),
//                                                           const PopupMenuItem(
//                                                             value:
//                                                                 'edit vehicle',
//                                                             child: Text(
//                                                                 'Edit Vehicle'),
//                                                           ),
//                                                         ],
//                                                         onSelected: (value) {
//                                                           if (value ==
//                                                               'edit customer') {
//                                                             setState(() {
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop();
//                                                               showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder:
//                                                                       (BuildContext
//                                                                           context) {
//                                                                     return AlertDialog(
//                                                                       shape: RoundedRectangleBorder(
//                                                                           borderRadius:
//                                                                               BorderRadius.all(Radius.circular(5.0))),
//                                                                       contentPadding:
//                                                                           EdgeInsets.only(
//                                                                               top: 10.0),
                                                                     
//                                                                     );
//                                                                   });
//                                                             });
//                                                           } else if (value ==
//                                                               'edit vehicle') {
//                                                             setState(() {
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop();
                                                            
//                                                               showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder:
//                                                                       (BuildContext
//                                                                           context) {
//                                                                     return AlertDialog(
//                                                                       shape: RoundedRectangleBorder(
//                                                                           borderRadius:
//                                                                               BorderRadius.all(Radius.circular(5.0))),
//                                                                       contentPadding:
//                                                                           EdgeInsets.only(
//                                                                               top: 10.0),
                                                                    
//                                                                     );
//                                                                   });
//                                                             });
//                                                           }
//                                                         },
//                                                         child: const Icon(
//                                                           Icons.more_vert,
//                                                           color: hintTextColor,
//                                                         ),
//                                                       ),







