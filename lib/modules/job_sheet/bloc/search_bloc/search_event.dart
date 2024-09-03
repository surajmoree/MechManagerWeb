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
