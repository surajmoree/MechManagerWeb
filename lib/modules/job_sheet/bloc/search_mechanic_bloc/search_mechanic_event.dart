import 'package:equatable/equatable.dart';

class SearchMechanicEvent extends Equatable
{
 const  SearchMechanicEvent();

  @override
  List<Object?> get props => [];
  
}

class SearchMechanic extends SearchMechanicEvent
{
  final String? searchKeyword;
  const SearchMechanic({this.searchKeyword});
}
