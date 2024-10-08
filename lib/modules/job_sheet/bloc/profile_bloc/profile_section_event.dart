import 'package:equatable/equatable.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_state.dart';

class ProfileSectionEvent extends Equatable {
  const ProfileSectionEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileInfo extends ProfileSectionEvent {
  final ProfileSectionState? profileStatus;
  const FetchProfileInfo({this.profileStatus});
}

class PasswordUpdate extends ProfileSectionEvent {
  final String? id;
  final Map<String, dynamic>? formData;

 const PasswordUpdate(
      { this.id,this.formData, });
}
