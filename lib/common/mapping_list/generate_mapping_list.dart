List<String> generateMappingsList() {
  final List<String> mappingSymbols = [];
  final List<String> alphabet = [];
  var letterCode = 'A'.codeUnitAt(0);
  for (var i = 0; i < (26 * 2); i++) {
    if (i == 26) {
      letterCode += 6; //skip symbols in between Upper case letters and lower case letters
    }
    alphabet.add(String.fromCharCode(letterCode++));
    // print("$i ${String.fromCharCode(letter++)} ");
  }

  alphabet.forEach((letterOne) {
    alphabet.forEach((letterTwo) {
      // print("$letterOne$letterTwo");
      mappingSymbols.add("$letterOne$letterTwo");
    });
  });

  // print("And we have ${mappingSymbols.length} mappings");
  return mappingSymbols;
}