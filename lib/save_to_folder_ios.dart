import 'dart:io';
import 'package:flutter/services.dart';

class SaveToFolderIos {
  static const MethodChannel _channel = MethodChannel('SaveToFolder');

  static Future<bool> copy(String path) async {
    bool exist = File(path).existsSync();
    if (!exist) throw Exception("\n\nFile does not exist at path! path:\n\n$path");
    try {
      final result = await _channel.invokeMethod<bool>('copy', {'path': path});
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to copy file: $e');
      return false;
    }
  }
}
