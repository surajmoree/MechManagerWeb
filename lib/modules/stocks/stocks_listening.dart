import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/skeletone/center_loader.dart';
import 'package:mech_manager/components/stock_page/stock_list_row.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

enum StockFilter { inStock, outOfStock, bestSeller }

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage>
    with SingleTickerProviderStateMixin {
  StockFilter selectedFilter = StockFilter.inStock;
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool stockColor = false;

  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _fetchInitialStock();
    _scrollController.addListener(_onScroll);
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

  void _fetchInitialStock() {
    context
        .read<JobSheetBloc>()
        .add(const FetchStock(status: jobSheetStatus.loading));
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
      _stockSearch();
    });
  }

  void _onScroll() {
    final jobSheetState = context.read<JobSheetBloc>().state;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !jobSheetState.hasReachedMax!) {
      context.read<JobSheetBloc>().add(FetchStock(
            status: jobSheetStatus.success,
            timestamp: jobSheetState.lastTimestamp,
            searchKeyword: searchController.text,
            direction: 'down',
          ));
    }
  }

  void _stockSearch() {
    final keyword = searchController.text;
    context.read<JobSheetBloc>().add(FetchStock(
          status: jobSheetStatus.success,
          timestamp: null,
          searchKeyword: keyword,
          direction: 'down',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'MechManager Admin',
      closeDrawer: _toggleDrawer,
      isDrawerOpen: _isDrawerOpen,
      activeRouteNotifier: activeRouteNotifier,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Stocks',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: _fetchInitialStock,
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
              Card(
                elevation: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      suffixIcon: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: primaryColor,
                        ),
                        child: const Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      isDense: true,
                      hintText: "Search by stock name",
                      hintStyle:
                          const TextStyle(fontSize: 12, color: blackColorLight),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  BlocBuilder<JobSheetBloc, JobSheetState>(
                      builder: (context, state) {
                    return Card(
                      elevation: 0,
                      child: Container(
                        color: whiteColor,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = StockFilter.inStock;
                                  });
                                  context.read<JobSheetBloc>().add(FetchStock(
                                      filter: 'in_stock',
                                      status: jobSheetStatus.initial));
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: selectedFilter == StockFilter.inStock
                                        ? Colors.amber
                                        : stockbuttoncolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Center(
                                            child: Text(state
                                                .stocklisting.length
                                                .toString())),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: whiteColor,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'In Stock',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = StockFilter.outOfStock;
                                  });
                                  context.read<JobSheetBloc>().add(FetchStock(
                                      filter: 'out_of_stock',
                                      status: jobSheetStatus.initial));
                                },
                                child: Container(
                                  height: 40,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color:
                                        selectedFilter == StockFilter.outOfStock
                                            ? Colors.amber
                                            : stockbuttoncolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Center(child: Text('5')),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: whiteColor,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Out Of Stock',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = StockFilter.bestSeller;
                                  });
                                  context.read<JobSheetBloc>().add(FetchStock(
                                      filter: 'max_sell',
                                      status: jobSheetStatus.initial));
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color:
                                        selectedFilter == StockFilter.bestSeller
                                            ? Colors.amber
                                            : stockbuttoncolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Center(child: Text('5')),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: whiteColor,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Best Seller',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  if (selectedFilter == StockFilter.inStock)
                    BlocConsumer<JobSheetBloc, JobSheetState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.status == jobSheetStatus.initial ||
                            state.status == jobSheetStatus.loading) {
                          return const CenterLoader();
                        }
                        if (state.stocklisting.isEmpty) {
                          return const Text('No record found');
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.stocklisting.length,
                          itemBuilder: (context, index) {
                            return StockListRow(
                              stoklist: state.stocklisting[index],
                            );
                          },
                        );
                      },
                    ),

                  if (selectedFilter == StockFilter.outOfStock)
                    BlocConsumer<JobSheetBloc, JobSheetState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.status == jobSheetStatus.initial ||
                            state.status == jobSheetStatus.loading) {
                          return const CenterLoader();
                        }
                        if (state.stocklisting.isEmpty) {
                          return const Text('No record found');
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.stocklisting.length,
                          itemBuilder: (context, index) {
                            return StockListRow(
                              stoklist: state.stocklisting[index],
                            );
                          },
                        );
                      },
                    ),

                  if (selectedFilter == StockFilter.bestSeller)
                    BlocConsumer<JobSheetBloc, JobSheetState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.status == jobSheetStatus.initial ||
                            state.status == jobSheetStatus.loading) {
                          return const CenterLoader();
                        }
                        if (state.stocklisting.isEmpty) {
                          return const Text('No record found');
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.stocklisting.length,
                          itemBuilder: (context, index) {
                            return StockListRow(
                              stoklist: state.stocklisting[index],
                            );
                          },
                        );
                      },
                    ),

                  // BlocConsumer<JobSheetBloc, JobSheetState>(
                  //   listener: (context, state) {},
                  //   builder: (context, state) {
                  //     if (state.status == jobSheetStatus.initial ||
                  //         state.status == jobSheetStatus.loading) {
                  //       return const CenterLoader();
                  //     }
                  //     if (state.stocklisting.isEmpty) {
                  //       return const Text('No record found');
                  //     }

                  //     return ListView.builder(
                  //       shrinkWrap: true,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       itemCount: state.stocklisting.length,
                  //       itemBuilder: (context, index) {
                  //         return StockListRow(
                  //           stoklist: state.stocklisting[index],
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
