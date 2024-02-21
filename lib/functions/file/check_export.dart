import 'dart:io';

import 'package:dart_obfuscator/functions/code/clear_import_symbol.dart';

List<File> checkExports(File file) {
  final List<File> exportFiles = [];
  file.readAsLinesSync().forEach((line) {
    if (line.startsWith("export ")) {
      final relativePath = clearImportSymbols(line);
      final absolutePath = "${file.parent.path}/$relativePath";
      var exportFile = File(absolutePath);
      if (exportFile.existsSync()) {
        exportFiles.add(exportFile);
      } else {
        print(
            "[WARNING] Export file does not exist: $absolutePath\nPlease make sure your project is compiling before proceeding"); //todo shall I exit with error here?
      }
    }
  });

  return exportFiles;
}