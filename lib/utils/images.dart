import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<String?> urlToFile(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final String fileName = imageUrl.split("/").last;
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = tempDir.path;
        final File imageFile = File('$tempPath/$fileName');
        await imageFile.writeAsBytes(bytes);
        return imageFile.path;
      } else {
        //TODO: Handle error
        return null;
      }
    } catch (e) {
      //TODO: Handle network errors
      return null;
    }
  }

  static Future<String?> assetToFile(String assetPath) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      final String fileName = assetPath.split("/").last;
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final File imageFile = File('$tempPath/$fileName');
      await imageFile.writeAsBytes(bytes);
      return imageFile.path;
    } catch (e) {
      //TODO:Handle errors
      return null;
    }
  }
}
