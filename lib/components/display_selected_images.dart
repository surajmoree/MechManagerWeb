

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';

class DisplaySelectedImage extends StatelessWidget {
  final XFile imageFile;
  final String existedImageUrl;
  const DisplaySelectedImage(
      {super.key, required this.imageFile, this.existedImageUrl = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.8, color: borderColor)),
      child: (imageFile.path != "")
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageFile.path,
                height: 50,
                width: 50,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            )
          : (existedImageUrl.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: existedImageUrl,
                    height: 50,
                    width: 50,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return const Icon(imageNotSupport,
                          size: 68, color: hintTextColor);
                    },
                  ),
                )
              : const Icon(carIcon,size: 50,  color: hintTextColor,),
    );
  }
}