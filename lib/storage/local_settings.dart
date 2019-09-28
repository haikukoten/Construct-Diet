import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:convert';

class LocalSettings
{
  Future getContainer(String containerName) async
  {
    _path = await _appPath + '/settings/public/' + containerName + '.json';
    if (await io.File(_path).exists())
    {
      _isVirtual = false;
      
      _fileJson = json.decode(await getOrigin());
    }
    else
    {
      _isVirtual = true;
    }
  }

  bool _isVirtual = true;
  bool get isVirtual => _isVirtual;

  String _path;
  String get path => _path;

  Map<String, dynamic> _fileJson;

  dynamic getItem(String name)
  {
    return _fileJson[name];
  }

  void addItem(String name, dynamic item)
  {
    _fileJson[name] = item;
    saveContainer();
  }

  Future saveContainer() async
  {
    await io.File(path).writeAsString(json.encode(_fileJson));
  }

  Future<String> getOrigin() async
  {
    return await io.File(path).readAsString();
  }

  Future<String> get _appPath async 
  {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}