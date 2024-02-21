import 'dart:math';

String renameVariable(String codeToObfuscate, List<String> mappingSymbols, Map<String, String> resultingMapping) {
  final classNames = RegExp("(\w+)\s+(\w+)\s+=")
      .allMatches(codeToObfuscate)
      .map((match) => match.group(1))
      .toList();

  var updatedCode = codeToObfuscate;
  classNames.forEach((theClass) {
    final theMapping = mappingSymbols.removeAt(Random().nextInt(mappingSymbols.length));
    updatedCode = updatedCode.replaceAll(RegExp(theClass ?? ''), theMapping);
    resultingMapping[theClass ?? ''] = theMapping;
    print("Rename $theClass to $theMapping");
  });

  return updatedCode;
}