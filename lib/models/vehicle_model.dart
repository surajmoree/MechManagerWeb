import 'package:equatable/equatable.dart';

class VehicleModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final String? email;
  final String? fullName;
  final String? manufacturers;
  final String? mobileNumber;
  final String? updatedAt;
  final String? vehiclename;
  final String? vehiclenumber;
  final String? alternateMobileNumber;

  const VehicleModel({
    this.id,
    this.address,
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.email,
    this.fullName,
    this.manufacturers,
    this.mobileNumber,
    this.alternateMobileNumber,
    this.updatedAt,
    this.vehiclename,
    this.vehiclenumber,
  });

  @override
  List<Object> get props => [
        id!,
        address!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        email!,
        fullName!,
        manufacturers!,
        mobileNumber!,
        updatedAt!,
        vehiclename!,
        vehiclenumber!,
      ];

  VehicleModel copyWith({
    String? address,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    String? email,
    String? fullName,
    int? id,
    String? manufacturers,
    String? mobileNumber,
    String? alternateMobileNumber,
    String? updatedAt,
    String? vehiclename,
    String? vehiclenumber,
  }) {
    VehicleModel vehicleModel = VehicleModel(
      id: id ?? this.id,
      address: address ?? this.address,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      manufacturers: manufacturers ?? this.manufacturers,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternateMobileNumber:
          alternateMobileNumber ?? this.alternateMobileNumber,
      updatedAt: updatedAt ?? this.updatedAt,
      vehiclename: vehiclename ?? this.vehiclename,
      vehiclenumber: vehiclenumber ?? this.vehiclenumber,
    );
    return vehicleModel;
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? 0,
      address: json['address'] ?? "",
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      fullName: json['full_name'] ?? "",
      manufacturers: json['manufacturers'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      alternateMobileNumber: json['alternate_mobile_number'],
      updatedAt: json['updated_at'] ?? "",
      vehiclename: json['vehicle_name'] ?? "",
      vehiclenumber: json['vehicle_number'] ?? "",
    );
  }

  static const empty = VehicleModel(
    id: 0,
    address: "",
    createdAtDate: "",
    createdAtTime: "",
    deletedAt: "",
    email: "",
    fullName: "",
    manufacturers: "",
    mobileNumber: "",
    alternateMobileNumber: "",
    updatedAt: "",
    vehiclename: "",
    vehiclenumber: "",
  );

  @override
  String toString() =>
      '{id: $id,address:$address, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime, deletedAt: $deletedAt,email: $email, fullName: $fullName  , manufacturers: $manufacturers,mobileNumber: $mobileNumber,alternateMobileNumber:$alternateMobileNumber, updatedAt: $updatedAt, vehicle_name: $vehiclename, vehiclenumber: $vehiclenumber,}';
}

