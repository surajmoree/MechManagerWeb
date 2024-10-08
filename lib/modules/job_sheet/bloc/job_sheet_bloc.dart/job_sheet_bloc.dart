import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/constants.dart';
import 'package:mech_manager/models/customer_info_estimate_list_model.dart';
import 'package:mech_manager/models/customer_info_invoice_list_model.dart';
import 'package:mech_manager/models/customer_info_jobcard_list_model.dart';
import 'package:mech_manager/models/customer_listening_model.dart';
import 'package:mech_manager/models/dashboard_model.dart';
import 'package:mech_manager/models/estimate_listiening_model.dart';
import 'package:mech_manager/models/invoice_listening_model.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/models/labour_listeningmodel.dart';
import 'package:mech_manager/models/mechanic_listeningmodel.dart';
import 'package:mech_manager/models/spare_part_model.dart';
import 'package:mech_manager/models/stock_listening_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/network/repositories/authentication.dart';
import 'package:mech_manager/network/repositories/job_sheet_repository.dart';

class JobSheetBloc extends Bloc<JobSheetEvent, JobSheetState> {
  JobSheetBloc() : super(JobSheetState()) {
    on<FetchJobSheets>(_onFetchJobSheets);
    on<AddJobSheet>(_onAddJobSheet);
    on<FetchEstimateList>(_onFetchEstimateList);
    on<DeleteJobSheet>(_onDeleteJobSheet);
    on<FetchDashboard>(_onFetchDashboard);
    on<DeleteEstimate>(_onDeleteEstimate);
    on<FetchInvoiceList>(_onFetchInvoiceList);
    on<DeleteInvoice>(_onDeleteInvoice);
    on<CreateAddInvoice>(_onCreateAddInvoice);
    on<AddEstimate>(_onAddEstimate);
    on<FetchSparePartList>(_onFetchSparePartList);
    on<FetchMechanics>(_onFetchMechanicList);
    on<DeleteMechanic>(_onDeleteMechanic);
    on<CreateMechanicEvent>(_onCreateMechanics);
    on<FetchLabour>(_onFetchLabourList);
    on<DeleteLabour>(_onDeleteLabour);
    on<CreateLabourEvent>(_onCreateLabour);
    on<ClearListingData>(_onClearListingData);
    on<FetchCustomer>(_onFetchCustomerList);
    on<CreateCustomerEvent>(_onCreateCustomer);
    on<GetCustomerInfoJobCard>(_onGetCustomerInfoJobCard);
    on<GetCustomerInfoEstimate>(_onGetCustomerInfoEstimate);
    on<GetCustomerInfoInvoice>(_onGetCustomerInfoInvoice);
    on<FetchStock>(_onFetchInStock);
    on<LogOutEvent>(_onLogOut);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();
  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  Future<void> _onAddJobSheet(
      AddJobSheet event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.sending));
    // create job sheet api call
    dynamic token = await storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.addJobSheet(jsonData);
    if (response['id'].runtimeType != Null) {
      emit(state.copyWith(status: jobSheetStatus.submitSuccess));
    } else {
      emit(state.copyWith(status: jobSheetStatus.submitFailure));
    }
    // send images
    if (response['id'] != null) {
      if (event.frontImage.path.isNotEmpty) {
        callApiForSend(event.frontImage, token, response['id'].toString(),
            'vehicle_front_img');
      }
      if (event.rightHandSideImage.path.isNotEmpty) {
        callApiForSend(event.rightHandSideImage, token,
            response['id'].toString(), 'vehicle_right_hand_img');
      }
      if (event.leftHandSideImage.path.isNotEmpty) {
        callApiForSend(event.leftHandSideImage, token,
            response['id'].toString(), 'vehicle_left_hand_img');
      }
      if (event.rearImage.path.isNotEmpty) {
        callApiForSend(event.rearImage, token, response['id'].toString(),
            'vehicle_rear_img');
      }
      if (event.dashboardImage.path.isNotEmpty) {
        callApiForSend(event.dashboardImage, token, response['id'].toString(),
            'vehicle_dashboard_img');
      }
      if (event.engineImage.path.isNotEmpty) {
        callApiForSend(event.engineImage, token, response['id'].toString(),
            'vehicle_dickey_img');
      }
      // Additional images
      if (event.image1.path.isNotEmpty) {
        callApiForSend(
            event.image1, token, response['id'].toString(), 'images1');
      }
      if (event.image2.path.isNotEmpty) {
        callApiForSend(
            event.image2, token, response['id'].toString(), 'images2');
      }
      if (event.image3.path.isNotEmpty) {
        callApiForSend(
            event.image3, token, response['id'].toString(), 'images3');
      }
      if (event.image4.path.isNotEmpty) {
        callApiForSend(
            event.image4, token, response['id'].toString(), 'images4');
      }
    }
  }

  callApiForSend(
      XFile imageFile, String token, String id, String imageType) async {
    List<int> imageData =
        await imageFile.readAsBytes(); // Works for both web and mobile

    const host = Constants.hostname;
    const protocol = Constants.protocol;

    var uri = Uri.parse(
        "$protocol://$host/update_images/$id/$imageType/${DateTime.now().microsecondsSinceEpoch}");

    var request = http.MultipartRequest("PUT", uri);

    dynamic modifiedFileName = generateUniqueFileName(imageFile.name);

    request.files.add(http.MultipartFile.fromBytes(
      imageType,
      imageData,
      filename: modifiedFileName,
    ));

    request.headers.addAll({
      'Accept': 'application/json, text/plain',
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var imageSendResponse = await request.send();
    if (imageSendResponse.statusCode == 200) {
      // Handle success
    } else {
      // Handle failure
    }
  }

  generateUniqueFileName(originalFileName) {
    dynamic timestamp = DateTime.now().microsecondsSinceEpoch;
    dynamic randomString = Random().nextInt(900000) + 100000;
    return "$timestamp-$randomString.jpg";
  }

  // get job listing data
  Future<void> _onFetchJobSheets(
      FetchJobSheets event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.status == jobSheetStatus.success) {
      return;
    }
    emit(
      state.copyWith(
          status: (event.status == jobSheetStatus.success)
              ? jobSheetStatus.success
              : jobSheetStatus.loading),
    );
    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token.toString(),
      'direction': 'down',
      'timestamp':
          event.timestamp?.toString() ?? event.lastRecordUpdatedTime.toString(),
      'search': event.searchKeyword ?? "",
      'fromDate': event.fromDate ?? "",
      'toDate': event.toDate ?? "",
    };

    final result = await jobSheetRepository.getJobSheets(jsonData);

    if (result != null && result.isNotEmpty) {
      List<JobSheetModel> jobSheetsList = result
          .map<JobSheetModel>((jsonData) => JobSheetModel.fromJson(jsonData))
          .toList();

      final bool hasReachedMax = jobSheetsList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        jobSheetsList = List.from(state.jobSheetList)..addAll(jobSheetsList);
      }

      return emit(state.copyWith(
        status: jobSheetStatus.success,
        jobSheetList: jobSheetsList,
        hasReachedMax: hasReachedMax,
        lastTimestamp: jobSheetsList.last.timestamp,
      ));
    } else {
      return emit(state.copyWith(
          status: jobSheetStatus.success,
          jobSheetList: [],
          hasReachedMax: true));
    }
  }

  //fetch dashoboard

  _onFetchDashboard(FetchDashboard event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(
          status: (event.status == jobSheetStatus.success)
              ? jobSheetStatus.success
              : jobSheetStatus.loading),
    );
    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token!.toString(),
    };
    final result = await jobSheetRepository.dashboardData(jsonData);

    if (result != null && result.isNotEmpty) {
      return emit(state.copyWith(
          status: jobSheetStatus.success,
          dashboardModel: DashboardModel.fromJson(result)));
    } else {
      return emit(state.copyWith(
        status: jobSheetStatus.failure,
      ));
    }
  }

  //delete jobsheet
  _onDeleteJobSheet(DeleteJobSheet event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.updating));
    dynamic token = await storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final result = await jobSheetRepository.deleteJobSheet(jsonData);

    if (result['status'] == "success") {
      // state.jobSheetList
      //     .removeWhere((element) => element.id.toString() == event.id);
      emit(state.copyWith(
          status: jobSheetStatus.success, jobSheetList: state.jobSheetList));
    }
  }

  Future<void> _onFetchEstimateList(
      FetchEstimateList event, Emitter<JobSheetState> emit) async {
    // if (state.hasReachedMax! && event.timestamp != null) {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }
    emit(
      state.copyWith(
          status: (event.status == jobSheetStatus.success)
              ? jobSheetStatus.success
              : jobSheetStatus.loading),
    );
    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction ?? 'down',
      'search': event.searchKeyword ?? '',
    };
    print("time==================${event.timestamp.toString()}");
    final result = await jobSheetRepository.getEstimate(jsonData);
    print('estimate listning from bloc $result');

    if (result != null && result.isNotEmpty) {
      List<EstimateListingModel> estimateList = result
          .map<EstimateListingModel>(
              (jsonData) => EstimateListingModel.fromJson(jsonData))
          .toList();

      final bool hasReachedMax = estimateList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        estimateList = List.from(state.estimateListing)..addAll(estimateList);
      }
      return emit(state.copyWith(
        status: jobSheetStatus.success,
        estimateListing: estimateList,
        lastTimestamp: estimateList.last.timestamp,
        hasReachedMax: hasReachedMax,
      ));
    } else {
      return emit(state.copyWith(
        status: jobSheetStatus.failure,
      ));
    }
  }

  ////////////////////delete Estimate////////////deleteInvoice

  _onDeleteEstimate(DeleteEstimate event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.updating));
    dynamic token = await storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final result = await jobSheetRepository.deleteEstimate(jsonData);

    if (result['status'] == "Success") {
      // state.jobSheetList
      //     .removeWhere((element) => element.id.toString() == event.id);
      emit(state.copyWith(
          status: jobSheetStatus.success,
          estimateListing: state.estimateListing));
    }
  }

  _onFetchInvoiceList(
      FetchInvoiceList event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }
    emit(
      state.copyWith(
          status: (event.status == jobSheetStatus.success)
              ? jobSheetStatus.success
              : jobSheetStatus.loading),
    );
    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token!.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction ?? 'down',
      'search': event.searchKeyword ?? '',
    };

    final result = await jobSheetRepository.getInvoice(jsonData);

    if (result != null && result.isNotEmpty) {
      List<InvoiceListingModel> invoiceList = result
          .map<InvoiceListingModel>(
              (jsonData) => InvoiceListingModel.fromJson(jsonData))
          .toList();

      final bool hasReachedMax = invoiceList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        invoiceList = List.from(state.invoiceListing)..addAll(invoiceList);
      }
      // Save the new invoice list to the Isar database

      return emit(state.copyWith(
          status: jobSheetStatus.success,
          invoiceListing: invoiceList,
          lastTimestamp: invoiceList.last.timestamp,
          hasReachedMax: hasReachedMax));
    } else {
      return emit(state.copyWith(
        status: jobSheetStatus.failure,
      ));
    }
  }

  _onFetchLabourList(FetchLabour event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }

    emit(state.copyWith(
        status: (event.status == jobSheetStatus.success)
            ? jobSheetStatus.success
            : jobSheetStatus.loading));

    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token!.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction ?? 'down',
      'search': event.searchKeyword ?? '',
    };

    final result = await jobSheetRepository.getLabour(jsonData);

    if (result != null && result.isNotEmpty) {
      List<LabourModelListingModel> labourList = result
          .map<LabourModelListingModel>(
              (jsonData) => LabourModelListingModel.fromJson(jsonData))
          .toList();

      final bool hasReachedMax = labourList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        labourList = List.from(state.labourListing)..addAll(labourList);
      }
      return emit(state.copyWith(
          status: jobSheetStatus.success,
          labourListing: labourList,
          lastTimestamp: labourList.last.timestamp,
          hasReachedMax: hasReachedMax));
    } else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }

  _onFetchInStock(FetchStock event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }

    emit(state.copyWith(
        status: (event.status == jobSheetStatus.success)
            ? jobSheetStatus.success
            : jobSheetStatus.loading));

    dynamic token = await storage.read(key: 'token');

    Map<String, String> jsonData = {
      'token': token!.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction ?? 'down',
      'search': event.searchKeyword ?? '',
      'filter': event.filter ?? 'in_stock',
    };

    final result = await jobSheetRepository.getStock(jsonData);

    if (result != null && result.isNotEmpty) {
      List<StockListeningModel> stocklist = result
          .map<StockListeningModel>(
              (jsonData) => StockListeningModel.fromJson(jsonData))
          .toList();
      final bool hasReachedMax = stocklist.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        stocklist = List.from(state.stocklisting)..addAll(stocklist);
      }

      return emit(state.copyWith(
          status: jobSheetStatus.success,
          stocklisting: stocklist,
          lastTimestamp: stocklist.last.timestamp,
          hasReachedMax: hasReachedMax));
    }else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }

  _onFetchCustomerList(FetchCustomer event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }
    emit(state.copyWith(
        status: (event.status == jobSheetStatus.success)
            ? jobSheetStatus.success
            : jobSheetStatus.loading));

    dynamic token = await storage.read(key: 'token');

    Map<String, String> jsonData = {
      'token': token!.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction ?? 'down',
      'search': event.searchKeyword ?? '',
    };

    final result = await jobSheetRepository.getCustomer(jsonData);

    if (result != null && result.isNotEmpty) {
      List<CustomerListingModel> customerList = result
          .map<CustomerListingModel>(
              (jsonData) => CustomerListingModel.fromJson(jsonData))
          .toList();

      final bool hasReachedMax = customerList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        customerList = List.from(state.customerListing)..addAll(customerList);
      }
      return emit(state.copyWith(
          status: jobSheetStatus.success,
          customerListing: customerList,
          lastTimestamp: customerList.last.timestamp,
          hasReachedMax: hasReachedMax));
    } else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }

  Future<void> _onGetCustomerInfoJobCard(
      GetCustomerInfoJobCard event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(
      status: jobSheetStatus.loading,
      customerInfoJobcardlisting: [], // Clear the previous list
    ));
    dynamic token = await storage.read(key: 'token');

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "vehicle_id": event.vehicleId.toString(),
      "filter": "Jobcard",
    };

    final result = await jobSheetRepository.getCustomerInfoJobCard(
        jsonData, event.id.toString());
    print('result offf jobcard bu id $result');
    if (result != null && result.isNotEmpty) {
      List<CustomerInfoJobCardListModel> customerjobcardlist = result
          .map<CustomerInfoJobCardListModel>(
              (jsonData) => CustomerInfoJobCardListModel.fromJson(jsonData))
          .toList();
      customerjobcardlist = List.from(state.customerInfoJobcardlisting)
        ..addAll(customerjobcardlist);
      return emit(state.copyWith(
        status: jobSheetStatus.success,
        customerInfoJobcardlisting: customerjobcardlist,
      ));
    } else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }

  //GetCustomerInfoEstimate

  Future<void> _onGetCustomerInfoEstimate(
      GetCustomerInfoEstimate event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(
        status: jobSheetStatus.loading, customerInfoestimatelisting: []));
    dynamic token = await storage.read(key: 'token');

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "vehicle_id": event.vehicleId.toString(),
      "filter": "Estimate",
    };

    final result = await jobSheetRepository.getCustomerInfoJobCard(
        jsonData, event.id.toString());
    print('result offf estimatelist by id $result');
    if (result != null && result.isNotEmpty) {
      List<CustomerInfoEstimateListModel> customerestimatelist = result
          .map<CustomerInfoEstimateListModel>(
              (jsonData) => CustomerInfoEstimateListModel.fromJson(jsonData))
          .toList();
      customerestimatelist = List.from(state.customerInfoestimatelisting)
        ..addAll(customerestimatelist);
      return emit(state.copyWith(
        status: jobSheetStatus.success,
        customerInfoestimatelisting: customerestimatelist,
      ));
    } else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }

  Future<void> _onGetCustomerInfoInvoice(
      GetCustomerInfoInvoice event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(
        status: jobSheetStatus.loading, customerInfoinvoicelisting: []));
    dynamic token = await storage.read(key: 'token');
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "vehicle_id": event.vehicleId.toString(),
      "filter": "Invoice",
    };

    final result = await jobSheetRepository.getCustomerInfoJobCard(
        jsonData, event.id.toString());

    if (result != null && result.isNotEmpty) {
      List<CustomerInfoInvoiceListModel> customerinvoicelist = result
          .map<CustomerInfoInvoiceListModel>(
              (jsonData) => CustomerInfoInvoiceListModel.fromJson(jsonData))
          .toList();
      customerinvoicelist = List.from(state.customerInfoinvoicelisting)
        ..addAll(customerinvoicelist);

      return emit(state.copyWith(
        status: jobSheetStatus.success,
        customerInfoinvoicelisting: customerinvoicelist,
      ));
    } else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }

  _onFetchSparePartList(
      FetchSparePartList event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }

    emit(
      state.copyWith(
          status: (event.status == jobSheetStatus.success)
              ? jobSheetStatus.success
              : jobSheetStatus.loading),
    );

    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token!.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction ?? 'down',
      'search': event.searchKeyword ?? '',
    };
    final result = await jobSheetRepository.getSpareParts(jsonData);

    if (result != null && result.isNotEmpty) {
      List<SparePartModel> sparePartList = result
          .map<SparePartModel>((jsonData) => SparePartModel.fromJson(jsonData))
          .toList();
      final bool hasReachedMax = sparePartList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        sparePartList = List.from(state.sparePartListing)
          ..addAll(sparePartList);
      }

      return emit(state.copyWith(
          status: jobSheetStatus.success,
          sparePartListing: sparePartList,
          lastTimestamp: sparePartList.last.timestamp,
          hasReachedMax: hasReachedMax));
    } else {
      return emit(state.copyWith(
          status: jobSheetStatus.success,
          sparePartListing: [],
          hasReachedMax: true));
    }
  }

  Future<void> _onFetchMechanicList(
      FetchMechanics event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }

    emit(state.copyWith(
        status: (event.status == jobSheetStatus.success)
            ? jobSheetStatus.success
            : jobSheetStatus.loading));

    dynamic token = await storage.read(key: 'token');
    Map<String, String> jsonData = {
      'token': token.toString(),
      'timestamp': event.timestamp.toString(),
      'direction': event.direction.toString(),
      'search': event.searchKeyword ?? '',
    };

    final result = await jobSheetRepository.getMechanics(jsonData);

    if (result != null && result.isNotEmpty) {
      List<MechanicListingModel> mechanicList = result
          .map<MechanicListingModel>(
              (jsonData) => MechanicListingModel.fromJson(jsonData))
          .toList();
      final bool hasReachedMax = mechanicList.length < 10;
      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        mechanicList = List.from(state.mechanicListing)..addAll(mechanicList);
      }

      return emit(state.copyWith(
          status: jobSheetStatus.success,
          mechanicListing: mechanicList,
          lastTimestamp: mechanicList.last.timestamp,
          hasReachedMax: hasReachedMax));
    } else {
      return emit(state.copyWith(
        status: jobSheetStatus.failure,
      ));
    }
  }

  FutureOr<void> _onDeleteInvoice(
      DeleteInvoice event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.updating));
    dynamic token = await storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString()
    };
    final result = await jobSheetRepository.deleteInvoice(jsonData);
    if (result['status'] == "Success") {
      emit(state.copyWith(
          status: jobSheetStatus.success,
          invoiceListing: state.invoiceListing));
    }
  }

  Future<void> _onDeleteMechanic(
      DeleteMechanic event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.updating));
    dynamic token = await storage.read(key: 'token');

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString()
    };
    final result = await jobSheetRepository.deleteMechanic(jsonData);

    if (result['status'] == 'Success') {
      emit(state.copyWith(
          status: jobSheetStatus.success,
          mechanicListing: state.mechanicListing));
    }
  }

  Future<void> _onDeleteLabour(
      DeleteLabour event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.updating));

    dynamic token = await storage.read(key: 'token');

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final result = await jobSheetRepository.deleteLabour(jsonData);

    if (result['status'] == 'Success') {
      emit(state.copyWith(
          status: jobSheetStatus.success, labourListing: state.labourListing));
    }
  }

  Future<void> _onCreateAddInvoice(
      CreateAddInvoice event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.sending));
    dynamic token = await storage.read(key: 'token');

    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };

    dynamic result = await jobSheetRepository.createAddInvoice(jsonData);
    if (result['last_id'].runtimeType != Null) {
      emit(state.copyWith(
          status: jobSheetStatus.invoiceSuccess,
          currentInvoiceId: result['last_id']));
    } else {
      emit(state.copyWith(status: jobSheetStatus.submitFailure));
    }
  }

  //create mechanics

  Future<void> _onCreateMechanics(
      CreateMechanicEvent event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.sending));
    dynamic token = await storage.read(key: 'token');
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };

    dynamic result = await jobSheetRepository.createMechanic(jsonData);
    print('mechanic data bloc $result');

    if (result['status'] == 'Success') {
      emit(state.copyWith(status: jobSheetStatus.mechanicSuccess));
    } else {
      emit(state.copyWith(status: jobSheetStatus.submitFailure));
    }
  }

  Future<void> _onCreateLabour(
      CreateLabourEvent event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.sending));
    dynamic token = await storage.read(key: 'token');

    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };

    final result = await jobSheetRepository.createLabour(jsonData);
    if (result['status'] == 'Success') {
      emit(state.copyWith(status: jobSheetStatus.labourSuccess));
    } else {
      emit(state.copyWith(status: jobSheetStatus.submitFailure));
    }
  }

  Future<void> _onCreateCustomer(
      CreateCustomerEvent event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.sending));

    dynamic token = await storage.read(key: 'token');
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };

    final result = await jobSheetRepository.createCustomer(jsonData);

    if (result['status'] == 'Success') {
      emit(state.copyWith(status: jobSheetStatus.customerSuccess));
    } else {
      emit(state.copyWith(status: jobSheetStatus.submitFailure));
    }
  }

  Future<void> _onAddEstimate(
      AddEstimate event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.sending));
    dynamic token = await storage.read(key: 'token');

    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };

    dynamic result = await jobSheetRepository.addEstimate(jsonData);
    if (result['last_id'].runtimeType != Null) {
      emit(state.copyWith(
          status: jobSheetStatus.estimateSuccess,
          currentEstimateId: result['last_id']));
    } else {
      emit(state.copyWith(status: jobSheetStatus.submitFailure));
    }
  }

  _onClearListingData(ClearListingData event, Emitter<JobSheetState> emit) {
    emit(state.copyWith(
        status: jobSheetStatus.initial,
        currentEstimateId: 0,
        currentInvoiceId: 0,
        dashboardModel: DashboardModel.empty,
        estimateListing: [],
        // estimateModel: ,
        hasReachedMax: false,
        invoiceListing: [],
        // invoiceModel: ,
        jobSheetList: [],
        loadShow: false,
        page: 0,
        totalPages: 0));
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<JobSheetState> emit) async {
    dynamic token = await storage.read(key: 'token');

    if (token != null) {
      await authenticationRepo.logOut(token);
      await storage.delete(key: 'token');
    } else {
      emit(state.copyWith(status: jobSheetStatus.failure));
    }
  }
}
