import 'package:equatable/equatable.dart';

class EstimateListingModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAtTime;
  final String? deletedAt;
  final String? email;
  final String? estimateTotal;
  final int? estimateNumber;
  final int? flag;
  final String? kms;
  final String? fullname;
  final String? manufacturers;
  final String? mobileNumber;
  final String? tempDate;
  final int? timestamp;
  final String? updateAt;
  final String? vehicleName;
  final String? vehicleNumber;

  const EstimateListingModel(
      {this.id,
      this.estimateTotal,
      this.estimateNumber,
      this.flag,
      this.kms,
      this.fullname,
      this.manufacturers,
      this.mobileNumber,
      this.updateAt,
      this.vehicleName,
      this.vehicleNumber,
      this.address,
      this.createdAtTime,
      this.deletedAt,
      this.email,
      this.tempDate,
      this.timestamp});

  @override
  List<Object> get props => [
        id!,
        address!,
        createdAtTime!,
        deletedAt!,
        email!,
        estimateNumber!,
        estimateTotal!,
        flag!,
        kms!,
        fullname!,
        manufacturers!,
        vehicleName!,
        vehicleNumber!,
        mobileNumber!,
        updateAt!,
        tempDate!,
        timestamp!,
      ];

  EstimateListingModel copyWith(
      {int? id,
      String? address,
      String? createdAtTime,
      String? deletedAt,
      String? email,
      String? estimateTotal,
      int? estimateNumber,
      int? flag,
      String? kms,
      String? fullname,
      String? manufacturers,
      String? mobileNumber,
      String? updateAt,
      String? vehicleName,
      String? vehicleNumber,
      String? tempDate,
      int? timestamp}) {
    EstimateListingModel estimateListingModel = EstimateListingModel(
        id: id ?? this.id,
        address: address ?? this.address,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        deletedAt: deletedAt ?? this.deletedAt,
        email: email ?? this.email,
        estimateNumber: estimateNumber ?? this.estimateNumber,
        estimateTotal: estimateTotal ?? this.estimateTotal,
        flag: flag ?? this.flag,
        kms: kms ?? this.kms,
        fullname: fullname ?? this.fullname,
        manufacturers: manufacturers ?? this.manufacturers,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        updateAt: updateAt ?? this.updateAt,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        tempDate: tempDate ?? this.tempDate,
        timestamp: timestamp ?? this.timestamp);
    return estimateListingModel;
  }

  factory EstimateListingModel.fromJson(Map<String, dynamic> json) {

    return EstimateListingModel(
      id: json['id'] ?? 0,
      address: json['address'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      estimateNumber: json['estimate_number'] ?? 0,
      estimateTotal: json['estimateTotal'].toString() ?? "",
      flag: json['flag'] ?? 0,
      kms: json['kms'] ?? "",
      fullname: json['full_name'] ?? "",
      manufacturers: json['manufacturers'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      timestamp:int.parse( json['timestamp'].toString()),
      updateAt: json['updated_at'] ?? "",
      vehicleName: json['vehicle_name'] ?? "",
      vehicleNumber: json['vehicle_number'] ?? "",
    );
  }

  @override
  String toString() =>
      '{id: $id, address: $address, createdAtTime: $createdAtTime, deletedAt: $deletedAt, email:$email,estimateNumber:$estimateNumber,estimateTotal:$estimateTotal,flag:$flag,fullname:$fullname ,manufacturers:$manufacturers,mobileNumber:$mobileNumber,temp_date:$tempDate,updateAt:$updateAt, vehicleName:$vehicleName,vehicleNumber:$vehicleNumber }';
}
