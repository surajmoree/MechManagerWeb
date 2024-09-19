
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class JobSheetDetailsEvent extends Equatable {
  const JobSheetDetailsEvent();
  @override
  List<Object> get props => [];
}

class GetJobSheetDetails extends JobSheetDetailsEvent {
  final String id;

  const GetJobSheetDetails({required this.id});
}

class GetJobSheetImages extends JobSheetDetailsEvent {
  final String id;

  const GetJobSheetImages({required this.id});
}

class UpdateJobSheet extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  final String id;
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

  const UpdateJobSheet({
    this.formData,
    required this.id,
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


class UpdateJobSheetStatus extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  final String id;
  const UpdateJobSheetStatus({
    this.formData,
    required this.id,
  });
}

class UpdateCustomerComplaints extends JobSheetDetailsEvent {
  final List formData;
  final String id;
  const UpdateCustomerComplaints({required this.formData, required this.id});
}


class GetEstimateDetailsByEstimate extends JobSheetDetailsEvent {
  final String id;
  const GetEstimateDetailsByEstimate({
    required this.id,
  });
}

class ResetLastEstimateId extends JobSheetDetailsEvent {}
