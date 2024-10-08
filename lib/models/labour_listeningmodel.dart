import 'package:equatable/equatable.dart';

class LabourModelListingModel extends Equatable {
  final int? id;
  final String? createdAt;
  final String? deletedAt;
  final String? labourName;
  final int? labourRate;
  final String? taskDescription;
  final int? timestamp;
  final String? updatedAt;

  LabourModelListingModel(
      {this.id,
      this.createdAt,
      this.deletedAt,
      this.labourName,
      this.labourRate,
      this.taskDescription,
      this.timestamp,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        createdAt!,
        deletedAt!,
        labourName!,
        labourRate!,
        taskDescription!,
        timestamp!,
        updatedAt!
      ];

  LabourModelListingModel copyWith({
    int? id,
    String? createdAt,
    String? deletedAt,
    String? labourName,
    int? labourRate,
    String? taskDescription,
    int? timestamp,
    String? updatedAt,
  }) {
    LabourModelListingModel labourlisteningModel = LabourModelListingModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        labourName: labourName ?? this.labourName,
        labourRate: labourRate ?? this.labourRate,
        taskDescription: taskDescription ?? this.taskDescription,
        timestamp: timestamp ?? this.timestamp,
        updatedAt: updatedAt ?? this.updatedAt);
        return labourlisteningModel;
  }


  factory LabourModelListingModel.fromJson(Map<String,dynamic> json)
  {
    return LabourModelListingModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at']?? '',
      deletedAt: json['deleted_at']?? '',
      labourName: json['labour_name']?? '',
      labourRate: json['labour_rate']?? 0,
      taskDescription: json['task_description']?? '',
      timestamp: int.parse(json['timestamp'].toString()),
      updatedAt: json['updated_at']?? ''

    );
  }



   @override
  String toString() =>
      '{ createdAt:$createdAt,deletedAt:$deletedAt,Id:$id, labourName:$labourName,labourRate:$labourRate,taskDescription:$taskDescription,timestamp:$timestamp, updatedAt:$updatedAt}';
}
