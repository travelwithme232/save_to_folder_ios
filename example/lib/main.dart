import 'dart:io';
import 'package:flutter/material.dart';
import 'package:save_to_folder_ios/save_to_folder_ios.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const SaveToFolderIosExampleApp());
}

class SaveToFolderIosExampleApp extends StatelessWidget {
  const SaveToFolderIosExampleApp({super.key});

  Future<void> startButtonTap() async {
    String tmpdirPath = (await getTemporaryDirectory()).path;
    String filePath = '$tmpdirPath/test.txt';
    File(filePath).writeAsStringSync('asdf');
    bool result = await SaveToFolderIos.copy('$tmpdirPath/test.txt');
    print('@@file save result = $result');
  }

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: Center(child: FilledButton(onPressed: startButtonTap, child: Text('START'))));
}
