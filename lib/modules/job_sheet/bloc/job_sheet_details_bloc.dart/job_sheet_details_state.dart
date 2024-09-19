import 'package:equatable/equatable.dart';
import 'package:mech_manager/models/estimate_model.dart';
import 'package:mech_manager/models/job_card_details_model.dart';
import 'package:mech_manager/models/slider_image_model.dart';

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

  JobSheetDetailsState({
    this.status = JobSheetDetailsStatus.initial,
    this.jobSheetDetails = JobSheetDetailModel.empty,
    this.imageSliderModel = ImageSliderModel.empty,
     this.estimateModel = EstimateModel.empty,
  
  });

  @override
  List<Object> get props => [
        status!,
        jobSheetDetails!,
        imageSliderModel!,
        estimateModel!,
        
      ];

  JobSheetDetailsState copyWith({
    JobSheetDetailsStatus? status,
    JobSheetDetailModel? jobSheetDetails,
    ImageSliderModel? imageSliderModel,
    EstimateModel? estimateModel,
    
  }) {
    return JobSheetDetailsState(
        status: status ?? this.status,
        jobSheetDetails: jobSheetDetails ?? this.jobSheetDetails,
        imageSliderModel: imageSliderModel?? this.imageSliderModel,
        estimateModel: estimateModel ?? this.estimateModel,
    );
  }
}
