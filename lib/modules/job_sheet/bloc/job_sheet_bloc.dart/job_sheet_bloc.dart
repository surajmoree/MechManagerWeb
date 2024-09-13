import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/constants.dart';
import 'package:mech_manager/models/dashboard_model.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/network/repositories/job_sheet_repository.dart';

class JobSheetBloc extends Bloc<JobSheetEvent, JobSheetState> {
  JobSheetBloc() : super(JobSheetState()) {
    on<FetchJobSheets>(_onFetchJobSheets);
    on<AddJobSheet>(_onAddJobSheet);
    
    on<DeleteJobSheet>(_onDeleteJobSheet);
    on<FetchDashboard>(_onFetchDashboard);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

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
}
