import 'package:dart_obfuscator/common/enum/log_level_enum.dart';
import 'package:dart_obfuscator/common/global_function/global_function.dart';
import 'package:dart_obfuscator/functions/file/check_import_of_file_delete.dart';
import 'package:dart_obfuscator/main.dart';
import 'package:dart_obfuscator/common/model/models.dart';
import 'package:path/path.dart';

void updateImportsInNonObfuscatedFiles(Structure structure, String outputFileName) {
  structure.rawFiles.forEach((file) {
    final lines = file.readAsLinesSync();

    final outputFileImport = "import 'package:$packageName/$outputFileName';";
    var updatedLines =
    lines.where((element) => !isLineImport(element) || !isImportOfFileToBeDeleted(element, structure.filesToObfuscate)).toList();
    if (updatedLines.length < lines.length) {
      updatedLines = ["$outputFileImport"] + updatedLines;
    }

    var outputFilePath = basename(file.path);
    if (logLevel == LogLevel.VERBOSE) print("Update ${lines.length - updatedLines.length} imports for file: ${outputFilePath}");
    file.writeAsStringSync(updatedLines.reduce((value, element) => "$value\n$element"));
  });
}