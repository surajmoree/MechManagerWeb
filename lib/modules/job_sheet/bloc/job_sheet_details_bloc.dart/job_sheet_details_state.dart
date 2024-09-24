import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/estimate_model.dart';
import 'package:mech_manager/models/invoice_model.dart';
import 'package:mech_manager/models/job_card_details_model.dart';
import 'package:mech_manager/models/product_model.dart';
import 'package:mech_manager/models/slider_image_model.dart';
import 'package:mech_manager/models/spare_part_model.dart';

enum JobSheetDetailsStatus {
  initial,
  loading,
  success,
  failed,
  updating,
  updated,
  jobcardUpdated,
  estimateUpdated,
  sending,
  estimatePdfOpened,
  invoicePdfOpened,
  estimatePdfLoaded,
  invoicePdfLoaded,
  loaded,
  failure,
  invoiceUpdated,
  updatedServicingDate
}

class JobSheetDetailsState extends Equatable {
  JobSheetDetailsStatus? status;
  JobSheetDetailModel? jobSheetDetails;
  ImageSliderModel? imageSliderModel;
  EstimateModel? estimateModel;
  List<SparePartModel>? sparePartList;
  List<ProductModel>? productList;
  InvoiceModel? invoiceModel;
 

  JobSheetDetailsState({
    this.status = JobSheetDetailsStatus.initial,
    this.jobSheetDetails = JobSheetDetailModel.empty,
    this.imageSliderModel = ImageSliderModel.empty,
     this.estimateModel = EstimateModel.empty,
     this.sparePartList = const [],
      this.productList = const [],
      this.invoiceModel = InvoiceModel.empty,
  
  });

  @override
  List<Object> get props => [
        status!,
        jobSheetDetails!,
        imageSliderModel!,
        estimateModel!,
        sparePartList!,
         productList!,
         invoiceModel!,
        
      ];

  JobSheetDetailsState copyWith({
    JobSheetDetailsStatus? status,
    JobSheetDetailModel? jobSheetDetails,
    ImageSliderModel? imageSliderModel,
    EstimateModel? estimateModel,
    List<SparePartModel>? sparePartList,
     List<ProductModel>? productList,
     InvoiceModel? invoiceModel,
    
  }) {
    return JobSheetDetailsState(
        status: status ?? this.status,
        jobSheetDetails: jobSheetDetails ?? this.jobSheetDetails,
        imageSliderModel: imageSliderModel?? this.imageSliderModel,
        estimateModel: estimateModel ?? this.estimateModel,
        sparePartList: sparePartList ?? this.sparePartList,
        productList: productList ?? this.productList,
        invoiceModel: invoiceModel ?? this.invoiceModel,
    );
  }
}
