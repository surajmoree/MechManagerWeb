import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/profile_inforrmation_model.dart';

enum ProfileSectionStatus {
  initial,
  loading,
  success,
  failure,
  profileUpdate,
  submitFailure,
  sending,
  updating,
  updated
}

class ProfileSectionState extends Equatable {
  ProfileSectionStatus? status;
  ProfileInformationModel? profileModel;
  ProfileSectionState({
    this.status = ProfileSectionStatus.initial,
    this.profileModel = ProfileInformationModel.empty,
  });

  @override
  List<Object?> get props => [
        status!,
        profileModel!,
      ];

  ProfileSectionState copyWith({
    ProfileSectionStatus? status,
    ProfileInformationModel? profileModel,
  }) {
    return ProfileSectionState(
      status: status ?? this.status,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}
