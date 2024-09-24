// import 'dart:io';

// class EditJobSheet extends StatefulWidget {
//   const EditJobSheet({super.key});

//   @override
//   State<EditJobSheet> createState() => _EditJobSheetState();
// }

// class _EditJobSheetState extends State<EditJobSheet>
//     with SingleTickerProviderStateMixin {

//   late AnimationController _animationController;
//   bool _isDrawerOpen = true;
//   List<dynamic> vehicalImages = [];

//  // FilePickerResult? allDocs;

//   List<String>? imageName = <String>[];
//   List<Image?> selectedImage = List.filled(6, null);
//   bool? showUpdateButton = false;

//   //images
//   File frontImage = File("");
//   File rightHandSideImage = File("");
//   File leftHandSideImage = File("");
//   File rearImage = File("");
//   File dashboardImage = File("");
//   File engineImage = File("");

//   // Existing urls
//   String frontExistedImageUrl = "";
//   String rightHandExistedImageUrl = "";
//   String leftHandExistedImageUrl = "";
//   String rearExistedImageUrl = "";
//   String dashboardExistedImageUrl = "";
//   String engineExistedImageUrl = "";
//   String image1ExistedImageUrl = "";
//   String image2ExistedImageUrl = "";
//   String image3ExistedImageUrl = "";
//   String image4ExistedImageUrl = "";

//   // Additonal Images
//   File imageOne = File("");
//   File imageTwo = File("");
//   File imageThree = File("");
//   File imageFour = File("");

//   final _formKey = GlobalKey<FormState>();

//   int updateIndex = 0;
//   int additonalImageThumbCount = 0;
//   bool isLoading = false;
//   assignValue(JobSheetDetailsState state) {
//     setState(() {

//       frontExistedImageUrl =
//           state.jobSheetDetails!.vehicleFrontThumb.toString();
//       rightHandExistedImageUrl =
//           state.jobSheetDetails!.vehicleRightThumb.toString();
//       leftHandExistedImageUrl =
//           state.jobSheetDetails!.vehicleLeftThumb.toString();
//       rearExistedImageUrl = state.jobSheetDetails!.vehicleRearThumb.toString();
//       dashboardExistedImageUrl =
//           state.jobSheetDetails!.vehicleDashboardThumb.toString();
//       engineExistedImageUrl =
//           state.jobSheetDetails!.vehicleDickeyThumb.toString();
//       image1ExistedImageUrl = state.jobSheetDetails!.image1Thumb.toString();
//       image2ExistedImageUrl = state.jobSheetDetails!.image2Thumb.toString();
//       image3ExistedImageUrl = state.jobSheetDetails!.image3Thumb.toString();
//       image4ExistedImageUrl = state.jobSheetDetails!.image4Thumb.toString();

//       //extra added images

