import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:convert';

class LocalSettings
{
  Future getContainer(String containerName) async
  {
    _path = await _appPath + '/settings/public';
    _name = containerName + '.json';
    if (await io.File(absolutePath).exists())
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

  String _name;
  String get name => _name;

  String get absolutePath => _path + '/' + name;

  Map<String, dynamic> _fileJson = {};

  dynamic getItem(String name)
  {
    return _fileJson[name];
  }

  void setItem(String name, dynamic item)
  {
    _fileJson.putIfAbsent(name, () => item);
  }

  Future saveContainer() async
  {
    if (!(await io.Directory(path).exists()))
    {
      await io.Directory(path).create(recursive: true);
    }

    if (!(await io.File(absolutePath).exists()))
    {
      await io.File(absolutePath).create(recursive: true);
    }

    await io.File(absolutePath).writeAsString(json.encode(_fileJson));

    _isVirtual = false;
  }

  Future<String> getOrigin() async
  {
    if (isVirtual)
    {
      return json.encode(_fileJson);
    }
    else
    {
      return await io.File(absolutePath).readAsString();
    }
  }

  Future<String> get _appPath async 
  {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}