import 'dart:io';

void deleteEmptyDirectories(Directory libDir) {
  libDir.listSync(recursive: true).whereType<Directory>().where((element) => element.listSync(recursive: true).isEmpty).forEach((emptyDir) {
    emptyDir.deleteSync();
  });
}