import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/base_layout.dart';
import 'package:mech_manager/components/skeletone/form_field_title.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/data.dart';
import 'package:mech_manager/models/vehicle_model.dart';
import 'package:mech_manager/modules/invoice/invoice_listening.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_state.dart';

import '../../config/colors.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  final FocusNode vehiclefFocusNode = FocusNode();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController kmsController = TextEditingController();
  String manufacturerController = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isVisibleVehicleDetails = false;

  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  List<dynamic> assignMechanicList = [];
  List<dynamic> tasksList = [];
  final ValueNotifier<String> activeRouteNotifier = ValueNotifier<String>('');

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
      listener: (context, state) {},
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: WillPopScope(
            onWillPop: () async {
              appConfig.toastCount = 0;
              appConfig.additonalImageCount = 0;
              context
                  .read<JobSheetBloc>()
                  .add(const FetchInvoiceList(status: jobSheetStatus.success));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InvoiceListening()),
              );
              return true;
            },
            child: BaseLayout(
                activeRouteNotifier: activeRouteNotifier,
                title: 'MechManager Admin',
                closeDrawer: _toggleDrawer,
                isDrawerOpen: _isDrawerOpen,
                //  showFloatingActionButton: true,
                routeWidgets: [
                  GestureDetector(
                    onTap: () {
                      activeRouteNotifier.value = "/dashboard_page";
                      //  Navigator.pushNamed(context, '/dashboard_page');
                      Navigator.of(context)
                          .pushReplacementNamed('/dashboard_page');
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(color: blueColor),
                    ),
                  ),
                  const Text(" / "),
                  const Text(
                    "Job Card",
                    style: TextStyle(color: greyColor),
                  ),
                ],
                key: _scaffoldKey,
                body: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
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
                            'Invoice Create',
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
                                    const FormFieldTitle(
                                        title: "Vehicle Details:"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Vehicle number:",
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
                                              BlocBuilder<SearchBloc,
                                                      SearchState>(
                                                  builder: (context, state) {
                                                return Autocomplete<
                                                    VehicleModel>(
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingValue) {
                                                    if (textEditingValue
                                                        .text.isEmpty) {
                                                      return [];
                                                    }
                                                    return state.vehicleDetails!
                                                        .where((element) => element
                                                            .vehiclenumber!
                                                            .toLowerCase()
                                                            .contains(
                                                                textEditingValue
                                                                    .text
                                                                    .toLowerCase()));
                                                  },
                                                  displayStringForOption:
                                                      (vehicle) => vehicle
                                                          .vehiclenumber!,
                                                  fieldViewBuilder: (BuildContext
                                                          context,
                                                      TextEditingController
                                                          fieldTextEditingController,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback
                                                          onfieldSubmitted) {
                                                    return TextField(
                                                      controller:
                                                          fieldTextEditingController,
                                                      focusNode: _validate
                                                          ? vehiclefFocusNode
                                                          : fieldFocusNode,

                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      // focusNode: fieldFocusNode,
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                            color:
                                                                hintTextColor,
                                                            fontFamily: 'meck',
                                                            fontSize: 12),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        16),
                                                        errorText: _validate
                                                            ? "Please enter correct vehicle number"
                                                            : null,
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
                                                            'MH 15 AB 2000',
                                                        filled: true,
                                                        fillColor:
                                                            textfieldColor,
                                                      ),
                                                      onChanged: (text) {
                                                        if (text.isNotEmpty) {
                                                          context
                                                              .read<
                                                                  SearchBloc>()
                                                              .add(SearchVehicleDetails(
                                                                  searchKeyword:
                                                                      text));
                                                          vehicleNumberController =
                                                              fieldTextEditingController;
                                                        }
                                                      },
                                                    );
                                                  },
                                                  onSelected: (suggestion) {
                                                    setState(() {
                                                      vehicleNumberController
                                                              .text =
                                                          suggestion
                                                              .vehiclenumber!;
                                                      vehicleNameController
                                                              .text =
                                                          suggestion
                                                              .vehiclename!;
                                                      fullNameController.text =
                                                          suggestion.fullName!;
                                                      adressController.text =
                                                          suggestion.address!;
                                                      emailController.text =
                                                          suggestion.email!;
                                                      phoneNumberController
                                                              .text =
                                                          suggestion
                                                              .mobileNumber!;
                                                      if (suggestion
                                                              .manufacturers!
                                                              .isNotEmpty &&
                                                          suggestion
                                                                  .manufacturers !=
                                                              null) {
                                                        manufacturerController =
                                                            suggestion
                                                                .manufacturers!;
                                                      } else {
                                                        manufacturerController =
                                                            "";
                                                      }
                                                      vehicleNumberController
                                                              .selection =
                                                          TextSelection.fromPosition(
                                                              TextPosition(
                                                                  offset: vehicleNumberController
                                                                      .text
                                                                      .length));
                                                    });
                                                  },
                                                );
                                              })
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
                                                "Kms :",
                                                style: TextStyle(
                                                    fontSize: 12.5,
                                                    color: blackColor),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              TextField(
                                                controller: kmsController,
                                                // focusNode: fieldFocusNode,
                                                style: TextStyle(fontSize: 13),
                                                decoration:
                                                    const InputDecoration(
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
                                                  hintText: "Enter vehicle Kms",
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

                                        (isVisibleVehicleDetails)
                                            ? Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Vehical name:",
                                                      style: TextStyle(
                                                          fontSize: 12.5,
                                                          color: blackColor),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          vehicleNameController,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          const InputDecoration(
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
                                                                        16),
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
                                                            "Enter vehicle name",
                                                        filled: true,
                                                        fillColor:
                                                            textfieldColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Expanded(child: SizedBox.shrink())
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    (isVisibleVehicleDetails)
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Manufacturer:",
                                                      style: TextStyle(
                                                          fontSize: 12.5,
                                                          color: blackColor),
                                                    ),
                                                    DropdownButtonFormField2(
                                                      value: manufacturerController
                                                              .isNotEmpty
                                                          ? manufacturerController
                                                          : null,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.5,
                                                                    horizontal:
                                                                        10),
                                                        isDense: true,
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
                                                        filled: true,
                                                        fillColor:
                                                            textfieldColor,
                                                      ),
                                                      hint: const Text(""),

                                                      // dropdownMaxHeight: 450,
                                                      isExpanded: true,
                                                      items: manufacturerCompaniesList
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value:
                                                              value.toString(),
                                                          child: Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 13,
                                                              // wordSpacing: 3,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          manufacturerController =
                                                              value!.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 20),

                                              //manufatt
                                              Expanded(
                                                  child: SizedBox.shrink()),
                                              const SizedBox(width: 20),
                                              const Expanded(
                                                child: SizedBox
                                                    .shrink(), // Empty placeholder
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              ),
                              if (!isVisibleVehicleDetails)
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisibleVehicleDetails = true;
                                      });
                                    },
                                    child: Text('add'))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ))),
      ),
    );
  }
}
