import 'package:equatable/equatable.dart';

class JobSheetDetailsEvent extends Equatable
{
 const JobSheetDetailsEvent();
  @override
  List<Object> get props => [];
  
}


class GetJobSheetDetails extends JobSheetDetailsEvent
{
  final String id;

 const GetJobSheetDetails({required this.id});
  
}

class GetJobSheetImages extends JobSheetDetailsEvent
{
  final String id;

 const GetJobSheetImages({required this.id});
  
}