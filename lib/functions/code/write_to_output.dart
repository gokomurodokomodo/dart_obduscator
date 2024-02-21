import 'package:dart_obfuscator/main.dart';

void writeToOutput(String text) {
  if (obfuscatedOutputFile.existsSync()) obfuscatedOutputFile.deleteSync();
  obfuscatedOutputFile.createSync();
  obfuscatedOutputFile.writeAsStringSync(text);
}