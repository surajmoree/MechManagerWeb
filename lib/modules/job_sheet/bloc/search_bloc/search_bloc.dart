import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/customer_complaint.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>
{ 
  SearchBloc() : super(SearchState())
  {
    on<SearchCustomerComplaint>(_onSearchCustomerComplaint);
  }

  _onSearchCustomerComplaint(SearchCustomerComplaint event, Emitter<SearchState>emit)async
  {
    dynamic token = await storage.read(key: 'token');

    Map<String,Object> jsonData =
    {
      "token": token.toString(),
      "search": event.searchKeyword.toString(),
    };

    final result = await jobSheetRepository.searchCustomerComplaint(jsonData);
    if(result != null && result.isNotEmpty)
    {
      emit(state.copyWith(status: SearchStatus.success,customerComplaintList: result
              .map<CustomerComplaintModel>(
                  (jsonData) => CustomerComplaintModel.fromJson(jsonData))
              .toList()));
    }
  }

}