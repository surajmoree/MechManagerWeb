import 'package:equatable/equatable.dart';

class CustomerInfoJobCardListModel extends Equatable {
  final int? id;
  final String? createdDate;
  final String? createdTime;
  final String? customerName;
  final String? jobcardStatus;
  final String? vehicleId;
  final String? vehicleManufat;  // New field
  final String? vehicleName;  // New field
  final String? vehicleNumber;
  

  const CustomerInfoJobCardListModel({
    this.createdDate,
    this.createdTime,
    this.customerName,
    this.id,
    this.jobcardStatus,
    this.vehicleId,
    this.vehicleManufat,
    this.vehicleName,
    this.vehicleNumber
  });

  @override
  List<Object?> get props => [
        createdDate,
        createdTime,
        customerName,
        id,
        jobcardStatus,
        vehicleId,
        vehicleManufat,
        vehicleName,
        vehicleNumber

      ];

  CustomerInfoJobCardListModel copyWith({
      int? id,
   String? createdDate,
   String? createdTime,
   String? customerName,
   String? jobcardStatus,
   String? vehicleId,
   String? vehicleManufat,  // New field
   String? vehicleName,  // New field
   String? vehicleNumber,
  }) {
    return CustomerInfoJobCardListModel(
      createdDate: createdDate?? this.createdDate,
      createdTime: createdTime?? this.createdTime,
      customerName:customerName?? this.customerName,
      id: id ?? this.id,
      jobcardStatus: jobcardStatus?? this.jobcardStatus,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicleManufat: vehicleManufat?? this.vehicleManufat,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
    );
  }

  factory CustomerInfoJobCardListModel.fromJson(Map<String, dynamic> json) {
    return CustomerInfoJobCardListModel(
      createdDate: json['created_at_date'] ?? '',
      createdTime: json['created_at_time'] ?? '',
      customerName: json['customer_name'] ?? '',
      id: json['id'] ?? 0,
      jobcardStatus: json['jobcard_status'] ?? '',
      vehicleId: json['vehicle_id'] ?? '',
      vehicleManufat: json['vehicle_manufacturers'] ?? '',
      vehicleName: json['vehicle_name'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
    );
  }

  // @override
  // String toString() {
  //   return 'CustomerInfoModel(estimateTotal: $estimateTotal, estimateNumber: $estimateNumber, fullName: $fullName, id: $id, vehicleId: $vehicleId, vehicleName: $vehicleName, vehicleNumber: $vehicleNumber)';
  // }
}

