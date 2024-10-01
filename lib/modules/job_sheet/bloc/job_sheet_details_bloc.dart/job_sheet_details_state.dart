import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/estimate_model.dart';
import 'package:mech_manager/models/invoice_model.dart';
import 'package:mech_manager/models/job_card_details_model.dart';
import 'package:mech_manager/models/labour_model.dart';
import 'package:mech_manager/models/mechanic_model.dart';
import 'package:mech_manager/models/product_model.dart';
import 'package:mech_manager/models/profile_model.dart';
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
 MechanicModel? mechanicModel;
 LabourModel? labourModel;
  UpdateProfileModel? profilModel;


 

  JobSheetDetailsState({
    this.status = JobSheetDetailsStatus.initial,
    this.jobSheetDetails = JobSheetDetailModel.empty,
    this.labourModel = LabourModel.empty,
    this.imageSliderModel = ImageSliderModel.empty,
     this.estimateModel = EstimateModel.empty,
     this.profilModel = UpdateProfileModel.empty,
     this.sparePartList = const [],
      this.productList = const [],
      this.invoiceModel = InvoiceModel.empty,
     this.mechanicModel = MechanicModel.empty,
  
  });

  @override
  List<Object> get props => [
        status!,
        jobSheetDetails!,
        imageSliderModel!,
        estimateModel!,
        labourModel!,
        sparePartList!,
         productList!,
         invoiceModel!,
         mechanicModel!,
        profilModel!
      ];

  JobSheetDetailsState copyWith({
    JobSheetDetailsStatus? status,
    JobSheetDetailModel? jobSheetDetails,
    ImageSliderModel? imageSliderModel,
    EstimateModel? estimateModel,
    List<SparePartModel>? sparePartList,
     List<ProductModel>? productList,
     InvoiceModel? invoiceModel,
    MechanicModel? mechanicModel,
    LabourModel? labourModel,
    UpdateProfileModel? profilModel,
    
  }) {
    return JobSheetDetailsState(
        status: status ?? this.status,
        jobSheetDetails: jobSheetDetails ?? this.jobSheetDetails,
        imageSliderModel: imageSliderModel?? this.imageSliderModel,
        estimateModel: estimateModel ?? this.estimateModel,
        sparePartList: sparePartList ?? this.sparePartList,
        productList: productList ?? this.productList,
        invoiceModel: invoiceModel ?? this.invoiceModel,
        mechanicModel: mechanicModel?? this.mechanicModel,
        labourModel: labourModel?? this.labourModel,
        profilModel: profilModel?? this.profilModel
    );
  }
}
