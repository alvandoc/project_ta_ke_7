

import 'dart:io';

import 'package:flutter_luban/flutter_luban.dart';
import 'package:path_provider/path_provider.dart';

class CompressUtils {
  
  static Future<File> compressing(File fileImage) async {
    final tempDir = await getTemporaryDirectory();

    File _image;
    CompressObject compressObject = CompressObject(
      imageFile: fileImage, //image
      path: tempDir.path, //compress to path
      quality: 85,//first compress quality, default 80
      step: 8,//compress quality step, The bigger the fast, Smaller is more accurate, default 6
      //mode: CompressMode.LARGE2SMALL,//default AUTO
    );
    await Luban.compressImage(compressObject).then((_path) async {
      _image = File(_path);
    });

    return _image;
  }
}