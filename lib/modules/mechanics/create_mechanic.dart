import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/mechanics/mechanics_listening.dart';

import '../job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';

class CreateMechanic extends StatefulWidget {
  const CreateMechanic({super.key});

  @override
  State<CreateMechanic> createState() => _CreateMechanicState();
}

class _CreateMechanicState extends State<CreateMechanic>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier = ValueNotifier<String>('');
  final _formKey = GlobalKey<FormState>();
  bool _nameValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode mechanicFocusNode = FocusNode();
  TextEditingController mechanicNameController = TextEditingController();
  TextEditingController taskSescriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
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
    return BlocListener<JobSheetBloc, JobSheetState>(
      listener: (context, state) {
        if (state.status == jobSheetStatus.mechanicSuccess) {
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "Mechanic added successfully",
            backgroundColor: successDarkColor,
          );

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MechanicsPage()));
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        //  child:
        //  WillPopScope(
        //   onWillPop: ()async {
        //     appConfig.toastCount = 0;
        //           appConfig.additonalImageCount = 0;
        //           context
        //               .read<JobSheetBloc>()
        //               .add(const FetchMechanics(status: jobSheetStatus.success));
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const MechanicsPage()),
        //           );
        //           return true;
        //   },
        child: BaseLayout(
          title: 'MechManager Admin',
          closeDrawer: _toggleDrawer,
          isDrawerOpen: _isDrawerOpen,
          activeRouteNotifier: activeRouteNotifier,
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: _formKey,
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
                          'Mechanic Create',
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 15, bottom: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  "Mechanic Name:",
                                                  style: TextStyle(
                                                      fontSize: 12.5,
                                                      color: blackColor),
                                                ),
                                                Icon(Icons.star,
                                                    color: redColor, size: 8)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            TextField(
                                              controller:
                                                  mechanicNameController,
                                              focusNode: mechanicFocusNode,
                                              style: TextStyle(fontSize: 13),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    color: hintTextColor,
                                                    fontFamily: 'Mulish',
                                                    fontSize: 14),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                isDense: true,
                                                hintText: "Enter  name",
                                                filled: true,
                                                errorText: _nameValidate
                                                    ? "The mechanic name field is required"
                                                    : null,
                                                fillColor: textfieldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Task description:",
                                              style: TextStyle(
                                                  fontSize: 12.5,
                                                  color: blackColor),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            TextField(
                                              controller:
                                                  taskSescriptionController,
                                              // focusNode: fieldFocusNode,
                                              style: TextStyle(fontSize: 13),
                                              decoration: const InputDecoration(
                                                hintStyle: TextStyle(
                                                    color: hintTextColor,
                                                    fontFamily: 'Mulish',
                                                    fontSize: 14),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                hintText:
                                                    "EnterTask description",
                                                filled: true,
                                                fillColor: textfieldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              20), // Space between the TextFields
                                      Expanded(child: SizedBox.shrink()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, bottom: 15),
                              child: SizedBox(
                                height: 37,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _nameValidate =
                                          mechanicNameController.text.isEmpty;

                                      mechanicFocusNode.requestFocus();
                                    });
                                    if (_formKey.currentState!.validate() && _nameValidate) {
                                      Map<String, dynamic> formData = {
                                        "id": "",
                                        "mechanic_name": mechanicNameController
                                            .text
                                            .toString(),
                                        "task_description":
                                            taskSescriptionController.text
                                                .toString(),
                                      };
                                      context.read<JobSheetBloc>().add(
                                          CreateMechanicEvent(
                                              formData: formData));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontFamily: 'meck',
                                      fontSize: 14,
                                      color: blackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
