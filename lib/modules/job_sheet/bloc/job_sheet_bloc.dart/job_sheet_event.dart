import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
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

class FetchDashboard extends JobSheetEvent {
  final jobSheetStatus? status;

  const FetchDashboard({this.status});
}

class DeleteJobSheet extends JobSheetEvent {
  final String id;
  const DeleteJobSheet({required this.id});
}

class AddJobSheet extends JobSheetEvent {
  final Map<String, dynamic>? formData;
  final XFile frontImage;
  final XFile rightHandSideImage;
  final XFile leftHandSideImage;
  final XFile rearImage;
  final XFile dashboardImage;
  final XFile engineImage;
  final XFile image1;
  final XFile image2;
  final XFile image3;
  final XFile image4;

  const AddJobSheet({
    this.formData,
    required this.frontImage,
    required this.rightHandSideImage,
    required this.leftHandSideImage,
    required this.rearImage,
    required this.dashboardImage,
    required this.engineImage,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
  });
}


class FetchEstimateList extends JobSheetEvent {
  final int? timestamp;
  final String? direction;
  final String? searchKeyword;
  final jobSheetStatus status;
  const FetchEstimateList(
      {this.timestamp,
      this.direction,
      this.searchKeyword,
      required this.status});
}

class DeleteEstimate extends JobSheetEvent {
  final String id;
  const DeleteEstimate({required this.id});
}



class ClearListingData extends JobSheetEvent {
  const ClearListingData();
}


class FetchInvoiceList extends JobSheetEvent {
  final int? timestamp;
  final String? direction;
  final String? searchKeyword;
  final jobSheetStatus? status;
  const FetchInvoiceList({
    this.timestamp,
    this.direction,
    this.searchKeyword,
    required this.status,
  });
}

class DeleteInvoice extends JobSheetEvent {
  final String id;
  const DeleteInvoice({required this.id});
}