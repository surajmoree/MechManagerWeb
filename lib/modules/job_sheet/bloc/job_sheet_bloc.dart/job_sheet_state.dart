import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/customer_info_estimate_list_model.dart';
import 'package:mech_manager/models/customer_info_invoice_list_model.dart';
import 'package:mech_manager/models/customer_info_jobcard_list_model.dart';
import 'package:mech_manager/models/customer_listening_model.dart';
import 'package:mech_manager/models/dashboard_model.dart';
import 'package:mech_manager/models/estimate_listiening_model.dart';
import 'package:mech_manager/models/invoice_listening_model.dart';
import 'package:mech_manager/models/job_sheet.dart';
import 'package:mech_manager/models/labour_listeningmodel.dart';
import 'package:mech_manager/models/mechanic_listeningmodel.dart';
import 'package:mech_manager/models/spare_part_model.dart';
import 'package:mech_manager/models/stock_listening_model.dart';

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
  customerSuccess,
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
  List<CustomerListingModel> customerListing;
  List<CustomerInfoJobCardListModel> customerInfoJobcardlisting;
  List<CustomerInfoEstimateListModel> customerInfoestimatelisting;
  List<CustomerInfoInvoiceListModel> customerInfoinvoicelisting;
  List<StockListeningModel> stocklisting;
  //ProductModel

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
    this.dashboardModel = DashboardModel.empty,
    this.estimateListing = const [],
    this.invoiceListing = const [],
    this.sparePartListing = const [],
    this.mechanicListing = const [],
    this.labourListing = const [],
    this.customerListing = const [],
    this.customerInfoJobcardlisting = const [],
    this.customerInfoestimatelisting = const [],
    this.customerInfoinvoicelisting = const [],
     this.stocklisting = const [],
    this.lastTimestamp,
    this.currentEstimateId = 0,
    this.currentInvoiceId = 0,
    this.page = 1,
    this.hasReachedMax = false,
    this.loadShow = false,
    this.totalPages = 1,
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
        customerListing,
        customerInfoJobcardlisting,
        customerInfoestimatelisting,
        customerInfoinvoicelisting,
        page!,
        hasReachedMax!,
        loadShow!,
        totalPages!,
        estimateListing,
        currentEstimateId!,
        currentInvoiceId!,
        stocklisting,
      ];

  JobSheetState copyWith(
      {jobSheetStatus? status,
      List<JobSheetModel>? jobSheetList,
      DashboardModel? dashboardModel,
      int? lastTimestamp,
      List<EstimateListingModel>? estimateListing,
      int? currentEstimateId,
      List<LabourModelListingModel>? labourListing,
      List<CustomerListingModel>? customerListing,
      List<CustomerInfoJobCardListModel>? customerInfoJobcardlisting,
      List<CustomerInfoEstimateListModel>? customerInfoestimatelisting,
      List<CustomerInfoInvoiceListModel>? customerInfoinvoicelisting,
      List<InvoiceListingModel>? invoiceListing,
      List<SparePartModel>? sparePartListing,
      List<MechanicListingModel>? mechanicListing,
      List<StockListeningModel>? stocklisting,
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
        sparePartListing: sparePartListing ?? this.sparePartListing,
        mechanicListing: mechanicListing ?? this.mechanicListing,
        labourListing: labourListing ?? this.labourListing,
        customerListing: customerListing ?? this.customerListing,
        customerInfoJobcardlisting:
            customerInfoJobcardlisting ?? this.customerInfoJobcardlisting,
        customerInfoestimatelisting:
            customerInfoestimatelisting ?? this.customerInfoestimatelisting,
        customerInfoinvoicelisting:
            customerInfoinvoicelisting ?? this.customerInfoinvoicelisting,
            stocklisting: stocklisting?? this.stocklisting,
        lastTimestamp: lastTimestamp ?? this.lastTimestamp,
        currentInvoiceId: currentInvoiceId ?? this.currentInvoiceId,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        loadShow: loadShow ?? this.loadShow,
        totalPages: totalPages ?? this.totalPages);
  }
}
