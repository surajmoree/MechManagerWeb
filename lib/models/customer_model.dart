import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? fullName;
  final String? mobileNumber;
  final String? updatedAt;

  const CustomerModel(
      {this.id,
      this.address,
      this.createdAt,
      this.deletedAt,
      this.email,
      this.fullName,
      this.mobileNumber,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        address!,
        createdAt!,
        deletedAt!,
        email!,
        fullName!,
        mobileNumber!,
        updatedAt!
      ];

  CustomerModel copyWith(
      {int? id,
      String? address,
      String? createdAt,
      String? deletedAt,
      String? email,
      String? fullName,
      String? mobileNumber,
      String? updatedAt}) {
    CustomerModel customerModel = CustomerModel(
      id: id ?? this.id,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return customerModel;
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      address: json['address'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      fullName: json['full_name'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      updatedAt: json['updated_at'] ?? "",
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
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id, address: $address,  createdAt: $createdAt, deletedAt: $deletedAt, email: $email, fullName: $fullName, mobileNumber: $mobileNumber  updatedAt: $updatedAt}';
}