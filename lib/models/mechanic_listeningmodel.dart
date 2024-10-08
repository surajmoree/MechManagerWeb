import 'package:equatable/equatable.dart';

class MechanicListingModel extends Equatable {
  final int? id;
  final String? createdAt;
  final String? deletedAt;
  final String? mechanicName;
  final String? mechanicRate;
  final String? taskDescription;
  final String? updatedAt;
  final int? timestamp;

  const MechanicListingModel(
      {this.id,
      this.createdAt,
      this.deletedAt,
      this.mechanicName,
      this.mechanicRate,
      this.taskDescription,
      this.updatedAt,
      this.timestamp});

  @override
  List<Object> get props => [
        id!,
        createdAt!,
        deletedAt!,
        mechanicName!,
        mechanicRate!,
        taskDescription!,
        updatedAt!,
        timestamp!
      ];

  MechanicListingModel copyWith(
      {int? id,
      String? createdAt,
      String? deletedAt,
      String? mechanicName,
      String? mechanicRate,
      String? taskDescription,
      String? updatedAt,
      int? timestamp}) {
    MechanicListingModel mechanicListingModel = MechanicListingModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        mechanicName: mechanicName ?? this.mechanicName,
        mechanicRate: mechanicRate ?? this.mechanicRate,
        taskDescription: taskDescription ?? this.taskDescription,
        updatedAt: updatedAt ?? this.updatedAt,
        timestamp: timestamp ?? this.timestamp);
    return mechanicListingModel;
  }

  factory MechanicListingModel.fromJson(Map<String, dynamic> json) {
    return MechanicListingModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      mechanicName: json['mechanic_name'] ?? "",
      mechanicRate: json['mechanic_rate'] ?? "",
      taskDescription: json['task_description'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      timestamp: int.parse(json['timestamp'].toString()),
    );
  }



  @override
  String toString() =>
      '{id: $id, createdAt: $createdAt, deletedAt: $deletedAt, labourName: $mechanicName, labourRate: $mechanicRate, taskDescription: $taskDescription, updatedAt: $updatedAt}';
}
