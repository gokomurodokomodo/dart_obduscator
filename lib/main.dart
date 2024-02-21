import 'dart:io';
import 'package:dart_obfuscator/common/enum/log_level_enum.dart';
import 'package:dart_obfuscator/common/mapping_list/generate_mapping_list.dart';
import 'package:dart_obfuscator/functions/code/delete_scrapped_code.dart';
import 'package:dart_obfuscator/functions/code/scap_code_to_obfuscate.dart';
import 'package:dart_obfuscator/functions/code/update_import_in_non_obfuscate_file.dart';
import 'package:dart_obfuscator/functions/code/write_to_output.dart';
import 'package:dart_obfuscator/functions/file/delete_empty_directory.dart';
import 'package:dart_obfuscator/functions/file/determine_structure.dart';
import 'package:dart_obfuscator/functions/code/rename_class.dart';
import 'package:dart_obfuscator/functions/file/update_raw_file_with_obfuscate.dart';


//Improvements
//1. Inside every class variables and methods can have same names

//todo when moving class to output rename it to something path relative, so it does not clash with files with same name from other dirs, same for upper level constants and functions
// 3. rename methods (static and not)
// 4. rename variables (static and not)
// 5. store mapping

final logLevel = LogLevel.DEBUG;
// final logLevel = LogLevel.VERBOSE;
final obfuscationMap = Map<String, String>();
final packageName = 'fake_app_one';
final sourceDirPath = "E:\\superapp\\demo\\fake_app_one";
final outputFileName = "finn_obfuscated.dart";
final obfuscatedOutputFile = File("${libDir.path}/$outputFileName");
final libDir = Directory("$sourceDirPath/lib");


//todo delete empty directories
//todo delete not needed imports in output file
//todo update imports for non-obfuscated files (for every file that contains ref to deleted file replace it with output file import)
//todo import import 'package:finn_dart_sdk/src/services/../shared_prefs.dart'; is not deleted


void main(List<String> args) async {
  final programStartTime = DateTime.now().millisecondsSinceEpoch;

  // Preparation
  if (obfuscatedOutputFile.existsSync()) obfuscatedOutputFile.deleteSync();
  final structure = determineStructure(libDir, sourceDirPath);

  // Files processing
  final codeToObfuscate = scrapCodeToObfuscate(structure.filesToObfuscate, libDir, outputFileName);
  // deleteScrappedSourceFiles(structure.filesToObfuscate);
  deleteEmptyDirectories(libDir);

  // Obfuscation
  final resultingMapping = Map<String, String>();
  final mappingSymbols = generateMappingsList();
  final codeWithRenamedClasses = renameClasses(codeToObfuscate, mappingSymbols, resultingMapping);
  updateRawFilesWithObfuscatedClasses(structure.rawFiles, resultingMapping);
  writeToOutput(codeWithRenamedClasses);

  updateImportsInNonObfuscatedFiles(structure, outputFileName);
  //todo also update mappings


  print("________________");
  final executionTime = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - programStartTime);
  print("Obfuscation completed in ${executionTime.toIso8601String().split(':').last}");
  print("Result is written to $outputFileName");
}
