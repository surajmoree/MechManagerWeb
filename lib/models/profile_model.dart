import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdateProfileModel extends Equatable {
  final int? id;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? accountNumber;
  final Map<String, dynamic>? address;
  final String? bankName;
  final String? branchName;
  final String? companyLogo;
  final String? companyLogoThumb;
 // final String? image;
  final String? companyname;
  final String? currency;
  final String? email;
  final String? deletedAt;
  final String? ifsc;
  final String? mobileNumber;
  final String? vpa;
  final String? updatedAt;
  final String? subscriptionEnd;
  final String? subscriptionStart;
  

  const UpdateProfileModel(
      {this.id,
      this.deletedAt,
      this.accountNumber,
      this.address,
      this.bankName,
      this.branchName,
      this.companyLogo,
      this.companyLogoThumb,
    //  this.image,
      this.companyname,
      this.currency,
      this.ifsc,
      this.mobileNumber,
      this.vpa,
      this.email,
      this.createdAtDate,
      this.createdAtTime,
      this.subscriptionEnd,
      this.subscriptionStart,
      this.updatedAt,
      
      });

  @override
  List<Object> get props => [
        id!,
        deletedAt!,
        email!,
        accountNumber!,
        address!,
        bankName!,
        branchName!,
        companyLogo!,
        companyLogoThumb!,
        //image!,
        companyname!,
        currency!,
        ifsc!,
        mobileNumber!,
        vpa!,
        createdAtDate!,
        createdAtTime!,
        subscriptionEnd!,
        subscriptionStart!,
        updatedAt!,
        
      ];
  UpdateProfileModel copyWith({
    int? id,
    String? createdAtDate,
    String? createdAtTime,
    String? accountNumber,
    Map<String, dynamic>? address,
    String? bankName,
    String? branchName,
    String? companyLogo,
    String? companyLogoThumb,
  //  String? image,
    String? companyname,
    String? currency,
    String? email,
    String? deletedAt,
    String? ifsc,
    String? mobileNumber,
    String? vpa,
    String? updatedAt,
    String? subscriptionEnd,
    String? subscriptionStart,
    
  }) {
    UpdateProfileModel updateProfileModel = UpdateProfileModel(
      id: id ?? this.id,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      accountNumber: accountNumber ?? this.accountNumber,
      address: address ?? this.address,
      bankName: bankName ?? this.bankName,
      branchName: branchName ?? this.branchName,
      companyLogo: companyLogo ?? this.companyLogo,
      companyLogoThumb: companyLogoThumb ?? this.companyLogoThumb,
    //   image: image ?? this.image,
      companyname: companyname ?? this.companyname,
      currency: currency ?? this.currency,
      email: email ?? this.email,
      ifsc: ifsc ?? this.ifsc,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      vpa: vpa ?? this.vpa,
      subscriptionEnd: subscriptionEnd ?? this.subscriptionEnd,
      subscriptionStart: subscriptionStart ?? this.subscriptionStart,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
     
    );
    return updateProfileModel;
  }

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      id: json['id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      accountNumber: json['act_no'],
      address: jsonDecode(json['address']) ?? {},
      bankName: json['bank_name'],
      branchName: json['brach_name'],
      companyLogo: json['company_logo'],
      companyLogoThumb: json['company_logo_thumb'],
     // image: json['image1'],
      companyname: json['company_name'],
      currency: json['currency'],
      ifsc: json['ifsc'],
      mobileNumber: json['mobile_number'],
      vpa: json['vpa'],
      email: json['email'] ?? "",
      subscriptionEnd: json['sub_end'] ?? "",
      subscriptionStart: json['sub_start'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      
    );
  }
  static const empty = UpdateProfileModel(
    id: 0,
    createdAtDate: "",
    createdAtTime: "",
    accountNumber: "",
    address: {},
    branchName: "",
    bankName: "",
    companyLogo: "",
    companyLogoThumb: "",
    //image: "",
    companyname:"",
    currency: "",
    ifsc: "",
    mobileNumber: "",
    vpa: "",
    subscriptionEnd: "",
    subscriptionStart: "",
    deletedAt: "",
    email: "",
    updatedAt: "",
    
  );
  @override
  String toString() =>
      '{id: $id,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime, accountNumber:$accountNumber,  email:$email ,address:$address, bankName:$bankName,branchName:$branchName, companyLogoThumb:$companyLogoThumb,companyLogo:$companyLogo,currency:$currency,ifsc:$ifsc,mobileNumber:$mobileNumber,  vpa:$vpa, subscriptionEnd:$subscriptionEnd,subscriptionStart:$subscriptionStart, deletedAt:$deletedAt,updatedAt:$updatedAt, companyname: $companyname}';
}