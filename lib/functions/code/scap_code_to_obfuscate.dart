import 'dart:io';
import 'package:dart_obfuscator/common/global_function/global_function.dart';
import 'package:dart_obfuscator/functions/code/update_import_to_absolute.dart';
import 'package:dart_obfuscator/functions/file/check_import_of_file_delete.dart';

String scrapCodeToObfuscate(List<File> filesToObfuscate, Directory libDir, String outputFileName) {
  final allImports = Set<String>();
  final List<String> nonImportLines = [];
  filesToObfuscate.forEach((theFile) {
    theFile.readAsLinesSync().forEach((line) {
      if (isLineImport(line)) {
        var absoluteImport = updateImportToAbsoluteIfNeeded(line, theFile.path);
        if (!isImportOfFileToBeDeleted(absoluteImport, filesToObfuscate)) {
          allImports.add(absoluteImport);
        }
      } else if (!isLinePart(line) && !isLineComment(line)) {
        nonImportLines.add(line);
      }
    });
  });

  final allLines = (allImports.toList() + nonImportLines).reduce((value, element) => value + "$element\n");
  return allLines;
}