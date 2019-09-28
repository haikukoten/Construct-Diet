import 'package:http/http.dart' as http;
import 'dart:convert';

enum RequestType
{
  GET,
  POST
}

/* USE EXAMPLE
final request = new HTTPRequest();
await request.getFromUri('https://api.onelab.work/cd/developers.json', RequestType.GET);

final list = request.getContentLikeList();

if (list != null) {
  print(list.length.toString());
  print(list[0]['nickname']);
}
*/
class HTTPRequest 
{
  String _content;
  String get content => _content;
  
  int _code;
  int get code => _code;

  Future getFromUri(String uri, RequestType type) async
  {
    switch(type)
    {
      case RequestType.GET:
        await _getRequest(uri);
        break;
      case RequestType.POST:
        await _postRequest(uri);
        break;
      default:
        throw Exception('Incorrect request type.');
        break;
    }
  }

  Future _getRequest(String uri) async
  {
    final response = await http.get(uri);

    _code = response.statusCode;

    if (response.statusCode == 200)
    {
      _content = response.body;
    }
  }

  Future _postRequest(String uri) async
  {
    final response = await http.post(uri);

    _code = response.statusCode;

    if (response.statusCode == 200)
    {
      _content = response.body;
    }
  }

  Map<dynamic, dynamic> getContentLikeMap()
  {
    try {
      Map<dynamic, dynamic> map = json.decode(content);
      return map;
    } 
    catch (e) 
    {
      return null;
    }
  }

  List<dynamic> getContentLikeList()
  {
    try {
      List<dynamic> map = json.decode(content);
      return map;
    } 
    catch (e)
    {
      return null;
    }
  }
}