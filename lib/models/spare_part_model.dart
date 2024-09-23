import 'package:equatable/equatable.dart';

class SparePartModel extends Equatable {
  final String? createdAt;
  final String? deletedAt;
  final int? productId;
  final String? productName;
  final String? productPrice;
  final String? productQuantity;
  final String? productUnit;
  final String? updatedAt;
  const SparePartModel(
      {this.createdAt,
      this.deletedAt,
      this.productId,
      this.productName,
      this.productPrice,
      this.productQuantity,
      this.productUnit,
      this.updatedAt});

  @override
  List<Object?> get props => [
        createdAt!,
        deletedAt!,
        productId!,
        productName!,
        productPrice!,
        productQuantity!,
        productUnit!,
        updatedAt!
      ];
  SparePartModel copyWith({
    String? createdAt,
    String? deletedAt,
    int? productId,
    String? productName,
    String? productPrice,
    String? productQuantity,
    String? productUnit,
    String? updatedAt,
  }) {
    SparePartModel sparePartModel = SparePartModel(
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productPrice: productPrice ?? this.productPrice,
        productQuantity: productQuantity ?? this.productQuantity,
        productUnit: productUnit ?? this.productUnit,
        updatedAt: updatedAt ?? this.updatedAt);
    return sparePartModel;
  }

  factory SparePartModel.fromJson(Map<String, dynamic> json) {
    return SparePartModel(
        createdAt: json['created_at_time'] ?? "",
        deletedAt: json['deleted_at'] ?? "",
        productId: json['product_id'] ?? 0,
        productName: json['product_name'] ?? "",
        productPrice: json['product_price'] ?? "",
        productQuantity: json['product_qty'] ?? "",
        productUnit: json['product_unit'] ?? "",
        updatedAt: json['updated_at'] ?? "");
  }
  @override
  String toString() =>
      '{ createdAt:$createdAt,deletedAt:$deletedAt,productId:$productId, productName:$productName,productPrice:$productPrice,productQuantity:$productQuantity,productUnit:$productUnit, updatedAt:$updatedAt}';
}
