import 'package:equatable/equatable.dart';

class CustomerInfoEstimateListModel extends Equatable {
  final int? id;
  final int? estimateNumber;
  final String? estimateTotal;
  final String? fullName;
  final String? vehicleId;
  final String? vehicleName;
  final String? vehicleNumber;

  const CustomerInfoEstimateListModel(
      {this.id,
      this.estimateNumber,
      this.estimateTotal,
      this.fullName,
      this.vehicleId,
      this.vehicleName,
      this.vehicleNumber});

  @override
  List<Object?> get props => [
        id,
        estimateNumber,
        estimateTotal,
        fullName,
        vehicleId,
        vehicleName,
        vehicleNumber
      ];

  CustomerInfoEstimateListModel copyWith({
    int? id,
    int? estimateNumber,
    String? estimateTotal,
    String? fullName,
    String? vehicleId,
    String? vehicleName,
    String? vehicleNumber,
  }) {
    return CustomerInfoEstimateListModel(
        id: id ?? this.id,
        estimateNumber: estimateNumber ?? this.estimateNumber,
        estimateTotal: estimateTotal ?? this.estimateTotal,
        fullName: fullName ?? this.fullName,
        vehicleId: vehicleId ?? this.vehicleId,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber);
  }

  factory CustomerInfoEstimateListModel.fromJson(Map<String, dynamic> json) {
    return CustomerInfoEstimateListModel(
      id: json['id'] ?? 0,
      estimateNumber: json['estimate_number'] ?? 0,
      estimateTotal: json['estimateTotal'] ?? '',
      fullName: json['full_name'] ?? '',
      vehicleId: json['vehicle_id'] ?? '',
      vehicleName: json['vehicle_name'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
    );
  }
}
