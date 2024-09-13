import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/customer_complaint.dart';
import 'package:mech_manager/models/customer_model.dart';
import 'package:mech_manager/models/vehicle_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>
{ 
  SearchBloc() : super(SearchState())
  {
    on<SearchVehicleDetails>(_onSearchVehicleDetails);
    on<SearchCustomerComplaint>(_onSearchCustomerComplaint);
    on<SearchCustomerDetails>(_onSearchCustomerDetails);
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

  _onSearchVehicleDetails(SearchVehicleDetails event, Emitter<SearchState> emit)async
  {
    dynamic token = await storage.read(key: "token");

    Map<String, Object> jsonData = {
       "token": token.toString(),
      "search": event.searchKeyword.toString()
    };

    final result = await jobSheetRepository.searchVehicleDetails(jsonData);

     if (result != null && result.isNotEmpty) {
      return emit(state.copyWith(
          status: SearchStatus.success,
          vehicleDetails: result
              .map<VehicleModel>((jsonData) => VehicleModel.fromJson(jsonData))
              .toList()));
    }
  }

  _onSearchCustomerDetails(SearchCustomerDetails event,Emitter<SearchState>emit)async
  {
    dynamic token = await storage.read(key: 'token');

    Map<String,Object> jsonData =
    {
      "token" : token.toString(),
      "search": event.searchKeyword.toString(),
    };

    final result = await jobSheetRepository.searchCustomerDetails(jsonData);

    if(result != null && result.isNotEmpty)
    {
      emit(state.copyWith(status: SearchStatus.success,customerList: result.map<CustomerModel>((jsonData) => CustomerModel.fromJson(jsonData  )).toList()));
    }

  }

}