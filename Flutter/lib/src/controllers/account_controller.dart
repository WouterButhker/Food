

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/src/communication/server_communication.dart';

class AccountController {

  static Future<File> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: source);
    return await _cropImage(pickedFile.path);
  }

  static Future<File> _cropImage(String path) async {
    return await ImageCropper.cropImage(
      sourcePath: path,
      cropStyle: CropStyle.circle,
      compressQuality: 80,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
  }

  static void uploadImage(File image) async {
    ServerCommunication.uploadProfilePicture(image);
  }


}