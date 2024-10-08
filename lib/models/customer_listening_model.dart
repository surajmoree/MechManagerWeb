import 'package:equatable/equatable.dart';

class CustomerListingModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? fullName;
  final String? mobileNumber;
  final String? updatedAt;
   final int? timestamp;

  const CustomerListingModel(
      {this.id,
      this.address,
      this.createdAt,
      this.deletedAt,
      this.email,
      this.fullName,
      this.mobileNumber,
      this.updatedAt,
      this.timestamp});

  @override
  List<Object> get props => [
        id!,
        address!,
        createdAt!,
        deletedAt!,
        email!,
        fullName!,
        mobileNumber!,
        updatedAt!,
        timestamp!
      ];

  CustomerListingModel copyWith(
      {int? id,
      String? address,
      String? createdAt,
      String? deletedAt,
      String? email,
      String? fullName,
      String? mobileNumber,
      String? updatedAt,
      int? timestamp
      }) {
    CustomerListingModel customerModel = CustomerListingModel(
      id: id ?? this.id,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      updatedAt: updatedAt ?? this.updatedAt,
      timestamp: timestamp ?? this.timestamp
    );
    return customerModel;
  }

  factory CustomerListingModel.fromJson(Map<String, dynamic> json) {
    return CustomerListingModel(
      id: json['id'] ?? 0,
      address: json['address'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      fullName: json['full_name'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      timestamp:int.parse( json['timestamp'].toString()),
    );
  }


  @override
  String toString() =>
      '{id: $id, address: $address,  createdAt: $createdAt, deletedAt: $deletedAt, email: $email, fullName: $fullName, mobileNumber: $mobileNumber  updatedAt: $updatedAt}';
}
