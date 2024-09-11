import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  final int? delivered;
  final int? newEntries;
  final int? totalCustomer;
  final int? totalEstimate;
  final int? totalInvoice;
  final int? totalLabour;
  final int? totalMechanic;
  final int? totalProduct;
  final int? totalRepair;
  final int? totalSparePart;
  final int? totalVehicle;
  final int? userCount;

 const DashboardModel(
      {this.delivered,
      this.newEntries,
      this.totalCustomer,
      this.totalEstimate,
      this.totalInvoice,
      this.totalLabour,
      this.totalMechanic,
      this.totalProduct,
      this.totalRepair,
      this.totalSparePart,
      this.totalVehicle,
      this.userCount});

  @override
  List<Object> get props => [
        delivered!,
        newEntries!,
        totalCustomer!,
        totalEstimate!,
        totalInvoice!,
        totalLabour!,
        totalMechanic!,
        totalProduct!,
        totalRepair!,
        totalSparePart!,
        totalVehicle!,
        userCount!,
      ];
      
      DashboardModel copyWith({
    int? delivered,
  int? newEntries,
  int? totalCustomer,
  int? totalEstimate,
   int? totalInvoice,
  int? totalLabour,
  int? totalMechanic,
 int? totalProduct,
   int? totalRepair,
   int? totalSparePart,
  int? totalVehicle,
 int? userCount,
      })
      {
    DashboardModel dashboardListingModel = DashboardModel(
        delivered: delivered ?? this.delivered,
        newEntries: newEntries ?? this.newEntries,
        totalCustomer: totalCustomer ?? this.totalCustomer,
        totalEstimate: totalEstimate ?? this.totalEstimate,
        totalInvoice: totalInvoice ?? this.totalInvoice,
        totalLabour: totalLabour ?? this.totalLabour,
        totalMechanic: totalMechanic ?? this.totalMechanic,
        totalProduct: totalProduct ?? this.totalProduct,
        totalRepair: totalRepair ?? this.totalRepair,
        totalSparePart: totalSparePart ?? this.totalSparePart,
        totalVehicle: totalVehicle ?? this.totalVehicle,
        userCount: userCount ?? this.userCount);
    return dashboardListingModel;
  }

    factory DashboardModel.fromJson(Map<String,dynamic> json)
    {
      return DashboardModel(
        delivered: json['delivered'],
      newEntries: json['new_entries'],
      totalCustomer: json['total_customer'],
      totalEstimate: json['total_estimate'],
      totalInvoice: json['total_invoice'],
      totalLabour: json['total_labour'],
      totalMechanic: json['total_mechanics'],
      totalProduct: json['total_product'],
      totalRepair: json['total_repair'],
      totalSparePart: json['total_spare'],
      totalVehicle: json['total_vehicle'],
      userCount: json['user_count'],
      );
    }

    static const empty = DashboardModel(
    delivered: 0,
    newEntries: 0,
    totalCustomer: 0,
    totalEstimate: 0,
    totalInvoice: 0,
    totalLabour: 0,
    totalMechanic: 0,
    totalProduct: 0,
    totalRepair: 0,
    totalSparePart: 0,
    totalVehicle: 0,
    userCount: 0,
  );
     @override
  String toString() =>
      '{"delivered": $delivered,"newEntries": $newEntries,"totalCustomer":$totalCustomer,"totalEstimate":$totalEstimate,"totalInvoice":$totalInvoice,  "totalLabour": $totalLabour, "totalMechanic":$totalMechanic, "totalProduct":$totalProduct, "totalRepair": $totalRepair , "totalSparePart":$totalSparePart  ,"totalVehicle":$totalVehicle, "userCount":$userCount}';

}
