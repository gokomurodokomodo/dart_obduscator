import 'dart:io';

typedef Modification = String Function(String line);

bool updateFileLineByLine(File file, Modification modification) {
  final lines = file.readAsLinesSync();

  List<String> updatedLines = [];
  lines.forEach((theLine) {
    var modifiedLine = modification(theLine);
    updatedLines.add(modifiedLine);
  });

  file.writeAsStringSync(updatedLines.reduce((value, element) => "$value\n$element"));
  return updatedLines.length < lines.length;
}