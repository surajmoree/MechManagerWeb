import 'package:equatable/equatable.dart';

class CustomerComplaintModel extends Equatable {
  final int? id;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? customerComplaint;

  final String? updatedAt;

  const CustomerComplaintModel({
    this.id,
    this.createdAtDate,
    this.createdAtTime,
    this.customerComplaint,
    this.updatedAt,
  });

  @override
  List<Object> get props => [
        id!,
        createdAtDate!,
        createdAtTime!,
        customerComplaint!,
        updatedAt!,
      ];

  CustomerComplaintModel copyWith(int? id,
      {String? createdAtDate,
      String? createdAtTime,
      String? customerComplaint,
      String? updatedAt}) {
    CustomerComplaintModel customerComplaintModel = CustomerComplaintModel(
      id: id ?? this.id,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      customerComplaint: customerComplaint ?? this.customerComplaint,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return customerComplaintModel;
  }

  factory CustomerComplaintModel.fromJson(Map<String, dynamic> json) {
    return CustomerComplaintModel(
      id: json['id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerComplaint: json['customer_complaints'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  @override
  String toString() =>
      '{id: $id,createdAt: $createdAtDate, deletedAt: $createdAtTime, customerComplaint: $customerComplaint,  updatedAt: $updatedAt}';
}
