import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/dashboard_model.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/network/repositories/job_sheet_repository.dart';

class JobSheetBloc extends Bloc<JobSheetEvent, JobSheetState> {
  JobSheetBloc() : super(JobSheetState()) {
    on<FetchJobSheets>(_onFetchJobSheets);
    on<DeleteJobSheet>(_onDeleteJobSheet);
    on<FetchDashboard>(_onFetchDashboard);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  // get job listing data
  Future<void> _onFetchJobSheets(
      FetchJobSheets event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.status == jobSheetStatus.success) {
      return;
    }
    emit(
      state.copyWith(
          status: (event.status == jobSheetStatus.success)
              ? jobSheetStatus.success
              : jobSheetStatus.loading),
    );
    dynamic token = await storage.read(key: "token");

    Map<String, String> jsonData = {
      'token': token.toString(),
      'direction': 'down',
      'timestamp':
          event.timestamp?.toString() ?? event.lastRecordUpdatedTime.toString(),
      'search': event.searchKeyword ?? "",
      'fromDate': event.fromDate ?? "",
      'toDate': event.toDate ?? "",
    };

    final result = await jobSheetRepository.getJobSheets(jsonData);

    if (result != null && result.isNotEmpty) {
      List<JobSheetModel> jobSheetsList = result
          .map<JobSheetModel>((jsonData) => JobSheetModel.fromJson(jsonData))
          .toList();

      final bool hasReachedMax = jobSheetsList.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        jobSheetsList = List.from(state.jobSheetList)..addAll(jobSheetsList);
      }

      return emit(state.copyWith(
        status: jobSheetStatus.success,
        jobSheetList: jobSheetsList,
        hasReachedMax: hasReachedMax,
        lastTimestamp: jobSheetsList.last.timestamp,
      ));
    } else {
      return emit(state.copyWith(
          status: jobSheetStatus.success,
          jobSheetList: [],
          hasReachedMax: true));
    }
  }

  //fetch dashoboard

  _onFetchDashboard(FetchDashboard event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(
      status: (event.status == jobSheetStatus.success)
          ? jobSheetStatus.success
          : jobSheetStatus.loading,
    ));
    dynamic token = await storage.read(key: 'token');
    Map<String,String> jsonData ={
   "token" : token.toString(),
    };

    final result = await jobSheetRepository.dashboardData(jsonData);
    print('dashboard data from bloc == $result');
    if(result != null && result.isNotEmpty)
    {
      emit(state.copyWith(status: jobSheetStatus.success,dashboardModel: DashboardModel.fromJson(result)));
    } else {
      return emit(state.copyWith(
        status: jobSheetStatus.failure,
      ));
    }
  }

  //delete jobsheet
  _onDeleteJobSheet(DeleteJobSheet event, Emitter<JobSheetState> emit) async {
    emit(state.copyWith(status: jobSheetStatus.updating));
    dynamic token = await storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final result = await jobSheetRepository.deleteJobSheet(jsonData);

    if (result['status'] == "success") {
      // state.jobSheetList
      //     .removeWhere((element) => element.id.toString() == event.id);
      emit(state.copyWith(
          status: jobSheetStatus.success, jobSheetList: state.jobSheetList));
    }
  }
}
