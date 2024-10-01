import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/mechanic_listeningmodel.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_state.dart';

class SearchMechanicBloc extends Bloc<SearchMechanicEvent,SearchMechanicState>
{
SearchMechanicBloc(): super(SearchMechanicState())
{
  on<SearchMechanic>(_onSearchMechanic);
}

_onSearchMechanic(SearchMechanic event, Emitter<SearchMechanicState>emit)async
{
 dynamic token = storage.read(key: 'token');
 Map<String,dynamic> jsonData = 
 {
  "token": token.toString(),
  "search": event.searchKeyword.toString()
 };

 final result = await jobSheetRepository.searchMechanic(jsonData);

 if(result != null && result.isNotEmpty)
 {
  emit(state.copyWith(status: MechanicStatus.success,mechanicList: result
              .map<MechanicListingModel>(
                  (jsonData) => MechanicListingModel.fromJson(jsonData))
              .toList()));
 }
}


}