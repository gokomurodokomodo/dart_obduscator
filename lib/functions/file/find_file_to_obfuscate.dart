import 'dart:io';

List<File> findFilesToObfuscate(Directory libDir, List<FileSystemEntity> rawFiles) => libDir
    .listSync(recursive: true)
    .whereType<File>()
    .where((element) => element.path.split(".").last == "dart")
    .where((element) => !rawFiles.map((e) => e.path).contains(element.path))
    .toList();