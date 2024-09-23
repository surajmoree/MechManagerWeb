import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/job_sheet_details/additional_image_preview.dart';
import 'package:mech_manager/components/job_sheet_details/image_preview.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

class JobSheetDetails extends StatefulWidget {
  const JobSheetDetails({super.key});

  @override
  State<JobSheetDetails> createState() => _JobSheetDetailsState();
}

class _JobSheetDetailsState extends State<JobSheetDetails>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  List<dynamic> customerComplaintsList = [];
  List<String> sliderImage = [];
  List<String> additionalImages = [];
  final _formKey = GlobalKey<FormState>();
  String? fullname;

  assignValue(JobSheetDetailsState state) {
    fullname = state.jobSheetDetails!.fullName.toString();
    customerComplaintsList = state.jobSheetDetails!.customerComplaints!;
    sliderImage = [
      state.imageSliderModel!.vehicleFrontImg.toString(),
      state.imageSliderModel!.vehicleRightImg.toString(),
      state.imageSliderModel!.vehicleLeftImg.toString(),
      state.imageSliderModel!.vehicleRearImg.toString(),
      state.imageSliderModel!.vehicleDashboardImg.toString(),
      state.imageSliderModel!.vehicleDickeyImg.toString()
    ];

    additionalImages = [
      state.imageSliderModel!.images1.toString(),
      state.imageSliderModel!.images2.toString(),
      state.imageSliderModel!.images3.toString(),
      state.imageSliderModel!.images4.toString(),
    ];
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

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        title: 'MechMenager Admin',
        closeDrawer: _toggleDrawer,
        isDrawerOpen: _isDrawerOpen,
        activeRouteNotifier: activeRouteNotifier,
        body: BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
            builder: (context, state) {
          if (state.status == JobSheetDetailsStatus.success) {
            assignValue(state);
          }
          return (state.status == JobSheetDetailsStatus.loading ||
                  state.status == JobSheetDetailsStatus.initial)
              ? const CenterLoader()
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: const Text(
                              'Job Card Details',
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Card(
                            shadowColor: whiteColor,
                            color: whiteColor,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.grey.shade300)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 15, bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.jobSheetDetails!.fullName.toString(),
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: blackColor,
                                        fontFamily: 'Mulish',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                          state.jobSheetDetails!.mobileNumber
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'meck',
                                              fontSize: 13)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                          state.jobSheetDetails!
                                              .alternateMobileNumber
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'meck',
                                              fontSize: 13)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        state.jobSheetDetails!.email.toString(),
                                        style: TextStyle(
                                            fontFamily: 'meck', fontSize: 13),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Address:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            state.jobSheetDetails!.address
                                                    .toString()
                                                    .isNotEmpty
                                                ? Text(
                                                    state.jobSheetDetails!
                                                        .address
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: blackColorDark),
                                                  )
                                                : SizedBox.shrink(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Created Date:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            state.jobSheetDetails!.createdAtDate
                                                    .toString()
                                                    .isNotEmpty
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        state.jobSheetDetails!
                                                            .createdAtDate
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        state.jobSheetDetails!
                                                            .createdAtTime
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                blackColorDark),
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Vehicle Manufacturer:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            state.jobSheetDetails!.manufacturers
                                                    .toString()
                                                    .isNotEmpty
                                                ? Text(
                                                    state.jobSheetDetails!
                                                        .manufacturers
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: blackColorDark),
                                                  )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              "Vehicle kms:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            state.jobSheetDetails!.kms
                                                    .toString()
                                                    .isNotEmpty
                                                ? Text(
                                                    state.jobSheetDetails!.kms
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: blackColorDark),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Created By:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            state.jobSheetDetails!.createdBy
                                                    .toString()
                                                    .isNotEmpty
                                                ? Text(
                                                    state.jobSheetDetails!
                                                        .createdBy
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: blackColorDark),
                                                  )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Vehicle Number:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            state.jobSheetDetails!.vehicleNumber
                                                    .toString()
                                                    .isNotEmpty
                                                ? Text(
                                                    state.jobSheetDetails!
                                                        .vehicleNumber
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: blackColorDark),
                                                  )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Status",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      constraints:
                                                          BoxConstraints.tight(
                                                        Size.fromHeight(40),
                                                      ),
                                                      isDense: true,
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    3)),
                                                        borderSide: BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      fillColor: lightGreyColor,
                                                    ),
                                                    value: state
                                                            .jobSheetDetails!
                                                            .status
                                                            .toString()
                                                            .isNotEmpty
                                                        ? state.jobSheetDetails!
                                                            .status
                                                            .toString()
                                                        : "New Job",
                                                    onChanged:
                                                        (String? newValue) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                '''Are you sure you want to mark this job card as "$newValue"?''',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color:
                                                                        darkColor),
                                                              ),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    state.jobSheetDetails = state
                                                                        .jobSheetDetails!
                                                                        .copyWith(
                                                                            status:
                                                                                newValue);

                                                                    Map<String,
                                                                            dynamic>
                                                                        formData =
                                                                        {
                                                                      "status": state
                                                                          .jobSheetDetails!
                                                                          .status
                                                                    };
                                                                    context.read<JobSheetDetailsBloc>().add(UpdateJobSheetStatus(
                                                                        id: state
                                                                            .jobSheetDetails!
                                                                            .id
                                                                            .toString(),
                                                                        formData:
                                                                            formData));
                                                                    Fluttertoast.showToast(
                                                                        toastLength:
                                                                            Toast
                                                                                .LENGTH_SHORT,
                                                                        msg:
                                                                            "Status updated successfully",
                                                                        backgroundColor:
                                                                            successDarkColor);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                          backgroundColor:
                                                                              primaryColor),
                                                                  child:
                                                                      const Text(
                                                                          "Yes"),
                                                                ),
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/job_sheet_details');
                                                                  },
                                                                  style: OutlinedButton.styleFrom(
                                                                      backgroundColor:
                                                                          whiteColor,
                                                                      side: const BorderSide(
                                                                          color:
                                                                              primaryColor,
                                                                          width:
                                                                              1)),
                                                                  child:
                                                                      const Text(
                                                                    "No",
                                                                    style: TextStyle(
                                                                        color:
                                                                            primaryColor),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    items: statusList
                                                        .map((String status) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: status,
                                                        child: Text(
                                                          status,
                                                          maxLines: 3,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Vehicle Fuel:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            state.jobSheetDetails!.fuel
                                                    .toString()
                                                    .isNotEmpty
                                                ? Text(state
                                                    .jobSheetDetails!.fuel
                                                    .toString())
                                                : SizedBox.shrink()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'Selected Items:',
                                    style: TextStyle(
                                        fontSize: 12, color: blackColorLight),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Checkbox(
                                                      activeColor: blueColor,
                                                      value:
                                                          (state.jobSheetDetails!
                                                                      .items![0]
                                                                  ['checked'] ==
                                                              true),
                                                      onChanged: null),
                                                ),
                                                const Text(
                                                  'Jack & Tommy',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: blackColor),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Checkbox(
                                                    activeColor: blueColor,
                                                    value:
                                                        (state.jobSheetDetails!
                                                                    .items![2]
                                                                ['checked'] ==
                                                            true),
                                                    onChanged:
                                                        null, // Make the checkbox read-only
                                                  ),
                                                ),
                                                const Text(
                                                  'Tool Kit',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Checkbox(
                                                          activeColor:
                                                              blueColor,
                                                          value: (state
                                                                      .jobSheetDetails!
                                                                      .items![4]
                                                                  ['checked'] ==
                                                              true),
                                                          onChanged: null),
                                                    ),
                                                    const Text(
                                                      'Battery',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                /*
                                                 if (state.jobSheetDetails!
                                                        .items![4]['checked'] ==
                                                    true)
                                                */
                                                if (state.jobSheetDetails!
                                                        .items![4]['checked'] ==
                                                    true)
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      "(${state.jobSheetDetails!.items![4]['value']})",
                                                      style: const TextStyle(
                                                          backgroundColor:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Checkbox(
                                                      activeColor: blueColor,
                                                      value:
                                                          (state.jobSheetDetails!
                                                                      .items![6]
                                                                  ['checked'] ==
                                                              true),
                                                      onChanged: null),
                                                ),
                                                const Text(
                                                  'Mirror LH',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Checkbox(
                                                          activeColor:
                                                              blueColor,
                                                          value: (state
                                                                      .jobSheetDetails!
                                                                      .items![8]
                                                                  ['checked'] ==
                                                              true),
                                                          onChanged: null),
                                                    ),
                                                    const Text(
                                                      'Mud Flap',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                if (state.jobSheetDetails!
                                                        .items![8]['checked'] ==
                                                    true)
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      "(${state.jobSheetDetails!.items![8]['value']})",
                                                      style: const TextStyle(
                                                          backgroundColor:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Checkbox(
                                                      activeColor: blueColor,
                                                      value:
                                                          (state.jobSheetDetails!
                                                                      .items![1]
                                                                  ['checked'] ==
                                                              true),
                                                      onChanged: null),
                                                ),
                                                const Text(
                                                  'Stepney',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Checkbox(
                                                      activeColor: blueColor,
                                                      value:
                                                          (state.jobSheetDetails!
                                                                      .items![3]
                                                                  ['checked'] ==
                                                              true),
                                                      onChanged: null),
                                                ),
                                                const Text(
                                                  'Tape',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Checkbox(
                                                      activeColor: blueColor,
                                                      value:
                                                          (state.jobSheetDetails!
                                                                      .items![5]
                                                                  ['checked'] ==
                                                              true),
                                                      onChanged: null),
                                                ),
                                                const Text(
                                                  'Mirror RH',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Checkbox(
                                                          activeColor:
                                                              blueColor,
                                                          value: (state
                                                                      .jobSheetDetails!
                                                                      .items![7]
                                                                  ['checked'] ==
                                                              true),
                                                          onChanged: null),
                                                    ),
                                                    const Text(
                                                      'Mats',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                if (state.jobSheetDetails!
                                                        .items![7]['checked'] ==
                                                    true)
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      "(${state.jobSheetDetails!.items![7]['value']})",
                                                      style: const TextStyle(
                                                          backgroundColor:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                              ],
                                            ),

                                            /*
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Checkbox(
                                                          activeColor:
                                                              blueColor,
                                                          value:  (state.jobSheetDetails!
                                                            .items !=
                                                        null &&
                                                    state.jobSheetDetails!
                                                            .items!.length >
                                                        9 &&
                                                    state.jobSheetDetails!
                                                            .items![9] !=
                                                        null &&
                                                    state.jobSheetDetails!
                                                        .items![9].isNotEmpty &&
                                                    state.jobSheetDetails!
                                                                .items![9]
                                                            ['checked'] ==
                                                        true),
                                                      onChanged: null),
                                                         
                                                    ),
                                                    const Text(
                                                      'Wheelcap',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                if (state.jobSheetDetails!
                                                            .items !=
                                                        null &&
                                                    state.jobSheetDetails!
                                                            .items!.length >
                                                        9 &&
                                                    state.jobSheetDetails!
                                                            .items![9] !=
                                                        null &&
                                                    state.jobSheetDetails!
                                                        .items![9].isNotEmpty &&
                                                    state.jobSheetDetails!
                                                                .items![9]
                                                            ['checked'] ==
                                                        true)
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      "(${state.jobSheetDetails!.items![9]['value']})",
                                                      style: const TextStyle(
                                                          backgroundColor:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                              ],
                                            ),

                                            */
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  (state.jobSheetDetails!.customerComplaints!
                                          .isNotEmpty)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Customer Complaint:',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        customerComplaintsList
                                                            .length;
                                                    i++)
                                                  ListTile(
                                                    dense: true,
                                                    leading: Transform.scale(
                                                      scale: 0.7,
                                                      child: Checkbox(
                                                        activeColor: blueColor,
                                                        checkColor: whiteColor,
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,
                                                        value:
                                                            customerComplaintsList[
                                                                        i][
                                                                    'status'] ==
                                                                1,
                                                        onChanged:
                                                            (bool? value) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  value ?? false
                                                                      ? "Are you sure you want to mark this task as complete?"
                                                                      : "Are you sure you want to mark this task as incomplete?",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color:
                                                                              blackColor),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: const ButtonStyle(
                                                                        foregroundColor:
                                                                            MaterialStatePropertyAll(
                                                                                blackColor),
                                                                        backgroundColor:
                                                                            MaterialStatePropertyAll(primaryColor)),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        customerComplaintsList[i]['status'] = value!
                                                                            ? 1
                                                                            : 0;
                                                                        context
                                                                            .read<JobSheetDetailsBloc>()
                                                                            .add(
                                                                              UpdateCustomerComplaints(
                                                                                formData: customerComplaintsList,
                                                                                id: state.jobSheetDetails!.id.toString(),
                                                                              ),
                                                                            );
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        "Change"),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    title: Transform.translate(
                                                      offset:
                                                          const Offset(-16, 0),
                                                      child: Text(
                                                        "${i + 1}.${state.jobSheetDetails!.customerComplaints![i]['task']}",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          decoration: customerComplaintsList[
                                                                          i][
                                                                      'status'] ==
                                                                  1
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                          color: customerComplaintsList[
                                                                          i][
                                                                      'status'] ==
                                                                  1
                                                              ? hintTextColor
                                                              : blackColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              color: Color.fromARGB(
                                                  255, 207, 207, 207),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (state.jobSheetDetails!.vehicleFrontThumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!.vehicleFrontThumb.toString() !=
                                                      null ||
                                              state.jobSheetDetails!.vehicleRightThumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!.vehicleRightThumb.toString() !=
                                                      null ||
                                              state.jobSheetDetails!.vehicleLeftThumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!.vehicleLeftThumb.toString() !=
                                                      null ||
                                              state.jobSheetDetails!.vehicleRearThumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!.vehicleRearThumb.toString() !=
                                                      null ||
                                              state.jobSheetDetails!
                                                      .vehicleDashboardThumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!
                                                          .vehicleDashboardThumb
                                                          .toString() !=
                                                      null ||
                                              state.jobSheetDetails!
                                                      .vehicleDickeyThumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!.vehicleDickeyThumb.toString() != null)
                                          ? Text(
                                              'Vehicle Images:',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            )
                                          : SizedBox.shrink(),
                                      Column(
                                        children: [
                                          Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                spacing: 30,
                                                children: [
                                                  if (state.jobSheetDetails!
                                                      .vehicleFrontThumb
                                                      .toString()
                                                      .isNotEmpty)
                                                    buildImageItem(
                                                        sliderImage[0],
                                                        'Front',
                                                        context),

                                                  ///
                                                  if (state.jobSheetDetails!
                                                      .vehicleRightThumb
                                                      .toString()
                                                      .isNotEmpty)
                                                    buildImageItem(
                                                        sliderImage[1],
                                                        'Right View',
                                                        context),
                                                  ////
                                                  if (state.jobSheetDetails!
                                                      .vehicleLeftThumb
                                                      .toString()
                                                      .isNotEmpty)
                                                    buildImageItem(
                                                        sliderImage[2],
                                                        'Left View',
                                                        context),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                spacing: 30,
                                                children: [
                                                  if (state.jobSheetDetails!
                                                      .vehicleRearThumb
                                                      .toString()
                                                      .isNotEmpty)
                                                    buildImageItem(
                                                        sliderImage[3],
                                                        'Rear View',
                                                        context),
                                                  if (state.jobSheetDetails!
                                                      .vehicleDashboardThumb
                                                      .toString()
                                                      .isNotEmpty)
                                                    buildImageItem(
                                                        sliderImage[4],
                                                        'Dashboard',
                                                        context),
                                                  if (state.jobSheetDetails!
                                                      .vehicleDickeyThumb
                                                      .toString()
                                                      .isNotEmpty)
                                                    buildImageItem(
                                                        sliderImage[5],
                                                        'Engine',
                                                        context),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (state.jobSheetDetails!.image1Thumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!
                                                          .image1Thumb !=
                                                      null ||
                                              state.jobSheetDetails!
                                                      .image2Thumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!
                                                          .image2Thumb !=
                                                      null ||
                                              state.jobSheetDetails!.image3Thumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!
                                                          .image3Thumb !=
                                                      null ||
                                              state.jobSheetDetails!.image4Thumb
                                                      .toString()
                                                      .isNotEmpty &&
                                                  state.jobSheetDetails!
                                                          .image4Thumb !=
                                                      null)
                                          ? Text(
                                              'Additional Images:',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: blackColorLight),
                                            )
                                          : SizedBox.shrink(),
                                      Row(
                                        children: [
                                          Wrap(
                                            spacing: 30,
                                            children: [
                                              if (state
                                                  .jobSheetDetails!.image1Thumb
                                                  .toString()
                                                  .isNotEmpty)
                                                buildAdditionalImage(
                                                    additionalImages[0],
                                                    'Image1',
                                                    context),
                                              if (state
                                                  .jobSheetDetails!.image2Thumb
                                                  .toString()
                                                  .isNotEmpty)
                                                buildAdditionalImage(
                                                    additionalImages[1],
                                                    'Image2',
                                                    context),
                                              if (state
                                                  .jobSheetDetails!.image3Thumb
                                                  .toString()
                                                  .isNotEmpty)
                                                buildAdditionalImage(
                                                    additionalImages[2],
                                                    'Image3',
                                                    context),
                                              if (state
                                                  .jobSheetDetails!.image4Thumb
                                                  .toString()
                                                  .isNotEmpty)
                                                buildAdditionalImage(
                                                    additionalImages[3],
                                                    'Image4',
                                                    context),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        color:
                                            Color.fromARGB(255, 207, 207, 207),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        }));
  }

  Widget buildImageItem(String imageUrl, String title, BuildContext context) {
    if (imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }
    int index = sliderImage.indexOf(imageUrl);

    return GestureDetector(
      onTap: () {
        List<String> imageUrls = [];
        List<String> titles = [];
        for (int i = index; i < index + sliderImage.length; i++) {
          imageUrls.add(sliderImage[i % sliderImage.length]);
          titles.add([
            '     Front View',
            '    Right View',
            '     Left View',
            '     Rear View',
            '     Dashboard',
            '       Engine',
          ][i % sliderImage.length]);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleImagePreview(
              initialIndex: 0,
              imageUrls: imageUrls,
              titles: titles,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // Wrap the CachedNetworkImage with Hero
            tag: 'vehicle_image_${imageUrl}_${index}', // Unique tag per image
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.8, color: Colors.grey[400]!),
              ),
              child: imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 80,
                        width: 80,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error,
                              size: 68, color: Colors.grey);
                        },
                      ),
                    )
                  : const Icon(imageNotSupport, size: 68, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAdditionalImage(
      String imageUrls, String title, BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }
    int index = additionalImages.indexOf(imageUrls);
    return GestureDetector(
      onTap: () {
        List<String> imageUrls = [];
        List<String> titles = [];
        for (int i = index; i < index + additionalImages.length; i++) {
          imageUrls.add(additionalImages[i % additionalImages.length]);
          titles.add([
            'Additional Image1',
            'Additional Image2',
            'Additional Image3',
            'Additional Image4',
          ][i % additionalImages.length]);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdditionalImagePreview(
              initialIndex: 0,
              imageUrls: imageUrls,
              titles: titles,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.8, color: Colors.grey[400]!),
            ),
            child: imageUrls.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls,
                      height: 80,
                      width: 80,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error,
                            size: 68, color: Colors.grey);
                      },
                    ),
                  )
                : const Icon(imageNotSupport, size: 68, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                color: blackColor, fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
