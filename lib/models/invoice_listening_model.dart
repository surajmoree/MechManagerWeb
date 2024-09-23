import 'package:equatable/equatable.dart';

class InvoiceListingModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAtTime;
  final String? deletedAt;
  final String? email;
  final int? flag;
  final String? fullname;
  final String? invoiceTotal;
  final int? invoiceNumber;
  final String? manufacturers;
  final String? mobileNumber;
  final String? tempDate;
  final int? timestamp;
  final String? updateAt;
  final String? vehicleName;
  final String? vehicleNumber;

  const InvoiceListingModel({
    this.id,
    this.flag,
    this.fullname,
    this.manufacturers,
    this.invoiceTotal,
    this.invoiceNumber,
    this.mobileNumber,
    this.updateAt,
    this.vehicleName,
    this.vehicleNumber,
    this.tempDate,
    this.timestamp,
    this.address,
    this.createdAtTime,
    this.deletedAt,
    this.email,
  });

  @override
  List<Object> get props => [
        id!,
        address!,
        createdAtTime!,
        deletedAt!,
        email!,
        flag!,
        fullname!,
        invoiceNumber!,
        invoiceTotal!,
        manufacturers!,
        vehicleName!,
        tempDate!,
        timestamp!,
        vehicleNumber!,
        mobileNumber!,
        updateAt!,
      ];

  InvoiceListingModel copyWith({
    int? id,
    String? address,
    String? createdAtTime,
    String? deletedAt,
    String? email,
    int? invoiceNumber,
    String? invoiceTotal,
    int? flag,
    String? fullname,
    String? manufacturers,
    String? mobileNumber,
    String? tempDate,
    int? timestamp,
    String? updateAt,
    String? vehicleName,
    String? vehicleNumber,
  }) {
    InvoiceListingModel invoiceListingModel = InvoiceListingModel(
        id: id ?? this.id,
        address: address ?? this.address,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        deletedAt: deletedAt ?? this.deletedAt,
        email: email ?? this.email,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        invoiceTotal: invoiceTotal ?? this.invoiceTotal,
        flag: flag ?? this.flag,
        fullname: fullname ?? this.fullname,
        manufacturers: manufacturers ?? this.manufacturers,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        tempDate: tempDate ?? this.tempDate,
        timestamp: timestamp ?? this.timestamp,
        updateAt: updateAt ?? this.updateAt,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber);
    return invoiceListingModel;
  }

  factory InvoiceListingModel.fromJson(Map<String, dynamic> json) {

    return InvoiceListingModel(
      id: json['id'] ?? 0,
      address: json['address'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      invoiceNumber: json['invoice_number'] ?? 0,
      invoiceTotal: json['invoiceTotal'].toString() ?? "",
      flag: json['flag'] ?? 0,
      fullname: json['full_name'] ?? "",
      manufacturers: json['manufacturers'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      timestamp: int.parse(json['timestamp'].toString()),
      updateAt: json['updated_at'] ?? "",
      vehicleName: json['vehicle_name'] ?? "",
      vehicleNumber: json['vehicle_number'] ?? "",
    );
  }

  @override
  String toString() =>
      '{id: $id, address: $address, createdAtTime: $createdAtTime, deletedAt: $deletedAt, email:$email,invoiceNumber:$invoiceNumber,invoiceTotal:$invoiceTotal,flag:$flag,fullname:$fullname ,manufacturers:$manufacturers,mobileNumber:$mobileNumber,tempdate:$tempDate, updateAt:$updateAt, vehicleName:$vehicleName,vehicleNumber:$vehicleNumber }';
}
