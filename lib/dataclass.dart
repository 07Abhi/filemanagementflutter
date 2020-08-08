import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReadAndWrite {
  Future<String> get localpath async {
    var dirPath = await getTemporaryDirectory();
    return dirPath.path;
  }

  Future<File> get filedata async {
    var filepath = await localpath;
    return File('$filepath/db.txt');
  }

  Future<String> readData() async {
    try {
      File file = await filedata;
      return file.readAsString();
    } catch (e) {
      return e.toString();
    }
  }

  Future writeData(String data) async {
    File file = await filedata;
    file.writeAsString(data);
  }
}
