import 'package:equatable/equatable.dart';

class ImageSliderModel extends Equatable {
  final String? images1;
  final String? images2;
  final String? images3;
  final String? images4;
  final String? vehicleDashboardImg;
  final String? vehicleDickeyImg;
  final String? vehicleFrontImg;
  final String? vehicleLeftImg;
  final String? vehicleRearImg;
  final String? vehicleRightImg;

  const ImageSliderModel(
      {this.images1,
      this.images2,
      this.images3,
      this.images4,
      this.vehicleDashboardImg,
      this.vehicleDickeyImg,
      this.vehicleFrontImg,
      this.vehicleLeftImg,
      this.vehicleRearImg,
      this.vehicleRightImg});

  @override
  List<Object> get props => [
        images1!,
        images2!,
        images3!,
        images4!,
        vehicleDashboardImg!,
        vehicleDickeyImg!,
        vehicleFrontImg!,
        vehicleLeftImg!,
        vehicleRearImg!,
        vehicleRightImg!
      ];

  ImageSliderModel copyWith(
      {String? images1,
      String? images2,
      String? images3,
      String? images4,
      String? vehicleDashboardImg,
      String? vehicleDickeyImg,
      String? vehicleFrontImg,
      String? vehicleLeftImg,
      String? vehicleRearImg,
      String? vehicleRightImg}) {
    ImageSliderModel imageSliderModel = ImageSliderModel(
        images1: images1 ?? this.images1,
        images2: images2 ?? this.images2,
        images3: images2 ?? this.images3,
        images4: images4 ?? this.images4,
        vehicleDashboardImg: vehicleDashboardImg ?? this.vehicleDashboardImg,
        vehicleDickeyImg: vehicleDickeyImg ?? this.vehicleDickeyImg,
        vehicleFrontImg: vehicleFrontImg ?? this.vehicleFrontImg,
        vehicleLeftImg: vehicleLeftImg ?? this.vehicleLeftImg,
        vehicleRearImg: vehicleRearImg ?? this.vehicleRearImg,
        vehicleRightImg: vehicleRightImg ?? this.vehicleRightImg);
    return imageSliderModel;
  }

  factory ImageSliderModel.fromJson(Map<String, dynamic> json) {
    return ImageSliderModel(
        images1: (json['images1']) ?? "",
        images2: json['images2'] ?? "",
        images3: json['images3'] ?? "",
        images4: json['images4'] ?? "",
        vehicleDashboardImg: json['vehicle_dashboard_img'] ?? "",
        vehicleDickeyImg: json['vehicle_dickey_img'] ?? "",
        vehicleFrontImg: json['vehicle_front_img'] ?? "",
        vehicleLeftImg: json['vehicle_left_hand_img'] ?? "",
        vehicleRearImg: json['vehicle_rear_img'] ?? "",
        vehicleRightImg: json['vehicle_right_hand_img'] ?? "");
  }

  static const empty = ImageSliderModel(
      images1: "",
      images2: "",
      images3: "",
      images4: "",
      vehicleDashboardImg: "",
      vehicleDickeyImg: "",
      vehicleFrontImg: "",
      vehicleLeftImg: "",
      vehicleRearImg: "",
      vehicleRightImg: "");
}