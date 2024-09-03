import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config.dart';
import 'package:mech_manager/models/job_card_details_model.dart';
import 'package:mech_manager/models/slider_image_model.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_state.dart';

class JobSheetDetailsBloc extends Bloc<JobSheetDetailsEvent,JobSheetDetailsState>
{ 
  JobSheetDetailsBloc() : super(JobSheetDetailsState())
  {
    on<GetJobSheetDetails>(_onGetJobSheetDetails);
    on<GetJobSheetImages>(_onGetJobSheetImages);
  }
 


  Future<void> _onGetJobSheetDetails(GetJobSheetDetails event, Emitter<JobSheetDetailsState>emit)async
  {
    emit(state.copyWith(status:JobSheetDetailsStatus.loading));

    dynamic token = await storage.read(key: 'token');

    Map<String,Object> jsonData ={
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final jobSheetDetails = await jobSheetRepository.getJobSheetDetails(jsonData);
    add(GetJobSheetImages(id: event.id.toString()));

    if(jobSheetDetails != null && jobSheetDetails.isNotEmpty)
    {
      emit(state.copyWith(status: JobSheetDetailsStatus.success,jobSheetDetails: JobSheetDetailModel.fromJson(jobSheetDetails)));
    }else {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.failed,
          jobSheetDetails: JobSheetDetailModel.empty,
        ),
      );
    }
  }

  _onGetJobSheetImages(GetJobSheetImages event,Emitter<JobSheetDetailsState>emit)async
  {
    dynamic token = await storage.read(key: 'token');

    Map<String,Object> jsonData ={
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final jobSheetImages = await jobSheetRepository.getJobSheetImages(jsonData);
    if(jobSheetImages != null && jobSheetImages.isNotEmpty)
    {
      emit(state.copyWith(status: JobSheetDetailsStatus.success,imageSliderModel: ImageSliderModel.fromJson(jobSheetImages)));
    }

  }



}