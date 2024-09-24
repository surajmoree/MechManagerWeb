import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/invoice_page/invoice_list_row.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

class InvoiceListening extends StatefulWidget {
  const InvoiceListening({super.key});

  @override
  State<InvoiceListening> createState() => _InvoiceListeningState();
}

class _InvoiceListeningState extends State<InvoiceListening>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  Timer? _debounce;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/invoice_listing');
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  void _onScroll() {
    final jobSheetState = context.read<JobSheetBloc>().state;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !jobSheetState.hasReachedMax!) {
      context.read<JobSheetBloc>().add(FetchInvoiceList(
            status: jobSheetStatus.success,
            timestamp: jobSheetState.lastTimestamp,
            searchKeyword: searchController.text,
            direction: 'down',
          ));
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      _searchInvoice();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    // _scrollController.dispose();
    searchController.dispose();

    super.dispose();
  }

  void _searchInvoice() {
    final keyword = searchController.text;
    context.read<JobSheetBloc>().add(FetchInvoiceList(
          status: jobSheetStatus.success,
          timestamp: null,
          searchKeyword: keyword,
          direction: 'down',
        ));
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
                          'Invoices',
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // context
                            //     .read<JobSheetBloc>()
                            //     .add(const FetchEstimateList(
                            //       status: jobSheetStatus.success,
                            //     ));
                            //      _fetchInitialEstimate();
                            // searchController.clear();
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
                        )
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
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
                          hintText: "Search by vehicle & customer name",
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
                    listener: (conetxt, state) {},
                    builder: (context, state) {
                      if (state.status == jobSheetStatus.initial ||
                          state.status == jobSheetStatus.loading) {
                        return const CenterLoader();
                      }
                      return ListView.builder(
                         shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return (index >= state.invoiceListing.length)
                              ? const CenterLoader()
                              : InvoiceListRow(
                                  invoiceList: state.invoiceListing[index],
                                );
                        },
                        itemCount: state.invoiceListing.length,
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
