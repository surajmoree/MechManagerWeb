import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_manager/components/display_selected_profile.dart';
import 'package:mech_manager/components/skeletone/imagePickerHelper.dart';
import 'package:mech_manager/config/colors.dart';

class ProfileImage extends StatelessWidget {
  final Function takeImage;
  final XFile imageFile;
  final String existedImageUrl;
  const ProfileImage(
      {super.key,
      required this.takeImage,
      required this.imageFile,
      this.existedImageUrl = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 17,
        top: 30,
      ),
      child: Column(
        children: [
          DisplaySelectedProfile(
            imageFile: imageFile,
            existedImageUrl: existedImageUrl,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 37,
            width: 135,
            child: ElevatedButton(
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
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Select Image',
                style: TextStyle(
                  fontFamily: 'meck',
                  fontSize: 14,
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
