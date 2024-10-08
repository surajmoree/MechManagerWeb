import 'package:equatable/equatable.dart';

// class ProductListingModel extends Equatable {
//   final int? allStock;
//   final List<ProductModel>? products;
//   final int? totalInStock;
//   final int? totalOutOfStock;

//   const ProductListingModel({
//     this.allStock,
//     this.products,
//     this.totalInStock,
//     this.totalOutOfStock,
//   });

//   @override
//   List<Object?> get props => [allStock, products, totalInStock, totalOutOfStock];

//   factory ProductListingModel.fromJson(Map<String, dynamic> json) {
//     return ProductListingModel(
//       allStock: json['all_stock'] ?? 0,
//       products: (json['products'] as List<dynamic>?)
//           ?.map((productJson) => ProductModel.fromJson(productJson))
//           .toList(),
//       totalInStock: json['total_in_stock'] ?? 0,
//       totalOutOfStock: json['total_out_of_stock'] ?? 0,
//     );
//   }

//   @override
//   String toString() =>
//       '{allStock: $allStock, products: $products, totalInStock: $totalInStock, totalOutOfStock: $totalOutOfStock}';
// }

class StockListeningModel extends Equatable {
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final String? description;
  final String? hsnCode;
  final int? id;
  final String? manufactured;
  final double? purchasePrice;
  final double? salesPrice;
  final String? sparePartCat;
  final String? sparePartCode;
  final String? sparePartName;
  final int? stockQuantity;
  final String? tag;
  final double? tax;
  final int? timestamp;
  final String? unitType;
  final String? updatedAt;

  const StockListeningModel({
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.description,
    this.hsnCode,
    this.id,
    this.manufactured,
    this.purchasePrice,
    this.salesPrice,
    this.sparePartCat,
    this.sparePartCode,
    this.sparePartName,
    this.stockQuantity,
    this.tag,
    this.tax,
    this.timestamp,
    this.unitType,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        createdAtDate,
        createdAtTime,
        deletedAt,
        description,
        hsnCode,
        id,
        manufactured,
        purchasePrice!,
        salesPrice!,
        sparePartCat,
        sparePartCode,
        sparePartName,
        stockQuantity!,
        tag,
        tax!,
        timestamp!,
        unitType,
        updatedAt,
      ];

  factory StockListeningModel.fromJson(Map<String, dynamic> json) {
    return StockListeningModel(
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      description: json['description'] ?? "",
      hsnCode: json['hsn_code'] ?? "",
      id: json['id'] ?? 0,
      manufactured: json['manufactured'] ?? "",
      purchasePrice: (json['purchase_price'] as num?)?.toDouble() ?? 0.0,
      salesPrice: (json['sales_price'] as num?)?.toDouble() ?? 0.0,
      sparePartCat: json['spare_part_cat'] ?? "",
      sparePartCode: json['spare_part_code'] ?? "",
      sparePartName: json['spare_part_name'] ?? "",
      stockQuantity: json['stock_quantity'] ?? 0,
      tag: json['tag'] ?? "",
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      timestamp: int.parse(json['timestamp'].toString()),
      unitType: json['unit_type'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  @override
  String toString() => 
      '{id: $id, sparePartName: $sparePartName, purchasePrice: $purchasePrice, salesPrice: $salesPrice}';
}
