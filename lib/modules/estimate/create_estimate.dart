import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/job_sheet_listening.dart';

import '../../components/skeletone/center_loader.dart';
import '../../config.dart';
import '../../config/colors.dart';
import '../job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import '../job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';

class CreateEstimatePage extends StatefulWidget {
  const CreateEstimatePage({super.key});

  @override
  State<CreateEstimatePage> createState() => _CreateEstimatePageState();
}

class _CreateEstimatePageState extends State<CreateEstimatePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _formKey = GlobalKey<FormState>();
  bool _isDrawerOpen = true;
  List<dynamic> assignMechanicList = [];
  List<dynamic> tasksList = [];
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/estimate_listing');

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobSheetBloc, JobSheetState>(
        listener: (context, state) {
          if (state.status == jobSheetStatus.sending) {
            CenterLoader.show(context);
          }
          if (state.status == jobSheetStatus.submitSuccess) {
            CenterLoader.hide();
            Fluttertoast.showToast(
                toastLength: Toast.LENGTH_SHORT,
                msg: "Job card added successfully",
                backgroundColor: successDarkColor);
            Navigator.pushNamed(context, "/job_sheet_listing");
          } else if (state.status == jobSheetStatus.submitFailure) {
            CenterLoader.hide();
          }
        },
        child: WillPopScope(
            onWillPop: () async {
              appConfig.toastCount = 0;
              appConfig.additonalImageCount = 0;
              context
                  .read<JobSheetBloc>()
                  .add(const FetchJobSheets(status: jobSheetStatus.success));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobSheetListing()),
              );
              return true;
            },
            child: BaseLayout(
                title: 'MechManager Admin',
                closeDrawer: _toggleDrawer,
                isDrawerOpen: _isDrawerOpen,
                showFloatingActionButton: true,
                activeRouteNotifier: activeRouteNotifier,
                body: Form(
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
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Create Estimate',
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
                                    side: BorderSide(
                                        color: Colors.grey.shade300)),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
                                ),
                              ),
                            ]),
                      ),
                    )))));
  }
}
