import 'dart:convert';

import 'package:equatable/equatable.dart';

class JobSheetDetailModel extends Equatable {
  final int? id;
  final String? address;
  final List<dynamic>? assignMechanics;
  final int? companyId;
  final String? createdAtDate;
  final String? companyname;
  final String? createdAtTime;
  final String? createdBy;
  final List<dynamic>? customerComplaints;
  final int? customerId;
  final String? dashboardImg;
  final String? deletedAt;
  final String? dickeyImg;
  final String? email;
  final String? frontImg;
  final String? fuel;
  final String? fullName;
  final String? image1Img;
  final String? image1Thumb;
  final String? image2Img;
  final String? image2Thumb;
  final String? image3Img;
  final String? image3Thumb;
  final String? image4Img;
  final String? image4Thumb;
  final List<dynamic>? items;
  final String? jobSheetId;
  final String? kms;
  final String? leftImg;
  final String? manufacturers;
  final String? status;
  final String? mobileNumber;
  final String? alternateMobileNumber;
  final String? rearImg;
  final String? rightImg;
  final String? updatedAt;
  final String? vehicleDashboardThumb;
  final String? vehicleDickeyThumb;
  final String? vehicleFrontThumb;
  final String? vehicleLeftThumb;
  final String? vehicleName;
  final String? vehicleNumber;
  final String? vehicleRearThumb;
  final String? vehicleRightThumb;

  const JobSheetDetailModel(
      {this.id,
      this.address,
      this.assignMechanics,
      this.companyId,
      this.companyname,
      this.createdAtDate,
      this.createdAtTime,
      this.createdBy,
      this.customerComplaints,
      this.customerId,
      this.dashboardImg,
      this.deletedAt,
      this.dickeyImg,
      this.email,
      this.frontImg,
      this.fuel,
      this.fullName,
      this.image1Img,
      this.image1Thumb,
      this.image2Img,
      this.image2Thumb,
      this.image3Img,
      this.image3Thumb,
      this.image4Img,
      this.image4Thumb,
      this.items,
      this.jobSheetId,
      this.kms,
      this.leftImg,
      this.manufacturers,
      this.status,
      this.mobileNumber,
      this.alternateMobileNumber,
      this.rearImg,
      this.rightImg,
      this.updatedAt,
      this.vehicleDashboardThumb,
      this.vehicleDickeyThumb,
      this.vehicleFrontThumb,
      this.vehicleLeftThumb,
      this.vehicleName,
      this.vehicleNumber,
      this.vehicleRearThumb,
      this.vehicleRightThumb});

  @override
  List<Object> get props => [
        id!,
        address!,
        assignMechanics!,
        companyId!,
        companyname!,
        createdAtDate!,
        createdAtTime!,
        createdBy!,
        customerComplaints!,
        customerId!,
        dashboardImg!,
        deletedAt!,
        dickeyImg!,
        email!,
        frontImg!,
        fuel!,
        fullName!,
        image1Img!,
        image1Thumb!,
        image2Img!,
        image2Thumb!,
        image3Img!,
        image3Thumb!,
        image4Img!,
        image4Thumb!,
        items!,
        jobSheetId!,
        kms!,
        leftImg!,
        manufacturers!,
        status!,
        mobileNumber!,
        alternateMobileNumber!,
        rearImg!,
        rightImg!,
        updatedAt!,
        vehicleDashboardThumb!,
        vehicleDickeyThumb!,
        vehicleFrontThumb!,
        vehicleLeftThumb!,
        vehicleName!,
        vehicleNumber!,
        vehicleRearThumb!,
        vehicleRightThumb!
      ];

