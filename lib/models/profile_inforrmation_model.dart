import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileInformationModel extends Equatable {
  final int? id;
  final int? companyId;
  final String? companyLogo;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final dynamic details;
  final String? email;
  final String? firstname;
  final int? flag;
  final Map<String, dynamic>? fullName;
  final String? name;
  final String? profilePic;
  final int? rollId;
  final String? subscriptionEnd;
  final String? subscriptionStart;
  final String? updatedAt;

  const ProfileInformationModel(
      {this.id,
      this.deletedAt,
      this.email,
      this.fullName,
      this.companyId,
       this.companyLogo,
      this.createdAtDate,
      this.createdAtTime,
      this.details,
      this.firstname,
      this.flag,
      this.name,
      this.profilePic,
      this.rollId,
      this.subscriptionEnd,
      this.subscriptionStart,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        deletedAt!,
        email!,
        fullName!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
        details!,
        companyLogo!,
        firstname!,
        flag!,
        name!,
        profilePic!,
        rollId!,
        subscriptionEnd!,
        subscriptionStart!,
        updatedAt!
      ];
  ProfileInformationModel copyWith({
    int? id,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    dynamic details,
    String? email,
     String? companyLogo,
    String? firstname,
    int? flag,
    Map<String, dynamic>? fullName,
    String? name,
    String? profilePic,
    int? rollId,
    String? subscriptionEnd,
    String? subscriptionStart,
    String? updatedAt,
  }) {
    ProfileInformationModel profileInformationModel = ProfileInformationModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      details: details ?? this.details,
      firstname: firstname ?? this.firstname,
      flag: flag ?? flag,
      fullName: fullName ?? this.fullName,
      companyLogo: companyLogo ?? this.companyLogo,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      rollId: rollId ?? this.rollId,
      subscriptionEnd: subscriptionEnd ?? this.subscriptionEnd,
      subscriptionStart: subscriptionStart ?? this.subscriptionStart,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return profileInformationModel;
  }

  factory ProfileInformationModel.fromJson(Map<String, dynamic> json) {
    return ProfileInformationModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      email: json['email'] ?? "",
      details: json['details'] ?? [],
      firstname: json['first_name'] ?? "",
      flag: int.parse(json['flag']),
      fullName: jsonDecode(json['full_name']) ?? [],
      companyLogo: json['company_logo'],
      name: json['name'] ?? "",
      profilePic: json['profile_pic'] ?? "",
      rollId: json['role_id'] ?? 0,
      subscriptionEnd: json['sub_end'] ?? "",
      subscriptionStart: json['sub_start'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  static const empty = ProfileInformationModel(
    id: 0,
    companyId: 0,
    createdAtDate: "",
    createdAtTime: "",
    details: [],
    firstname: "",
    flag: 0,
    fullName: {},
    name: "",
    profilePic: "",
    companyLogo: "",
    rollId: 0,
    subscriptionEnd: "",
    subscriptionStart: "",
    deletedAt: "",
    email: "",
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id,companyId:$companyId,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,companyLogo:$companyLogo,profilePic:$profilePic, details:$details,  email:$email ,firstname:$firstname, flag:$flag,fullName:$fullName,name:$name, rollId:$rollId, subscriptionEnd:$subscriptionEnd,subscriptionStart:$subscriptionStart, deletedAt:$deletedAt,updatedAt:$updatedAt}';
}