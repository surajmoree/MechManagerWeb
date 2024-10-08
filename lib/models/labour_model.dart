import 'package:equatable/equatable.dart';
/*
class LabourModel extends Equatable {
  final int? id;
  final String? createdAt;
  final String? deletedAt;
  final String? labourName;
  final int? labourRate;
  final String? taskDescription;

  final String? updatedAt;

 const LabourModel(
      {this.id,
      this.createdAt,
      this.deletedAt,
      this.labourName,
      this.labourRate,
      this.taskDescription,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        createdAt!,
        deletedAt!,
        labourName!,
        labourRate!,
        taskDescription!,
        updatedAt!
      ];

  LabourModel copyWith({
    int? id,
    String? createdAt,
    String? deletedAt,
    String? labourName,
    int? labourRate,
    String? taskDescription,
    String? updatedAt,
  }) {
    LabourModel labourModel = LabourModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        labourName: labourName ?? this.labourName,
        labourRate: labourRate ?? this.labourRate,
        taskDescription: taskDescription ?? this.taskDescription,
        updatedAt: updatedAt ?? this.updatedAt);
    return labourModel;
  }

  factory LabourModel.fromJson(Map<String, dynamic> json) {
    return LabourModel(
        id: json['id'] ?? 0,
        createdAt: json['created_at'] ?? '',
        deletedAt: json['deleted_at'] ?? '',
        labourName: json['labour_name'] ?? '',
        labourRate: json['labour_rate'] ?? 0,
        taskDescription: json['task_description'] ?? '',
        updatedAt: json['updated_at'] ?? '');
  }

  static const empty = LabourModel
  (
    id: 0,
    createdAt: "",
    deletedAt: "",
    labourName: "",
    labourRate: 0,
    taskDescription: "",
    updatedAt: ""
  );
}
*/

class LabourModel extends Equatable {
  final int? id;
  final String? createdAt;
  final String? deletedAt;
  final String? labourName;
  final int? labourRate;
  final String? taskDescription;
  final String? updatedAt;

  const LabourModel(
      {this.id,
      this.createdAt,
      this.deletedAt,
      this.labourName,
      this.labourRate,
      this.taskDescription,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        createdAt!,
        deletedAt!,
        labourName!,
        labourRate!,
        taskDescription!,
        updatedAt!,
      ];

  LabourModel copyWith({
    int? id,
    String? createdAt,
    String? deletedAt,
    String? labourName,
    int? labourRate,
    String? taskDescription,
    String? updatedAt,
  }) {
    LabourModel lebalModel = LabourModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      labourName: labourName ?? this.labourName,
      labourRate: labourRate ?? this.labourRate,
      taskDescription: taskDescription ?? this.taskDescription,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return lebalModel;
  }

  factory LabourModel.fromJson(Map<String, dynamic> json) {
    return LabourModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      labourName: json['labour_name'] ?? "",
      labourRate: json['labour_rate'] ?? 0,
      taskDescription: json['task_description'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  static const empty = LabourModel(
      id: 0,
      createdAt: "",
      deletedAt: "",
      labourName: "",
      labourRate: 0,
      taskDescription: "",
      updatedAt: "");
}