  JobSheetDetailModel copyWith(
      {int? id,
      String? address,
      List<dynamic>? assignMechanics,
      int? companyId,
      String? companyname,
      String? createdAtDate,
      String? createdAtTime,
      String? createdBy,
      List<dynamic>? customerComplaints,
      int? customerId,
      String? dashboardImg,
      String? deletedAt,
      String? dickeyImg,
      String? email,
      String? frontImg,
      String? fuel,
      String? fullName,
      String? image1Img,
      String? image1Thumb,
      String? image2Img,
      String? image2Thumb,
      String? image3Img,
      String? image3Thumb,
      String? image4Img,
      String? image4Thumb,
      List<dynamic>? items,
      String? jobSheetId,
      String? kms,
      String? leftImg,
      String? manufacturers,
      String? status,
      String? mobileNumber,
      String? alternateMobileNumber,
      String? rearImg,
      String? rightImg,
      String? updatedAt,
      String? vehicleDashboardThumb,
      String? vehicleDickeyThumb,
      String? vehicleFrontThumb,
      String? vehicleLeftThumb,
      String? vehicleName,
      String? vehicleNumber,
      String? vehicleRearThumb,
      String? vehicleRightThumb}) {
    JobSheetDetailModel jobSheetDetailsModel = JobSheetDetailModel(
        id: id ?? this.id,
        address: address ?? this.address,
        assignMechanics: assignMechanics ?? this.assignMechanics,
        companyId: companyId ?? this.companyId,
        companyname: companyname ?? this.companyname,
        createdAtDate: createdAtDate ?? this.createdAtDate,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        createdBy: createdBy ?? this.createdBy,
        customerComplaints: customerComplaints ?? this.customerComplaints,
        customerId: customerId ?? this.customerId,
        dashboardImg: dashboardImg ?? this.dashboardImg,
        deletedAt: deletedAt ?? this.deletedAt,
        dickeyImg: dickeyImg ?? this.dickeyImg,
        email: email ?? this.email,
        frontImg: frontImg ?? this.frontImg,
        fuel: fuel ?? this.fuel,
        fullName: fullName ?? this.fullName,
        image1Img: image1Img ?? this.image1Img,
        image1Thumb: image1Thumb ?? this.image1Thumb,
        image2Img: image2Img ?? this.image2Img,
        image2Thumb: image2Thumb ?? this.image2Thumb,
        image3Img: image2Img ?? this.image3Img,
        image3Thumb: image2Thumb ?? this.image3Thumb,
        image4Img: image4Img ?? this.image4Img,
        image4Thumb: image4Thumb ?? this.image4Thumb,
        items: items ?? this.items,
        jobSheetId: jobSheetId ?? this.jobSheetId,
        kms: kms ?? this.kms,
        leftImg: leftImg ?? this.leftImg,
        manufacturers: manufacturers ?? this.manufacturers,
        status: status ?? this.status,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        alternateMobileNumber:
            alternateMobileNumber ?? this.alternateMobileNumber,
        rearImg: rearImg ?? this.rearImg,
        rightImg: rightImg ?? this.rightImg,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicleDashboardThumb:
            vehicleDashboardThumb ?? this.vehicleDashboardThumb,
        vehicleDickeyThumb: vehicleDickeyThumb ?? this.vehicleDickeyThumb,
        vehicleFrontThumb: vehicleFrontThumb ?? this.vehicleFrontThumb,
        vehicleLeftThumb: vehicleLeftThumb ?? this.vehicleLeftThumb,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        vehicleRearThumb: vehicleRearThumb ?? this.vehicleRearThumb,
        vehicleRightThumb: vehicleRightThumb ?? this.vehicleRightThumb);
    return jobSheetDetailsModel;
  }

