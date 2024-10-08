import 'dart:convert';

import 'package:equatable/equatable.dart';

class InvoiceModel extends Equatable {
  final String? address;
  final List<dynamic>? assignMechanics;
  final int? companyId;
  final String? createdAtDate;
  final String? createdAtTime;
  // final String? createdBy;
  final List<dynamic>? customerComplaints;
  final int? customerId;
  final String? deletedAt;
  final String? email;
  final String? invoiceTotal;
  final int? invoiceId;
  final String? invoiceNumber;
  final String? fullName;
  final List<dynamic>? invoiceLabours;
  final List<dynamic>? invoiceProducts;
  final List<dynamic>? items;
  final String? labourTotal;
  final int? lastinvoiceId;
  final String? manufacturers;
  final String? mobileNumber;
  final String? productTotal;
  final String? tempDate;
  final String? updatedAt;
  final String? kms;
  final int? vehicleId;
  final String? vehicleName;
  final String? vehicleNumber;

  const InvoiceModel({
    this.address,
    this.assignMechanics,
    this.companyId,
    this.createdAtDate,
    this.createdAtTime,
    // this.createdBy,
    this.customerComplaints,
    this.customerId,
    this.deletedAt,
    this.email,
    this.invoiceTotal,
    this.invoiceId,
    this.invoiceNumber,
    this.fullName,
    this.invoiceLabours,
    this.invoiceProducts,
    this.items,
    this.labourTotal,
    this.lastinvoiceId,
    this.manufacturers,
    this.mobileNumber,
    this.productTotal,
    this.tempDate,
    this.updatedAt,
    this.vehicleId,
    this.vehicleName,
    this.kms,
    this.vehicleNumber,
  });
  @override
  List<Object> get props => [
        address!,
        assignMechanics!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
        // createdBy!,
        customerComplaints!,
        customerId!,
        deletedAt!,
        email!,
        invoiceTotal!,
        invoiceId!,
        invoiceNumber!,
        fullName!,
        invoiceLabours!,
        invoiceProducts!,
        items!,
        labourTotal!,
        lastinvoiceId!,
        manufacturers!,
        mobileNumber!,
        productTotal!,
        tempDate!,
        updatedAt!,
        vehicleId!,
        vehicleName!,
        vehicleNumber!,
        kms!
      ];
  InvoiceModel copyWith({
    String? address,
    List<dynamic>? assignMechanics,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    // String? createdBy,
    List<dynamic>? customerComplaints,
    int? customerId,
    String? deletedAt,
    String? email,
    String? invoiceTotal,
    int? invoiceId,
    String? invoiceNumber,
    String? fullName,
    String? kms,
    List<dynamic>? invoiceLabours,
    List<dynamic>? invoiceProducrts,
    List<dynamic>? items,
    String? labourTotal,
    int? lastinvoiceId,
    String? manufacturers,
    String? mobileNumber,
    String? productTotal,
    String? tempDate,
    String? updatedAt,
    int? vehicleId,
    String? vehicleName,
    String? vehicleNumber,
  }) {
    InvoiceModel invoiceModel = InvoiceModel(
        address: address ?? this.address,
        assignMechanics: assignMechanics ?? this.assignMechanics,
        companyId: companyId ?? this.companyId,
        createdAtDate: createdAtDate ?? this.createdAtDate,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        // createdBy: createdBy ?? this.createdBy,
        customerComplaints: customerComplaints ?? this.customerComplaints,
        customerId: customerId ?? this.customerId,
        deletedAt: deletedAt ?? this.deletedAt,
        email: email ?? this.email,
        invoiceTotal: invoiceTotal ?? this.invoiceTotal,
        invoiceId: invoiceId ?? this.invoiceId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        fullName: fullName ?? this.fullName,
        invoiceLabours: invoiceLabours ?? this.invoiceLabours,
        invoiceProducts: invoiceProducts ?? this.invoiceProducts,
        items: items ?? this.items,
        kms: kms ?? this.kms,
        labourTotal: labourTotal ?? this.labourTotal,
        lastinvoiceId: lastinvoiceId ?? this.lastinvoiceId,
        manufacturers: manufacturers ?? this.manufacturers,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        tempDate: tempDate ?? this.tempDate,
        productTotal: productTotal ?? this.productTotal,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicleId: vehicleId ?? this.vehicleId,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber);
    return invoiceModel;
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      address: json['address'] ?? "",
      assignMechanics: json['assign_mechanics'] != "[]"
          ? jsonDecode(json['assign_mechanics'])
          : [],
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerComplaints: json['customer_complaints'] != "[]"
          ? jsonDecode(json['customer_complaints'])
          : [],
      customerId: json['customer_id'] ?? 0,
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      kms: json['kms'] ?? "",
      invoiceTotal: json['invoiceTotal'].toString() ?? "",
      invoiceId: json['invoice_id'] ?? 0,
      invoiceNumber: json['invoice_number'].toString() ?? "",
      fullName: json['full_name'] ?? "",
      invoiceLabours: json['invoice_labours'] != ""
          ? jsonDecode(json['invoice_labours'])
          : [],
      invoiceProducts: json['invoice_products'] != ""
          ? jsonDecode(json['invoice_products'])
          : [],
      items: json['items'] != "[]" ? jsonDecode(json['items']) : [],
      labourTotal: json['labourTotal'].toString() ?? "",
      lastinvoiceId: json['last_invoice_id'] ?? 0,
      manufacturers: json['manufacturers'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      productTotal: json['productTotal'].toString() ?? "",
      updatedAt: json['updated_at'] ?? "",
      vehicleId: json['vehicle_id'] ?? 0,
      vehicleName: json['vehicle_name'] ?? "",
      vehicleNumber: json['vehicle_number'] ?? "",
    );
  }
  static const empty = InvoiceModel(
      address: "",
      assignMechanics: [],
      companyId: 0,
      createdAtDate: "",
      createdAtTime: "",
      // createdBy: "",
      customerComplaints: [],
      customerId: 0,
      deletedAt: "",
      email: "",
      invoiceTotal: "",
      invoiceId: 0,
      invoiceNumber: "",
      fullName: "",
      invoiceLabours: [],
      kms: "",
      invoiceProducts: [],
      items: [],
      labourTotal: "",
      lastinvoiceId: 0,
      manufacturers: "",
      mobileNumber: "",
      productTotal: "",
      tempDate: "",
      updatedAt: "",
      vehicleId: 0,
      vehicleName: "",
      vehicleNumber: "");

  @override
  String toString() =>
      '{address:$address,assignMechanics:$assignMechanics,companyId:$companyId,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,customerComplaints:$customerComplaints,customerId:$customerId,deletedAt:$deletedAt,email:$email,invoiceTotal:$invoiceTotal,invoiceNumber:$invoiceNumber,fullName:$fullName,invoiceLabours:$invoiceLabours,kms:$kms,invoiceProducts:$invoiceProducts,items:$items,labourTotal:$labourTotal,lastinvoiceId:$lastinvoiceId,manufacturers:$manufacturers,mobileNumber:$mobileNumber,temp_date:$tempDate,productTotal:$productTotal,updatedAt:$updatedAt,vehicleId:$vehicleId,vehicleName:$vehicleName,vehicleNumber:$vehicleNumber}';
}