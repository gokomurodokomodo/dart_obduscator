import 'dart:io';

void updateRawFilesWithObfuscatedClasses(List<File> rawFiles, Map<String, String> resultingMapping) {
  rawFiles.forEach((theFile) {
    resultingMapping.forEach((String theClass, String theMapping) {
      final fileText = theFile.readAsStringSync();
      final updatedText = fileText.replaceAll(RegExp(theClass), theMapping);
      theFile.writeAsStringSync(updatedText);
    });
  });
}