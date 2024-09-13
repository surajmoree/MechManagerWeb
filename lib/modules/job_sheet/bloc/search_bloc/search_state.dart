import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/customer_complaint.dart';
import 'package:mech_manager/models/customer_model.dart';
import 'package:mech_manager/models/vehicle_model.dart';

enum SearchStatus { initial, loading, success,updating, failure }

class SearchState extends Equatable
{
  SearchStatus? status;
  List<CustomerComplaintModel>? customerComplaintList;
  List<VehicleModel>? vehicleDetails;
  List<CustomerModel>? customerList;

  SearchState({
    this.status = SearchStatus.initial,
    this.customerComplaintList = const [],
    this.vehicleDetails = const [],
    this.customerList = const [],
  });
  @override
  List<Object> get props =>[status!,customerComplaintList!,vehicleDetails!,customerList!];

  SearchState copyWith({
    SearchStatus? status,
    List<CustomerComplaintModel>? customerComplaintList,
     List<VehicleModel>? vehicleDetails,
     List<CustomerModel>? customerList,

  })
  {
    return SearchState(
      status: status?? this.status,
      customerComplaintList: customerComplaintList?? this.customerComplaintList,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      customerList: customerList ?? this.customerList,
    );
  }
  
}