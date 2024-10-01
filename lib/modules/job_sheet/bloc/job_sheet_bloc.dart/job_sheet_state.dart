import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/dashboard_model.dart';
import 'package:mech_manager/models/estimate_listiening_model.dart';
import 'package:mech_manager/models/invoice_listening_model.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/models/labour_listeningmodel.dart';
import 'package:mech_manager/models/mechanic_listeningmodel.dart';
import 'package:mech_manager/models/spare_part_model.dart';

enum jobSheetStatus {
  initial,
  loading,
  success,
  failure,
  submitSuccess,
  invoiceSuccess,
  estimateSuccess,
  mechanicSuccess,
  labourSuccess,
  invoiceSubmitSuccess,
  submitFailure,
  sending,
  updating,
  updated
}

class JobSheetState extends Equatable {
  jobSheetStatus? status;
  List<JobSheetModel> jobSheetList;
  DashboardModel? dashboardModel;
  List<EstimateListingModel> estimateListing;
  List<InvoiceListingModel> invoiceListing;
  List<SparePartModel> sparePartListing;
  List<MechanicListingModel> mechanicListing;
  List<LabourModelListingModel> labourListing;

  int? lastTimestamp;
  int? currentEstimateId;
 
  int? currentInvoiceId;
  int? page;
  bool? hasReachedMax;
  bool? loadShow;
  int? totalPages;

  JobSheetState({
    this.status = jobSheetStatus.initial,
    this.jobSheetList = const [],
    this.estimateListing = const [],
    this.invoiceListing = const [],
    this.sparePartListing = const [],
    this.mechanicListing = const [],
    this.labourListing = const [],
    this.dashboardModel = DashboardModel.empty,
    this.lastTimestamp,
    this.page = 1,
    this.hasReachedMax = false,
    this.loadShow = false,
    this.totalPages = 1,
   
    this.currentEstimateId = 0,
   
    this.currentInvoiceId = 0,
  });

  @override
  List<Object> get props => [
        status!,
        jobSheetList,
       dashboardModel!,
       invoiceListing,
       sparePartListing,
       mechanicListing,
       labourListing,
        page!,
        hasReachedMax!,
        loadShow!,
        totalPages!,
        estimateListing,
      
        currentEstimateId!,
      
        currentInvoiceId!,
      ];

  JobSheetState copyWith(
      {jobSheetStatus? status,
      List<JobSheetModel>? jobSheetList,
      DashboardModel? dashboardModel,
      int? lastTimestamp,
      List<EstimateListingModel>? estimateListing,
      int? currentEstimateId,
      List<LabourModelListingModel>? labourListing,
      List<InvoiceListingModel>? invoiceListing,
       List<SparePartModel>? sparePartListing,
       List<MechanicListingModel>? mechanicListing,
      int? currentInvoiceId,
      int? page,
      bool? hasReachedMax,
      bool? loadShow,
      int? totalPages}) {
    return JobSheetState(
        status: status ?? this.status,
        jobSheetList: jobSheetList ?? this.jobSheetList,
        dashboardModel: dashboardModel ?? this.dashboardModel,
        currentEstimateId: currentEstimateId ?? this.currentEstimateId,
        estimateListing: estimateListing ?? this.estimateListing,
        invoiceListing: invoiceListing ?? this.invoiceListing,
        sparePartListing: sparePartListing?? this.sparePartListing,
        mechanicListing : mechanicListing?? this.mechanicListing,
        labourListing: labourListing?? this.labourListing,
        lastTimestamp: lastTimestamp ?? this.lastTimestamp,
    
        currentInvoiceId: currentInvoiceId ?? this.currentInvoiceId,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        loadShow: loadShow ?? this.loadShow,
        totalPages: totalPages ?? this.totalPages);
  }
}