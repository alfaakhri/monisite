import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../color_helpers.dart';
import '../ui_helpers.dart';

class ImagePickerService {
  File imageFile;
  var resultList;
  ImagePickerService({this.imageFile, this.resultList});

  _openGalleryEditProfil(BuildContext context) async {
    final picker = ImagePicker();

    var picture = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(picture.path);
    if (imageFile != null) {
      imageFile = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
      ;
    }

    Navigator.of(context).pop(imageFile);
  }

  _openCameraEditProfil(BuildContext context) async {
    final picker = ImagePicker();

    var picture = await picker.getImage(source: ImageSource.camera);
    imageFile = File(picture.path);
    if (imageFile != null) {
      imageFile = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    }

    Navigator.of(context).pop(imageFile);
  }

  Future dialogImageEditProfil(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              height: MediaQuery.of(context).size.height / 2.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  UIHelper.verticalSpaceMedium,
                  Text(
                    'Pengambilan Foto Profil',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  UIHelper.verticalSpaceMedium,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Silahkan anda pilih apakah menggunakan Galeri atau Kamera',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorHelpers.colorGreyTextLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  UIHelper.verticalSpaceMedium,
                  GestureDetector(
                    onTap: () {
                      _openGalleryEditProfil(context);
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "GALERI",
                          style: TextStyle(
                              color: ColorHelpers.colorWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  UIHelper.verticalSpaceMedium,
                  GestureDetector(
                    onTap: () {
                      _openCameraEditProfil(context);
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorHelpers.colorGreyField,
                          border:
                              Border.all(color: ColorHelpers.colorGreyField),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "KAMERA",
                          style: TextStyle(
                              color: ColorHelpers.colorGreyTextField,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
