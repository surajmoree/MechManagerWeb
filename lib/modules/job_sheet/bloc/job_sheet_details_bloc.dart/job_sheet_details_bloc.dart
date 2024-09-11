import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/config/constants.dart';
import 'package:mech_manager/models/job_card_details_model.dart';
import 'package:mech_manager/models/slider_image_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

class JobSheetDetailsBloc
    extends Bloc<JobSheetDetailsEvent, JobSheetDetailsState> {
  JobSheetDetailsBloc() : super(JobSheetDetailsState()) {
    on<GetJobSheetDetails>(_onGetJobSheetDetails);
    on<GetJobSheetImages>(_onGetJobSheetImages);
    on<UpdateJobSheet>(_onUpdateJobSheet);
  }

  Future<void> _onGetJobSheetDetails(
      GetJobSheetDetails event, Emitter<JobSheetDetailsState> emit) async {
    emit(state.copyWith(status: JobSheetDetailsStatus.loading));

    dynamic token = await storage.read(key: 'token');

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final jobSheetDetails =
        await jobSheetRepository.getJobSheetDetails(jsonData);
    add(GetJobSheetImages(id: event.id.toString()));

    if (jobSheetDetails != null && jobSheetDetails.isNotEmpty) {
      emit(state.copyWith(
          status: JobSheetDetailsStatus.success,
          jobSheetDetails: JobSheetDetailModel.fromJson(jobSheetDetails)));
    } else {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.failed,
          jobSheetDetails: JobSheetDetailModel.empty,
        ),
      );
    }
  }

  _onGetJobSheetImages(
      GetJobSheetImages event, Emitter<JobSheetDetailsState> emit) async {
    dynamic token = await storage.read(key: 'token');

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final jobSheetImages = await jobSheetRepository.getJobSheetImages(jsonData);
    if (jobSheetImages != null && jobSheetImages.isNotEmpty) {
      emit(state.copyWith(
          status: JobSheetDetailsStatus.success,
          imageSliderModel: ImageSliderModel.fromJson(jobSheetImages)));
    }
  }

  _onUpdateJobSheet(
      UpdateJobSheet event, Emitter<JobSheetDetailsState> emit) async {
    emit(state.copyWith(status: JobSheetDetailsStatus.jobcardUpdated));
    dynamic jwtToken = await storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData)
    };
    dynamic result =
        await jobSheetRepository.updateJobSheet(jsonData, event.id.toString());

    if (result['status'] == "Success") {
      emit(state.copyWith(status: JobSheetDetailsStatus.jobcardUpdated));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: JobSheetDetailsStatus.success));
      if (event.frontImage.path.isNotEmpty) {
        callApiForSend(event.frontImage, jwtToken, event.id.toString(),
            'vehicle_front_img');
      }
      if (event.rightHandSideImage.path.isNotEmpty) {
        callApiForSend(event.rightHandSideImage, jwtToken, event.id.toString(),
            'vehicle_right_hand_img');
      }
      if (event.leftHandSideImage.path.isNotEmpty) {
        callApiForSend(event.leftHandSideImage, jwtToken, event.id.toString(),
            'vehicle_left_hand_img');
      }
      if (event.rearImage.path.isNotEmpty) {
        callApiForSend(
            event.rearImage, jwtToken, event.id.toString(), 'vehicle_rear_img');
      }
      if (event.dashboardImage.path.isNotEmpty) {
        callApiForSend(event.dashboardImage, jwtToken, event.id.toString(),
            'vehicle_dashboard_img');
      }
      if (event.engineImage.path.isNotEmpty) {
        callApiForSend(event.engineImage, jwtToken, event.id.toString(),
            'vehicle_dickey_img');
      }
      // Additional images
      if (event.image1.path.isNotEmpty) {
        callApiForSend(event.image1, jwtToken, event.id.toString(), 'images1');
      }
      if (event.image2.path.isNotEmpty) {
        callApiForSend(event.image2, jwtToken, event.id.toString(), 'images2');
      }
      if (event.image3.path.isNotEmpty) {
        callApiForSend(event.image3, jwtToken, event.id.toString(), 'images3');
      }
      if (event.image4.path.isNotEmpty) {
        callApiForSend(event.image4, jwtToken, event.id.toString(), 'images4');
      }
    }
  }

  Future<void> callApiForSend(
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
}
