import 'package:equatable/equatable.dart';

class CustomerInfoInvoiceListModel extends Equatable {
  final int? id;
  final String? fullName;
  final String? invoiceTotal;
  final int? invoiceNumber;
  final String? vehicleId;
  final String? vehicleName;
  final String? vehicleNumber;

  const CustomerInfoInvoiceListModel(
      {this.id,
      this.fullName,
      this.invoiceTotal,
      this.invoiceNumber,
      this.vehicleId,
      this.vehicleName,
      this.vehicleNumber});

  @override
  List<Object?> get props => [
        id,
        fullName,
        invoiceTotal,
        invoiceNumber,
        vehicleId,
        vehicleName,
        vehicleNumber
      ];

  CustomerInfoInvoiceListModel copyWith({
    int? id,
    String? fullName,
    String? invoiceTotal,
    int? invoiceNumber,
    String? vehicleId,
    String? vehicleName,
    String? vehicleNumber,
  }) {
    return CustomerInfoInvoiceListModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        invoiceTotal: invoiceTotal ?? this.invoiceTotal,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        vehicleId: vehicleId ?? this.vehicleId,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber);
  }

  factory CustomerInfoInvoiceListModel.fromJson(Map<String, dynamic> json) {
    return CustomerInfoInvoiceListModel(
        id: json['id'] ?? 0,
        fullName: json['full_name'] ?? '',
        invoiceTotal: json['invoiceTotal'] ?? '',
        invoiceNumber: json['invoice_number'] ?? 0,
        vehicleId: json['vehicle_id'] ?? '',
        vehicleName: json['vehicle_name'] ?? '',
        vehicleNumber: json['vehicle_number'] ?? '');
  }
}