  factory JobSheetDetailModel.fromJson(Map<String, dynamic> json) {
    return JobSheetDetailModel(
        id: json['id'] ?? 0,
        address: json['address'] ?? "",
        assignMechanics: jsonDecode((json['assign_mechanics'])) ?? [],
        companyId: json['company_id'] ?? 0,
        companyname: json['company_name']??"",
        createdAtDate: json['created_at_date'] ?? "",
        createdAtTime: json['created_at_time'] ?? "",
        createdBy: json['created_by'] ?? "",
        customerComplaints: jsonDecode(json['customer_complaints']) ?? [],
        customerId: json['customer_id'] ?? 0,
        dashboardImg: json['dashbord_img'] ?? "",
        deletedAt: json['deleted_at'] ?? "",
        dickeyImg: json['dickey_img'] ?? "",
        email: json['email'] ?? "",
        frontImg: json['front_img'] ?? "",
        fuel: json['fuel'] ?? "",
        fullName: json['full_name'] ?? "",
        image1Img: json['image1_img'] ?? "",
        image1Thumb: json['image1_thumb'] ?? "",
        image2Img: json['image2_img'] ?? "",
        image2Thumb: json['image2_thumb'] ?? "",
        image3Img: json['image3_img'] ?? "",
        image3Thumb: json['image3_thumb'] ?? "",
        image4Img: json['image4_img'] ?? "",
        image4Thumb: json['image4_thumb'] ?? "",
        items: jsonDecode((json['items'])) ?? [],
        jobSheetId: json['job_sheet_id'] ?? "",
        kms: json['kms'] ?? "",
        leftImg: json['left_img'] ?? "",
        manufacturers: json['manufacturers'] ?? "",
        status: json['status'] ?? "",
        mobileNumber: json['mobile_number'] ?? "",
        alternateMobileNumber: json['alternet_number'],
        rearImg: json['rear_img'] ?? "",
        rightImg: json['right_img'] ?? "",
        updatedAt: json['updated_at'] ?? "",
        vehicleDashboardThumb: json['vehicle_dashbord_thumb'] ?? "",
        vehicleDickeyThumb: json['vehicle_dickey_thumb'] ?? "",
        vehicleFrontThumb: json['vehicle_front_thumb'] ?? "",
        vehicleLeftThumb: json['vehicle_left_thumb'] ?? "",
        vehicleName: json['vehicle_name'] ?? "",
        vehicleNumber: json['vehicle_number'] ?? "",
        vehicleRearThumb: json['vehicle_rear_thumb'] ?? "",
        vehicleRightThumb: json['vehicle_right_thumb'] ?? "");
  }

  static const empty = JobSheetDetailModel(
      id: 0,
      address: "",
      assignMechanics: [],
      companyId: 0,
      companyname:"",
      createdAtDate: "",
      createdAtTime: "",
      createdBy: "",
      customerComplaints: [],
      customerId: 0,
      dashboardImg: "",
      deletedAt: "",
      dickeyImg: "",
      email: "",
      frontImg: "",
      fuel: "",
      fullName: "",
      image1Img: "",
      image1Thumb: "",
      image2Img: "",
      image2Thumb: "",
      image3Img: "",
      image3Thumb: "",
      image4Img: "",
      image4Thumb: "",
      items: [],
      jobSheetId: "",
      kms: "",
      leftImg: "",
      manufacturers: "",
      status: "",
      mobileNumber: "",
      alternateMobileNumber: "",
      rearImg: "",
      rightImg: "",
      updatedAt: "",
      vehicleDashboardThumb: "",
      vehicleDickeyThumb: "",
      vehicleFrontThumb: "",
      vehicleLeftThumb: "",
      vehicleName: "",
      vehicleNumber: "",
      vehicleRearThumb: "",
      vehicleRightThumb: "");

  @override
  String toString() =>
      '{id: $id, address: $address, assignMechanics: $assignMechanics,companyId:$companyId,companyname:$companyname, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime,createdBy:$createdBy, customerComplaints: $customerComplaints, customerId:$customerId,dashboardImg: $dashboardImg, deletedAt: $deletedAt, dickeyImg: $dickeyImg, email: $email, frontImg: $frontImg, fuel: $fuel, frontImg: $frontImg, fuel: $fuel, $fullName: $fullName, image1Img: $image1Img, image1thumb: $image1Thumb, image2Img: $image2Img, image2Thumb: $image2Thumb, image3Img: $image4Img, image3Thumb : $image3Thumb, image3Img: $image4Img, image4Thumb: $image4Thumb, items: $items, jobSheetId: $jobSheetId, kms: $kms, leftImg: $leftImg, manufacturers: $manufacturers,status:$status,mobileNumber: $mobileNumber,alternateMobileNumber:$alternateMobileNumber, rearImg: $rearImg, rightImg: $rightImg, updatedAt: $updatedAt, vahicleDashboardThumb: $vehicleDashboardThumb, vehicleDickeyThumb: $vehicleDickeyThumb, vehicleFrontThumb: $vehicleFrontThumb, vehicleLeftThumb: $vehicleLeftThumb, vehicleName: $vehicleName, vehicleNumber: $vehicleNumber,  vehicleRearThumb: $vehicleRearThumb, vehicleRightThumb: $vehicleRightThumb}';
}