import 'dart:io';

void deleteScrappedSourceFiles(List<File> filesToObfuscate) {
  filesToObfuscate.forEach((element) {
    if (element.existsSync()) {
      element.deleteSync();
    }
  });
}