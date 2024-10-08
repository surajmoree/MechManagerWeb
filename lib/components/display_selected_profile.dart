import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/config/app_icons.dart';
import 'package:mech_manager/config/colors.dart';

class DisplaySelectedProfile extends StatelessWidget {
  final XFile imageFile;
  final String existedImageUrl;
  const DisplaySelectedProfile(
      {super.key, required this.imageFile, this.existedImageUrl = ""});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 46,
     
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(46),
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
        ),
      ),
    );
  }
}