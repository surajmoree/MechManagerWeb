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



