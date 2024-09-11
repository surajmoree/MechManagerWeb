import 'package:equatable/equatable.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';

class JobSheetEvent extends Equatable {
  const JobSheetEvent();

  @override
  List<Object> get props => [];
}


class FetchJobSheets extends JobSheetEvent {
    final int? timestamp;
    final String? searchKeyword;
    final String? direction;
    final String? fromDate;
    final String? lastRecordUpdatedTime;
    final String? toDate;
    final jobSheetStatus? status;
    const FetchJobSheets({
      this.timestamp,
      this.searchKeyword,
      this.direction,
      this.fromDate,
      this.toDate,
      this.lastRecordUpdatedTime,
      required this.status,
    });
  }

  class FetchDashboard extends JobSheetEvent
  {
    final jobSheetStatus? status;

 const FetchDashboard({ this.status});
  }

class DeleteJobSheet extends JobSheetEvent {
  final String id;
  const DeleteJobSheet({required this.id});
}