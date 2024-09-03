import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/customer_complaint.dart';

enum SearchStatus { initial, loading, success,updating, failure }

class SearchState extends Equatable
{
  SearchStatus? status;
  List<CustomerComplaintModel>? customerComplaintList;

  SearchState({
    this.status = SearchStatus.initial,
    this.customerComplaintList = const [],
  });
  @override
  List<Object> get props =>[status!,customerComplaintList!];

  SearchState copyWith({
    SearchStatus? status,
    List<CustomerComplaintModel>? customerComplaintList

  })
  {
    return SearchState(
      status: status?? this.status,
      customerComplaintList: customerComplaintList?? this.customerComplaintList,
    );
  }
  
}