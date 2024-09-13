import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable
{
 const SearchEvent();
  @override
  List<Object?> get props => [];
  
}

class SearchCustomerComplaint extends SearchEvent {
  final String searchKeyword;
  const SearchCustomerComplaint({required this.searchKeyword});
}

class SearchVehicleDetails extends SearchEvent {
  final String searchKeyword;
  const SearchVehicleDetails({required this.searchKeyword});
}

class SearchCustomerDetails extends SearchEvent {
  final String searchKeyword;
  const SearchCustomerDetails({required this.searchKeyword});
}

