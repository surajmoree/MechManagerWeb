import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/profile_inforrmation_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_state.dart';
import 'package:mech_manager/network/repositories/job_sheet_repository.dart';

class ProfileSectionBloc
    extends Bloc<ProfileSectionEvent, ProfileSectionState> {
  ProfileSectionBloc() : super(ProfileSectionState()) {
    on<FetchProfileInfo>(_onFetchProfileInfo);
    on<PasswordUpdate>(_onchangePassword);
   

 
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  _onFetchProfileInfo(
      FetchProfileInfo event, Emitter<ProfileSectionState> emit) async {
    emit(
      state.copyWith(
          status: (event.profileStatus == ProfileSectionStatus.success)
              ? ProfileSectionStatus.success
              : ProfileSectionStatus.loading),
    );
    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token!.toString(),
    };
    final result = await jobSheetRepository.profileInformation(jsonData);
  
  
    if (result != null && result.isNotEmpty) {
      return emit(state.copyWith(
          status: ProfileSectionStatus.success,
          profileModel: ProfileInformationModel.fromJson(result)));
    } else {
      return emit(state.copyWith(
        status: ProfileSectionStatus.failure,
      ));
    }
  }

  Future<void> _onchangePassword(PasswordUpdate event, Emitter<ProfileSectionState>emit)async
  {
    emit(state.copyWith(status: ProfileSectionStatus.loading));
    dynamic token = await storage.read(key: 'token');
    Map<String,Object> jsonData =
    {
      "token": token.toString(),
      "formData": jsonEncode(event.formData)
    };

    final result = await jobSheetRepository.changePassword(jsonData, event.id.toString());

    if(result['status'] == "Success")
    {
       emit(state.copyWith(status: ProfileSectionStatus.success));
    }else {
        emit(state.copyWith(status: ProfileSectionStatus.failure));
      }

  }




}
