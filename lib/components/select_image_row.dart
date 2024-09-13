import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/components/display_selected_images.dart';
import 'package:mech_manager/components/select_image_title.dart';
import 'package:mech_manager/components/skeletone/imagePickerHelper.dart';
import 'package:mech_manager/config/colors.dart';

class SelectImageRow extends StatelessWidget {
  final Function takeImage;
  final XFile imageFile;
  final String title;
  final String existedImageUrl;
  const SelectImageRow(
      {super.key,
      required this.takeImage,
      required this.imageFile,
      required this.title,
      this.existedImageUrl = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectImageTitle(title: title),
            SizedBox(
              height: 3,
            ),
            ElevatedButton(
              onPressed: () async {
                takeImage(imageFile);
                if (!kIsWeb) {
                  File? file =
                      await ImagePickerHelper.getFileFromXFile(imageFile);
                  if (file != null) {
                    // Now you have a File to work with on non-web platforms
                    print('Selected File Path: ${file.path}');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: whiteColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.amber, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Select Image',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  color: Colors.amber,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        DisplaySelectedImage(
            imageFile: imageFile, existedImageUrl: existedImageUrl)
      ],
    );
  }
}
