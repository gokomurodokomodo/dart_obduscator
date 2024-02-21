import 'dart:io';

import 'package:dart_obfuscator/common/enum/log_level_enum.dart';
import 'package:dart_obfuscator/functions/file/check_export.dart';
import 'package:dart_obfuscator/main.dart';

List<File> findExportedFiles(List<FileSystemEntity> rootFiles) {
  List<File> allExportedFiles = [];

  if (logLevel == LogLevel.VERBOSE) print("Root files found:");
  rootFiles.forEach((element) {
    if (logLevel == LogLevel.VERBOSE) print("${element.path}");
    if (logLevel == LogLevel.VERBOSE) print("Export files declared in this root:");
    final exportFiles = checkExports(element as File);
    if (logLevel == LogLevel.VERBOSE) {
      exportFiles.forEach((element) {
        print("${element.path}");
      });
    }
    allExportedFiles.addAll(exportFiles);
  });

  return allExportedFiles;
}