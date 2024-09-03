import 'dart:convert';

import 'package:equatable/equatable.dart';

class JobSheetModel extends Equatable {
  final int? id;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? customerAdress;
  final List<dynamic>? customerComplaints;
  final String? customerEmail;
  final String? companyName;
  final String? customerMobileNumber;
  final String? customerName;
  final String? deletedAt;
  String? servicingDate;
  final String? fuel;
  final List<dynamic>? items;
  final String? jobSheetId;
  final String? kms;
  final String? taskToDo;
  final String? updatedAt;
  final String? vehicleManufacturers;
  String? vehicleStatus;
  final int? timestamp;
  final String? vehicleName;
  final String? vehicleNumber;
  final List<dynamic>? assignMechanics;

  JobSheetModel(
      {this.id,
      this.createdAtDate,
      this.createdAtTime,
      this.customerAdress,
      this.customerComplaints,
      this.customerEmail,
      this.companyName,
      this.customerMobileNumber,
      this.customerName,
      this.deletedAt,
      this.servicingDate,
      this.fuel,
      this.items,
      this.jobSheetId,
      this.kms,
      this.taskToDo,
      this.updatedAt,
      this.vehicleManufacturers,
      this.vehicleStatus,
      this.timestamp,
      this.vehicleName,
      this.vehicleNumber,
      this.assignMechanics});

  @override
  List<Object> get props => [
        id!,
        createdAtDate!,
        createdAtTime!,
        customerAdress!,
        customerComplaints!,
        customerEmail!,
        companyName!,
        customerMobileNumber!,
        customerName!,
        deletedAt!,
        servicingDate!,
        fuel!,
        items!,
        jobSheetId!,
        kms!,
        taskToDo!,
        updatedAt!,
        vehicleManufacturers!,
        vehicleStatus!,
        timestamp!,
        vehicleName!,
        vehicleNumber!,
        assignMechanics!
      ];

  JobSheetModel copyWith(
      {int? id,
      String? createdAtDate,
      String? createdAtTime,
      String? customerAdress,
      List<dynamic>? customerComplaints,
      String? customerEmail,
      String? customerMobileNumber,
      String? customerName,
      String? companyName,
      String? deletedAt,
      String? servicingDate,
      String? fuel,
      List<dynamic>? items,
      String? jobSheetId,
      String? kms,
      String? taskToDo,
      String? updatedAt,
      String? vehicleManufacturers,
      String? vehicleStatus,
      int? timestamp,
      String? vehicleName,
      String? vehicleNumber,
      List<dynamic>? assignMechanics}) {
    JobSheetModel jobSheetModel = JobSheetModel(
        id: id ?? this.id,
        createdAtDate: createdAtDate ?? this.createdAtDate,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        customerAdress: customerAdress ?? this.customerAdress,
        customerComplaints: customerComplaints ?? this.customerComplaints,
        customerEmail: customerEmail ?? this.customerEmail,
        companyName: companyName ?? this.companyName,
        customerMobileNumber: customerMobileNumber ?? this.customerMobileNumber,
        customerName: customerName ?? this.customerName,
        deletedAt: deletedAt ?? this.deletedAt,
        servicingDate: servicingDate ?? this.servicingDate,
        fuel: fuel ?? this.fuel,
        items: items ?? this.items,
        jobSheetId: jobSheetId ?? this.jobSheetId,
        kms: kms ?? this.kms,
        taskToDo: taskToDo ?? this.taskToDo,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicleManufacturers: vehicleManufacturers ?? this.vehicleManufacturers,
        vehicleStatus: vehicleStatus ?? this.vehicleStatus,
        timestamp: timestamp ?? this.timestamp,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        assignMechanics: assignMechanics ?? this.assignMechanics);
    return jobSheetModel;
  }

  factory JobSheetModel.fromJson(Map<String, dynamic> json) {
    return JobSheetModel(
        id: json['id'] ?? 0,
        createdAtDate: json['created_at_date'] ?? "",
        createdAtTime: json['created_at_time'] ?? "",
        customerAdress: json['customer_address'] ?? "",
        customerComplaints: jsonDecode(json['customer_complaints']) ?? [],
        customerEmail: json['customer_email'] ?? "",
        companyName: json['company_name'] ?? "",
        customerMobileNumber: json['customer_mobile_number'] ?? "",
        customerName: json['customer_name'] ?? "",
        deletedAt: json['deleted_at'] ?? "",
        servicingDate: json['due_date'] ?? "",
        fuel: json['fuel'] ?? "",
        items: jsonDecode(json['items']) ?? "",
        jobSheetId: json['job_sheet_id'] ?? "",
        kms: json['kms'] ?? "",
        taskToDo: json['task_to_do'] ?? "",
        updatedAt: json['updated_at'] ?? "",
        vehicleManufacturers: json['vehicle_manufacturers'] ?? "",
        vehicleStatus: json['status'] ?? "",
        timestamp: int.parse(json['timestamp'].toString()),
        vehicleName: json['vehicle_name'] ?? "",
        vehicleNumber: json['vehicle_number'] ?? "",
        assignMechanics: jsonDecode(json['assign_mechanics']) ?? "");
  }

  @override
  String toString() =>
      '{id: $id, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime, customerAdress: $customerAdress,companyname:$companyName, customerComplaints: $customerComplaints, customerEmail: $customerEmail, customerMobileNumber: $customerMobileNumber, customerName: $customerName, deletedAt: $deletedAt,servicingDate:$servicingDate, fuel: $fuel, items: $items, jobSheetId: $jobSheetId, kms: $kms, taskToDo: $taskToDo, updatedAt: $updatedAt, vehicleManufacturers: $vehicleManufacturers,vehicleStatus:$vehicleStatus,vehicleName: $vehicleName, vehicleNumber: $vehicleNumber. assignMechanics: $assignMechanics}';
}
