import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? id;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final String? description;
  final String? hsnCode;
  final String? manufactured;
  final double? purchasePrice;
  final double? salesPrice;
  final String? sparetPartCat;
  final String? sparePartCode;
  final String? sparePartName;
  final int? stockQuantity;
  final double? tax;
  final String? unitType;
  final String? updatedAt;
  const ProductModel(
      {this.id,
      this.createdAtDate,
      this.createdAtTime,
      this.deletedAt,
      this.description,
      this.hsnCode,
      this.manufactured,
      this.purchasePrice,
      this.salesPrice,
      this.sparetPartCat,
      this.sparePartCode,
      this.sparePartName,
      this.stockQuantity,
      this.tax,
      this.unitType,
      this.updatedAt});

  @override
  List<Object?> get props => [
        id!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        description!,
        hsnCode!,
        manufactured!,
        purchasePrice!,
        salesPrice!,
        sparetPartCat!,
        sparePartCode!,
        sparePartName!,
        stockQuantity!,
        tax!,
        unitType!,
        updatedAt!
      ];
  ProductModel copyWith({
    int? id,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    String? description,
    String? hsnCode,
    String? manufactured,
    double? purchasePrice,
    double? salesPrice,
    String? sparetPartCat,
    String? sparePartCode,
    String? sparePartName,
    int? stockQuantity,
    double? tax,
    String? unitType,
    String? updatedAt,
  }) {
    ProductModel productModel = ProductModel(
        id: id ?? this.id,
        createdAtDate: createdAtDate ?? this.createdAtDate,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        deletedAt: deletedAt ?? this.deletedAt,
        description: description ?? this.description,
        hsnCode: hsnCode ?? this.hsnCode,
        manufactured: manufactured ?? this.manufactured,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        salesPrice: salesPrice ?? this.salesPrice,
        sparetPartCat: sparetPartCat ?? this.sparetPartCat,
        sparePartCode: sparePartCode ?? this.sparePartCode,
        sparePartName: sparePartName ?? this.sparePartName,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        tax: tax ?? this.tax,
        unitType: unitType ?? this.unitType,
        updatedAt: updatedAt ?? this.updatedAt);
    return productModel;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'] ?? 0,
        createdAtDate: json['created_at_date'] ?? "",
        createdAtTime: json['created_at_time'] ?? "",
        deletedAt: json['deleted_at'] ?? "",
        description: json['description'] ?? "",
        hsnCode: json['hsn_code'] ?? "",
        manufactured: json['manufactured'] ?? "",
        purchasePrice: json['purchase_price'] ?? 0.0,
        salesPrice: json['sales_price'] ?? 0.0,
        sparetPartCat: json['spare_part_cat'] ?? "",
        sparePartCode: json['spare_part_code'] ?? "",
        sparePartName: json['spare_part_name'] ?? "",
        stockQuantity: json['stock_quantity'] ?? 0,
        tax: json['tax'] ?? 0.0,
        unitType: json['unit_type'] ?? "",
        updatedAt: json['updated_at'] ?? "");
  }
  @override
  String toString() =>
      '{id:$id, createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,deletedAt:$deletedAt,description:$description,hsnCode:$hsnCode,manufactured:$manufactured,purchasePrice:$purchasePrice,salesPrice:$salesPrice,sparetPartCat:$sparetPartCat,sparePartCode:$sparePartCode,sparePartName:$sparePartName,stockQuantity:$stockQuantity,tax:$tax,unitType:$unitType,updatedAt:$updatedAt}';
}
