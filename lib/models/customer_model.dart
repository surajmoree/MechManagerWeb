import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? fullName;
  final String? mobileNumber;
  final String? alternetMobileNumber;  // New field
  final int? companyId;  // New field
  final String? updatedAt;
  final int? vehicleCount;  // New field
  final List<dynamic>? vehicles;  // New field (assuming it's a list of vehicles, can be updated if you have a specific Vehicle model)

  const CustomerModel(
      {this.id,
      this.address,
      this.createdAt,
      this.deletedAt,
      this.email,
      this.fullName,
      this.mobileNumber,
      this.alternetMobileNumber,
      this.companyId,
      this.updatedAt,
      this.vehicleCount,
      this.vehicles});

  @override
  List<Object?> get props => [
        id,
        address,
        createdAt,
        deletedAt,
        email,
        fullName,
        mobileNumber,
        alternetMobileNumber,
        companyId,
        updatedAt,
        vehicleCount,
        vehicles
      ];

  CustomerModel copyWith({
    int? id,
    String? address,
    String? createdAt,
    String? deletedAt,
    String? email,
    String? fullName,
    String? mobileNumber,
    String? alternetMobileNumber,
    int? companyId,
    String? updatedAt,
    int? vehicleCount,
    List<dynamic>? vehicles,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternetMobileNumber: alternetMobileNumber ?? this.alternetMobileNumber,
      companyId: companyId ?? this.companyId,
      updatedAt: updatedAt ?? this.updatedAt,
      vehicleCount: vehicleCount ?? this.vehicleCount,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      address: json['customer_address'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['customer_email'] ?? "",
      fullName: json['customer_full_name'] ?? "",
      mobileNumber: json['customer_mobile_number'] ?? "",
      alternetMobileNumber: json['alternet_mobile_number'] ?? "",
      companyId: json['company_id'] ?? 0,
      updatedAt: json['updated_at'] ?? "",
      vehicleCount: json['vehicle_count'] ?? 0,
      vehicles: json['vehicles'] ?? [],
    );
  }

  static const empty = CustomerModel(
    id: 0,
    address: "",
    createdAt: "",
    deletedAt: "",
    email: "",
    fullName: "",
    mobileNumber: "",
    alternetMobileNumber: "",
    companyId: 0,
    updatedAt: "",
    vehicleCount: 0,
    vehicles: [],
  );

  @override
  String toString() =>
      '{id: $id, address: $address, createdAt: $createdAt, deletedAt: $deletedAt, email: $email, fullName: $fullName, mobileNumber: $mobileNumber, alternetMobileNumber: $alternetMobileNumber, companyId: $companyId, updatedAt: $updatedAt, vehicleCount: $vehicleCount, vehicles: $vehicles}';
}
