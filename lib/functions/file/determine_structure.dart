import 'dart:io';

import 'package:dart_obfuscator/common/enum/log_level_enum.dart';
import 'package:dart_obfuscator/functions/file/find_exported_file.dart';
import 'package:dart_obfuscator/functions/file/find_file_to_obfuscate.dart';
import 'package:dart_obfuscator/main.dart';
import 'package:dart_obfuscator/common/model/models.dart';

Structure determineStructure(Directory libDir, String sourceDirPath) {
  if (!libDir.existsSync()) {
    throw "Directory $sourceDirPath does not exists or does not contain /lib dir";
  }

  final rootFiles = libDir.listSync(recursive: false).where((element) => element is File).whereType<File>().toList();
  final exportedFiles = findExportedFiles(rootFiles);
  final List<File> rawFiles = rootFiles + exportedFiles;
  rawFiles.removeWhere((element) => element.path == "${libDir.path}/$outputFileName");

  if (logLevel == LogLevel.VERBOSE) print("Files to obfuscate");
  List<File> filesToObfuscate = findFilesToObfuscate(libDir, rawFiles);
  filesToObfuscate.forEach((element) {
    if (logLevel == LogLevel.VERBOSE) print("${element.path}");
  });
  return Structure(rawFiles, filesToObfuscate);
}