import 'package:equatable/equatable.dart';

class MechanicModel extends Equatable {
  final int? id;
  final String? createdAt;
  final String? deletedAt;
  final String? mechanicName;
  final String? mechanicRate;
  final String? taskDescription;
  final String? updatedAt;

  const MechanicModel({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.mechanicName,
    this.mechanicRate,
    this.taskDescription,
    this.updatedAt,
  });

  @override
  List<Object> get props => [
        id!,
        createdAt!,
        deletedAt!,
        mechanicName!,
        mechanicRate!,
        taskDescription!,
        updatedAt!,
      ];

  MechanicModel copyWith(
      {int? id,
      String? createdAt,
      String? deletedAt,
      String? mechanicName,
      String? mechanicRate,
      String? taskDescription,
      String? updatedAt}) {
    MechanicModel mechanicModel = MechanicModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      mechanicName: mechanicName ?? this.mechanicName,
      mechanicRate: mechanicRate ?? this.mechanicRate,
      taskDescription: taskDescription ?? this.taskDescription,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return mechanicModel;
  }

  factory MechanicModel.fromJson(Map<String, dynamic> json) {
    return MechanicModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      mechanicName: json['mechanic_name'] ?? "",
      mechanicRate: json['mechanic_rate'] ?? "",
      taskDescription: json['task_description'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  @override
  String toString() =>
      '{id: $id, createdAt: $createdAt, deletedAt: $deletedAt, labourName: $mechanicName, labourRate: $mechanicRate, taskDescription: $taskDescription, updatedAt: $updatedAt}';
}
