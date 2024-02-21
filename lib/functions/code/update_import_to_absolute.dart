import 'package:dart_obfuscator/common/global_function/global_function.dart';
import 'package:dart_obfuscator/main.dart';
import 'package:path/path.dart';

String updateImportToAbsoluteIfNeeded(String line, String sourceFilePath) {
  if (isLineRelativeImport(line)) {
    final relativePath = sourceFilePath.replaceAll(basename(sourceFilePath), "").split("/lib/").last;
    final newLine = line.replaceAll("import '", "import 'package:$packageName/$relativePath");
    // print("Replace relative $line\nto: $newLine");
    return newLine;
  } else {
    return line;
  }
}