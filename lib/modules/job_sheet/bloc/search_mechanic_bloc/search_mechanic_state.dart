import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/mechanic_listeningmodel.dart';

enum MechanicStatus { initial, success, failure }

class SearchMechanicState extends Equatable {
  MechanicStatus? status;
  List<MechanicListingModel>? mechanicList;

  SearchMechanicState(
      {this.status = MechanicStatus.initial, this.mechanicList = const []});

  @override
  List<Object> get props => [status!, mechanicList!];

  SearchMechanicState copyWith({
    MechanicStatus? status,
    List<MechanicListingModel>? mechanicList,
  }) {
    return SearchMechanicState(
      status: status ?? this.status,
      mechanicList: mechanicList ?? this.mechanicList,
    );
  }
}