import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/mechanic_page/mechanic_list_row.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/colors.dart';

import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

class MechanicsPage extends StatefulWidget {
  const MechanicsPage({super.key});

  @override
  State<MechanicsPage> createState() => _MechanicsPageState();
}

class _MechanicsPageState extends State<MechanicsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/mechanics_listing');
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _fetchInitialMechanics();
    _scrollController.addListener(_onScroll);
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

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      _searchSparePart();
    });
  }

  void _searchSparePart() {
    final keyword = searchController.text;
    context.read<JobSheetBloc>().add(FetchMechanics(
          status: jobSheetStatus.success,
          timestamp: null,
          searchKeyword: keyword,
          direction: 'down',
        ));
  }

  void _onScroll() {
    final jobSheetState = context.read<JobSheetBloc>().state;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !jobSheetState.hasReachedMax!) {
      context.read<JobSheetBloc>().add(FetchMechanics(
            status: jobSheetStatus.success,
            timestamp: jobSheetState.lastTimestamp,
            searchKeyword: searchController.text,
            direction: 'down',
          ));
    }
  }

  void _fetchInitialMechanics() {
    context
        .read<JobSheetBloc>()
        .add(const FetchMechanics(status: jobSheetStatus.loading));
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'MechManager Admin',
      closeDrawer: _toggleDrawer,
      isDrawerOpen: _isDrawerOpen,
      activeRouteNotifier: activeRouteNotifier,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mechanics',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _fetchInitialMechanics();
                        },
                        child: const SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: greyColor,
                                size: 22,
                              ),
                              Text(
                                'Reset all',
                                style: TextStyle(color: greyColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                        suffixIcon: Container(
                          // width: 50,
                          // height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: primaryColor,
                          ),
                          child: const Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                          // borderRadius:
                          //     BorderRadius
                          //         .all(Radius
                          //             .circular(
                          //                 5)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        isDense: true,
                        hintText: "Search by mechanic name",
                        hintStyle:
                            TextStyle(fontSize: 12, color: blackColorLight)
                        // filled: true,
                        // fillColor:
                        //     textfieldColor,

                        ),
                  ),
                ),
              ),
              BlocConsumer<JobSheetBloc, JobSheetState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == jobSheetStatus.initial ||
                      state.status == jobSheetStatus.loading) {
                    return const CenterLoader();
                  }
                  if (state.mechanicListing.isEmpty) {
                    return const Text('No record found');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return (index >= state.mechanicListing.length)
                          ? const CenterLoader()
                          : MechanicListRow(
                              mechanictlist: state.mechanicListing[index],
                            );
                    },
                    // controller: _scrollController,
                    itemCount: state.mechanicListing.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
