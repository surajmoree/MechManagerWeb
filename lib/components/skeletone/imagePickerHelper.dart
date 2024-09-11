import 'dart:io' show File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  // Pick image from gallery or camera
  static Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  // Convert XFile to File on non-web platforms
  static Future<File?> getFileFromXFile(XFile xfile) async {
    if (!kIsWeb) {
      return File(xfile.path); // Only convert on non-web platforms
    }
    return null; // On web, you should use XFile directly.
  }
}