//       if (state.jobSheetDetails!.image1Thumb!.runtimeType != Null) {
//         additonalImageThumbCount++;
//       } else if (state.jobSheetDetails!.image2Thumb!.runtimeType != Null) {
//         additonalImageThumbCount++;
//       } else if (state.jobSheetDetails!.image3Thumb!.runtimeType != Null) {
//         additonalImageThumbCount++;
//       } else if (state.jobSheetDetails!.image4Thumb!.runtimeType != Null) {
//         additonalImageThumbCount++;
//       }
//       appConfig.additonalImageCount = additonalImageThumbCount;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _toggleDrawer() {
//     setState(() {
//       if (_isDrawerOpen) {
//         _animationController.reverse();
//       } else {
//         _animationController.forward();
//       }
//       _isDrawerOpen = !_isDrawerOpen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
//         listener: (context, state) {
//       if (state.status == JobSheetDetailsStatus.success) {
//           assignValue(state);
//         }
//     }, builder: (context, state) {
//       return WillPopScope(
//         onWillPop: () async {
//           appConfig.toastCount = 0;
//           appConfig.additonalImageCount = 0;
//           context
//               .read<JobSheetBloc>()
//               .add(const FetchJobSheets(status: jobSheetStatus.success));
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => JobSheetListing()),
//           );
//           return true;
//         },
//         child: BaseLayout(
//             title: 'MechMenager Admin',
//             closeDrawer: _toggleDrawer,
//             isDrawerOpen: _isDrawerOpen,
//             routeWidgets: [
//               GestureDetector(
//                 onTap: () {
//                   //  Navigator.pushNamed(context, '/dashboard_page');
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => DashboardPage()));
//                 },
//                 child: const Text(
//                   "Home",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               const Text(" / "),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => JobSheetListing()));
//                 },
//                 child: const Text(
//                   "Job Card",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               const Text(" / "),
//               const Text(
//                 "Update",
//                 style: TextStyle(color: greyColor),
//               ),
//               const Expanded(child: SizedBox()),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => JobSheetListing()));
//                 },
//                 child: const Row(
//                   children: [
//                     Icon(
//                       Icons.arrow_back_ios,
//                       size: 15,
//                     ),
//                     Text(
//                       "Back",
//                       style: TextStyle(color: blueColor),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//             body: (state.status == JobSheetDetailsStatus.initial ||
//                     state.status == JobSheetDetailsStatus.loading)
//                 ? const CenterLoader()
//                 : Form(
//                     key: _formKey,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const Text(
//                               'Job Card Update',
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 color: blackColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Card(
//                               shadowColor: whiteColor,
//                               color: whiteColor,
//                               elevation: 3,
//                               shape: RoundedRectangleBorder(
//                                   // borderRadius: BorderRadius.circular(5),
//                                   side:
//                                       BorderSide(color: Colors.grey.shade300)),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   //vehicle details

//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 18, right: 18),
//                                     child: Column(
//                                       children: [
//                                         const FormFieldTitle(
//                                             title: "Vehicle Images:"),
//                                         SelectImageRow(
//                                           title: 'Front',
//                                           takeImage: takeImage,
//                                           imageFile: frontImage,
//                                           existedImageUrl: frontExistedImageUrl,
//                                         ),
//                                     //  Text('imaggggg $frontExistedImageUrl'),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ))),
//       );
//     });
//   }

//   Future<void> takeImage(File imageType) async {
//     final picker = ImagePicker();
//     final pickedFile =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
//     if (pickedFile != null) {
//       setState(() {
//         if (imageType == frontImage) {
//           frontImage = File(pickedFile.path);
//         }
//         if (imageType == rightHandSideImage) {
//           rightHandSideImage = File(pickedFile.path);
//         }
//         if (imageType == leftHandSideImage) {
//           leftHandSideImage = File(pickedFile.path);
//         }
//         if (imageType == rearImage) {
//           rearImage = File(pickedFile.path);
//         }
//         if (imageType == dashboardImage) {
//           dashboardImage = File(pickedFile.path);
//         }
//         if (imageType == engineImage) {
//           engineImage = File(pickedFile.path);
//         }
//         if (imageType == imageOne) {
//           imageOne = File(pickedFile.path);
//         }
//         if (imageType == imageTwo) {
//           imageTwo = File(pickedFile.path);
//         }
//         if (imageType == imageThree) {
//           imageThree = File(pickedFile.path);
//         }
//         if (imageType == imageFour) {
//           imageFour = File(pickedFile.path);
//         }
//       });
//     }
//   }
// }

/*

class EstimatePage extends StatefulWidget {
  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final _formKeys = GlobalKey<FormState>();
  String? productId;
  List<dynamic> tasksList = [];

  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];


  List<dynamic> sparePart = [];
  int updateIndex = 0;
  bool addNewMode = false;
 
  
  String unitProductControlller = "PCS";
  TextEditingController productNameController = TextEditingController();
  TextEditingController sparePartNameController = TextEditingController();
  TextEditingController quantityProductController =
      TextEditingController(text: '1');
  TextEditingController rateProductController =
      TextEditingController(text: '00');
  String unitLabourController = "UNT";

  String? estimateTotalValue;
  List<Map<String, TextEditingController>> sparePartsListNewControllers = [];

  assignValue(JobSheetDetailsState state) {
   
    sparePartsList = state.estimateModel!.invoiceProducts!.toList();
  }

  void addNewRow() {
    setState(() {
      sparePartsListNewControllers.add({
        'product_id': TextEditingController(),
        'product_name': TextEditingController(),
        'product_qty': TextEditingController(),
        'product_unit': TextEditingController(),
        'product_price': TextEditingController(),
      });
    });
  }

  // Function to remove a row from sparePartsList or sparePartsListNew
  void removeRow(int index, bool isNewRow) {
    setState(() {
      if (isNewRow) {
        sparePartsListNewControllers.removeAt(index);
      } else {
        sparePartsList.removeAt(index);
      }
    });
  }

  void saveNewRow(int index) {
    setState(() {
      final newRow = {
        'product_id': sparePartsListNewControllers[index]['product_id']!.text,
        'product_name':
            sparePartsListNewControllers[index]['product_name']!.text,
        'product_qty': sparePartsListNewControllers[index]['product_qty']!.text,
        'product_unit':
            sparePartsListNewControllers[index]['product_unit']!.text,
        'product_price':
            sparePartsListNewControllers[index]['product_price']!.text,
      };

      sparePartsList.add(newRow); // Add to the existing list
      sparePartsListNewControllers.removeAt(index); // Remove from new row list
      addNewRow();
    });
  }


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
        listener: (context, state) {
      if (state.status == JobSheetDetailsStatus.success) {
        assignValue(state);
      }
    }, builder: (context, state) {
      tasksList = state.estimateModel!.customerComplaints!;
      return WillPopScope(
          onWillPop: () async {
            context.read<JobSheetDetailsBloc>().add(ResetLastEstimateId());
            context
                .read<JobSheetBloc>()
                .add(const FetchEstimateList(status: jobSheetStatus.success));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EstimateListing()));

            utility.resetToastCount();
            utility.resetAdditionalImageCount();
            return true;
          },
          child: BaseLayout(
              activeRouteNotifier: activeRouteNotifier,
              title: 'MechManager Admin',
              closeDrawer: _toggleDrawer,
              isDrawerOpen: _isDrawerOpen,
              body: (state.status == JobSheetDetailsStatus.initial ||
                      state.status == JobSheetDetailsStatus.loading)
                  ? const CenterLoader()
                  : Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                            
                              Card(
                                shadowColor: whiteColor,
                                color: whiteColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        color: Colors.grey.shade300)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                          top: 15,
                                          bottom: 15),
                                      child: 
                                              PopupMenuButton(
                                                itemBuilder: (context) =>
                                                    <PopupMenuEntry>[
                                                  const PopupMenuItem(
                                                    value: 'edit customer',
                                                    child:
                                                        Text('Edit Customer'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'edit vehicle',
                                                    child: Text('Edit Vehicle'),
                                                  ),
                                                ],
                                                onSelected: (value) {
                                                  if (value ==
                                                      'edit customer') {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.0))),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top:
                                                                          10.0),
                                                              content:
                                                                  EditCustomerByEstimate(
                                                                id: state
                                                                    .estimateModel!
                                                                    .estimateId,
                                                                fullname: state
                                                                    .estimateModel!
                                                                    .fullName
                                                                    .toString(),
                                                                address: state
                                                                    .estimateModel!
                                                                    .address
                                                                    .toString(),
                                                                email: state
                                                                    .estimateModel!
                                                                    .email
                                                                    .toString(),
                                                                phoneno: state
                                                                    .estimateModel!
                                                                    .mobileNumber
                                                                    .toString(),
                                                              ),
                                                            );
                                                          });
                                                    });
                                                  } else if (value ==
                                                      'edit vehicle') {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.0))),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top:
                                                                          10.0),
                                                              content:
                                                                  EditVehicleBox(
                                                                id: state
                                                                    .estimateModel!
                                                                    .estimateId,
                                                                vehicleName: state
                                                                    .estimateModel!
                                                                    .vehicleName
                                                                    .toString(),
                                                                vehicleNumber: state
                                                                    .estimateModel!
                                                                    .vehicleNumber
                                                                    .toString(),
                                                                manufacturers: state
                                                                    .estimateModel!
                                                                    .manufacturers
                                                                    .toString(),
                                                              ),
                                                            );
                                                          });
                                                    });
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.more_vert,
                                                  color: hintTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Color.fromARGB(
                                                255, 207, 207, 207),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // email phone address
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        const Text(
                                                          "Email:",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                          'Phone:',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Address:',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 60,
                                                    ),
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          state.estimateModel!
                                                                      .email
                                                                      .toString()
                                                                      .isNotEmpty &&
                                                                  state.estimateModel!
                                                                          .email
                                                                          .toString() !=
                                                                      null
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .email
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                              : const Text(
                                                                  "  -",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .mobileNumber
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .mobileNumber
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                              : const Text(
                                                                  "  -",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .address
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .address
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              // v number v name manufactt
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        Text(
                                                          "Vehicle number:",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Vehicle name:",
                                                          maxLines: 6,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Vehicle Manufacture:",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  blackColorLight),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          state.estimateModel!
                                                                      .vehicleNumber
                                                                      .toString()
                                                                      .isNotEmpty &&
                                                                  state.estimateModel!
                                                                          .vehicleNumber
                                                                          .toString() !=
                                                                      null
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .vehicleNumber
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .vehicleName
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .vehicleName
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          //////////
                                                          state.estimateModel!
                                                                  .manufacturers
                                                                  .toString()
                                                                  .isNotEmpty
                                                              ? Text(
                                                                  state
                                                                      .estimateModel!
                                                                      .manufacturers
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor))
                                                              : const Text(
                                                                  "  -",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              //estimate date
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Estimate Date:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8),
                                                    TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      controller:
                                                          _estimateDateController,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons
                                                              .calendar_month_sharp),
                                                          onPressed: () =>
                                                              _selectDate(
                                                                  context),
                                                        ),
                                                        hintStyle: TextStyle(
                                                            color:
                                                                hintTextColor,
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 14),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        8),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        isDense: true,
                                                        hintText:
                                                            "Estimate Date",
                                                        filled: true,
                                                        fillColor:
                                                            lightGreyColor,
                                                      ),
                                                      onTap: () =>
                                                          _selectDate(context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 207, 207, 207),
                                    ),

                                    //spare part table
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Spare Parts:',
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontFamily: 'Mulish',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          if (sparePartsList.isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                  color: Colors.grey),
                                              columnWidths: {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(3),
                                                2: FlexColumnWidth(2),
                                                3: FlexColumnWidth(2),
                                                4: FlexColumnWidth(2),
                                                5: FlexColumnWidth(2),
                                                6: FlexColumnWidth(2),
                                              },
                                              children: [
                                                // Header Row
                                                TableRow(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blueGrey),
                                                  children: [
                                                    headerCell('Sr no'),
                                                    headerCell(
                                                        'Spare Part Name'),
                                                    headerCell('Quantity'),
                                                    headerCell('Unit'),
                                                    headerCell('Rate'),
                                                    headerCell('Amount'),
                                                    headerCell('Action'),
                                                  ],
                                                ),

                                                for (int i = 0;
                                                    i < sparePartsList.length;
                                                    i++)
                                                  TableRow(
                                                    children: [
                                                      tableCell(
                                                          sparePartsList[i]
                                                                  ['product_id']
                                                              .toString()),
                                                      tableCell(sparePartsList[
                                                              i]['product_name']
                                                          .toString()),
                                                      tableCell(sparePartsList[
                                                              i]['product_qty']
                                                          .toString()),
                                                      tableCell(sparePartsList[
                                                              i]['product_unit']
                                                          .toString()),
                                                      tableCell(sparePartsList[
                                                                  i]
                                                              ['product_price']
                                                          .toString()),
                                                      tableCell(
                                                        ((double.tryParse(sparePartsList[i]
                                                                            [
                                                                            'product_price']
                                                                        .toString()) ??
                                                                    0.0) *
                                                                (double.tryParse(sparePartsList[i]
                                                                            [
                                                                            'product_qty']
                                                                        .toString()) ??
                                                                    0.0))
                                                            .toStringAsFixed(2),
                                                      ),
                                                      // Action button (add for last row, delete for others)
                                                      TableCell(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (i ==
                                                                    sparePartsList
                                                                            .length -
                                                                        1 &&
                                                                sparePartsListNew
                                                                    .isEmpty) {
                                                              addNewRow();
                                                            } else {
                                                              removeRow(i,
                                                                  false); // Delete from sparePartsList
                                                            }
                                                          },
                                                          child: Icon(
                                                            sparePartsListNew
                                                                        .isEmpty &&
                                                                    i ==
                                                                        sparePartsList.length -
                                                                            1
                                                                ? Icons.add
                                                                : Icons.delete,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          // if (sparePartsListNew.isNotEmpty)
                                          if (sparePartsListNewControllers
                                              .isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                  color: Colors.grey),
                                              columnWidths: {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(3),
                                                2: FlexColumnWidth(2),
                                                3: FlexColumnWidth(2),
                                                4: FlexColumnWidth(2),
                                                5: FlexColumnWidth(2),
                                                6: FlexColumnWidth(2),
                                              },
                                              children: [
                                                // Data Rows for new parts
                                                for (int i = 0;
                                                    i <
                                                        sparePartsListNewControllers
                                                            .length;
                                                    i++)
                                                  TableRow(
                                                    children: [
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i]
                                                              ['product_id']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i][
                                                              'product_name']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i]
                                                              ['product_qty']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i][
                                                              'product_unit']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i][
                                                              'product_price']!),
                                                      tableCell(
                                                        ((double.tryParse(sparePartsListNewControllers[i]
                                                                            [
                                                                            'product_price']!
                                                                        .text) ??
                                                                    0.0) *
                                                                (double.tryParse(sparePartsListNewControllers[i]
                                                                            [
                                                                            'product_qty']!
                                                                        .text) ??
                                                                    0.0))
                                                            .toStringAsFixed(2),
                                                      ),
                                                      TableCell(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (i ==
                                                                sparePartsListNewControllers
                                                                        .length -
                                                                    1) {
                                                              saveNewRow(
                                                                  i); // Save new row into sparePartsList
                                                            } else {
                                                              removeRow(i,
                                                                  true); // Delete from sparePartsListNewControllers
                                                            }
                                                          },
                                                          child: Icon(
                                                            i ==
                                                                    sparePartsListNewControllers
                                                                            .length -
                                                                        1
                                                                ? Icons.add
                                                                : Icons.delete,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))));
    });
  }

  Widget headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }

  Widget tableCellInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

*/





/*

class EstimatePage extends StatefulWidget {
  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  final _formKey = GlobalKey<FormState>();

  String? productId;

  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];

  List<dynamic> sparePart = [];
  int updateIndex = 0;
  bool addNewMode = false;
  int productTotalValue = 0;
  JobSheetModel? jobSheetModel;
  String unitProductControlller = "PCS";
  TextEditingController productNameController = TextEditingController();
  TextEditingController sparePartNameController = TextEditingController();
  TextEditingController quantityProductController =
      TextEditingController(text: '1');
  TextEditingController rateProductController =
      TextEditingController(text: '00');
  String unitLabourController = "UNT";

  String? estimateTotalValue;
  List<Map<String, TextEditingController>> sparePartsListNewControllers = [];

  assignValue(JobSheetDetailsState state) {
    _fullNameController.text = state.estimateModel!.fullName.toString();
    _estimateDateController.text = state.estimateModel!.tempDate.toString();
    sparePartsList = state.estimateModel!.invoiceProducts!.toList();
  }

  void addNewRow() {
    setState(() {
      sparePartsListNewControllers.add({
        'product_id': TextEditingController(),
        'product_name': TextEditingController(),
        'product_qty': TextEditingController(),
        'product_unit': TextEditingController(),
        'product_price': TextEditingController(),
      });
    });
  }

  // Function to remove a row from sparePartsList or sparePartsListNew
  void removeRow(int index, bool isNewRow) {
    setState(() {
      if (isNewRow) {
        sparePartsListNewControllers.removeAt(index);
      } else {
        sparePartsList.removeAt(index);
      }
    });
  }

  void saveNewRow(int index) {
    setState(() {
      final newRow = {
        'product_id': sparePartsListNewControllers[index]['product_id']!.text,
        'product_name':
            sparePartsListNewControllers[index]['product_name']!.text,
        'product_qty': sparePartsListNewControllers[index]['product_qty']!.text,
        'product_unit':
            sparePartsListNewControllers[index]['product_unit']!.text,
        'product_price':
            sparePartsListNewControllers[index]['product_price']!.text,
      };

      sparePartsList.add(newRow); // Add to the existing list
      sparePartsListNewControllers.removeAt(index); // Remove from new row list
      addNewRow();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
        listener: (context, state) {
      if (state.status == JobSheetDetailsStatus.success) {
        assignValue(state);
      }
    }, builder: (context, state) {
      tasksList = state.estimateModel!.customerComplaints!;
      return WillPopScope(
          onWillPop: () async {
            context.read<JobSheetDetailsBloc>().add(ResetLastEstimateId());
            context
                .read<JobSheetBloc>()
                .add(const FetchEstimateList(status: jobSheetStatus.success));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EstimateListing()));

            utility.resetToastCount();
            utility.resetAdditionalImageCount();
            return true;
          },
          child: BaseLayout(
              activeRouteNotifier: activeRouteNotifier,
              title: 'MechManager Admin',
              closeDrawer: _toggleDrawer,
              isDrawerOpen: _isDrawerOpen,
              body: (state.status == JobSheetDetailsStatus.initial ||
                      state.status == JobSheetDetailsStatus.loading)
                  ? const CenterLoader()
                  : Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                shadowColor: whiteColor,
                                color: whiteColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        color: Colors.grey.shade300)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                          top: 15,
                                          bottom: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Divider(
                                            color: Color.fromARGB(
                                                255, 207, 207, 207),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //spare part table
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Spare Parts:',
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontFamily: 'Mulish',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          if (sparePartsList.isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                  color: Colors.grey),
                                              columnWidths: {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(3),
                                                2: FlexColumnWidth(2),
                                                3: FlexColumnWidth(2),
                                                4: FlexColumnWidth(2),
                                                5: FlexColumnWidth(2),
                                                6: FlexColumnWidth(2),
                                              },
                                              children: [
                                                // Header Row
                                                TableRow(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blueGrey),
                                                  children: [
                                                    headerCell('Sr no'),
                                                    headerCell(
                                                        'Spare Part Name'),
                                                    headerCell('Quantity'),
                                                    headerCell('Unit'),
                                                    headerCell('Rate'),
                                                    headerCell('Amount'),
                                                    headerCell('Action'),
                                                  ],
                                                ),

                                                for (int i = 0;
                                                    i < sparePartsList.length;
                                                    i++)
                                                  TableRow(
                                                    children: [
                                                      tableCell(
                                                          sparePartsList[i]
                                                                  ['product_id']
                                                              .toString()),
                                                      tableCell(sparePartsList[
                                                              i]['product_name']
                                                          .toString()),
                                                      tableCell(sparePartsList[
                                                              i]['product_qty']
                                                          .toString()),
                                                      tableCell(sparePartsList[
                                                              i]['product_unit']
                                                          .toString()),
                                                      tableCell(sparePartsList[
                                                                  i]
                                                              ['product_price']
                                                          .toString()),
                                                      tableCell(
                                                        ((double.tryParse(sparePartsList[i]
                                                                            [
                                                                            'product_price']
                                                                        .toString()) ??
                                                                    0.0) *
                                                                (double.tryParse(sparePartsList[i]
                                                                            [
                                                                            'product_qty']
                                                                        .toString()) ??
                                                                    0.0))
                                                            .toStringAsFixed(2),
                                                      ),
                                                      // Action button (add for last row, delete for others)
                                                      TableCell(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (i ==
                                                                    sparePartsList
                                                                            .length -
                                                                        1 &&
                                                                sparePartsListNew
                                                                    .isEmpty) {
                                                              addNewRow();
                                                            } else {
                                                              removeRow(i,
                                                                  false); // Delete from sparePartsList
                                                            }
                                                          },
                                                          child: Icon(
                                                            sparePartsListNew
                                                                        .isEmpty &&
                                                                    i ==
                                                                        sparePartsList.length -
                                                                            1
                                                                ? Icons.add
                                                                : Icons.delete,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          // if (sparePartsListNew.isNotEmpty)
                                          if (sparePartsListNewControllers
                                              .isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                  color: Colors.grey),
                                              columnWidths: {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(3),
                                                2: FlexColumnWidth(2),
                                                3: FlexColumnWidth(2),
                                                4: FlexColumnWidth(2),
                                                5: FlexColumnWidth(2),
                                                6: FlexColumnWidth(2),
                                              },
                                              children: [
                                                // Data Rows for new parts
                                                for (int i = 0;
                                                    i <
                                                        sparePartsListNewControllers
                                                            .length;
                                                    i++)
                                                  TableRow(
                                                    children: [
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i]
                                                              ['product_id']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i][
                                                              'product_name']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i]
                                                              ['product_qty']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i][
                                                              'product_unit']!),
                                                      tableCellInput(
                                                          sparePartsListNewControllers[
                                                                  i][
                                                              'product_price']!),
                                                      tableCell(
                                                        ((double.tryParse(sparePartsListNewControllers[i]
                                                                            [
                                                                            'product_price']!
                                                                        .text) ??
                                                                    0.0) *
                                                                (double.tryParse(sparePartsListNewControllers[i]
                                                                            [
                                                                            'product_qty']!
                                                                        .text) ??
                                                                    0.0))
                                                            .toStringAsFixed(2),
                                                      ),
                                                      TableCell(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (i ==
                                                                sparePartsListNewControllers
                                                                        .length -
                                                                    1) {
                                                              saveNewRow(
                                                                  i); // Save new row into sparePartsList
                                                            } else {
                                                              removeRow(i,
                                                                  true); // Delete from sparePartsListNewControllers
                                                            }
                                                          },
                                                          child: Icon(
                                                            i ==
                                                                    sparePartsListNewControllers
                                                                            .length -
                                                                        1
                                                                ? Icons.add
                                                                : Icons.delete,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))));
    });
  }

  Widget headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }

  Widget tableCellInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
*/