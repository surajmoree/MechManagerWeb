import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/customer_complaint.dart';
import 'package:mech_manager/models/vehicle_model.dart';

enum SearchStatus { initial, loading, success,updating, failure }

class SearchState extends Equatable
{
  SearchStatus? status;
  List<CustomerComplaintModel>? customerComplaintList;
  List<VehicleModel>? vehicleDetails;

  SearchState({
    this.status = SearchStatus.initial,
    this.customerComplaintList = const [],
    this.vehicleDetails = const [],
  });
  @override
  List<Object> get props =>[status!,customerComplaintList!,vehicleDetails!];

  SearchState copyWith({
    SearchStatus? status,
    List<CustomerComplaintModel>? customerComplaintList,
     List<VehicleModel>? vehicleDetails,

  })
  {
    return SearchState(
      status: status?? this.status,
      customerComplaintList: customerComplaintList?? this.customerComplaintList,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
    );
  }
  
}