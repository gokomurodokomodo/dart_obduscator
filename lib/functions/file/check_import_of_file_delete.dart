import 'dart:io';

bool isImportOfFileToBeDeleted(String absoluteImport, List<File> filesToObfuscate) {
  final knownPaths = filesToObfuscate.map((e) => e.path.split('/lib/').last);
  final strippedImport = absoluteImport.replaceAll(RegExp("^(.*?)/"), '').split("'").first;
  return knownPaths.contains(strippedImport);
}