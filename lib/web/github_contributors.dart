import 'dart:convert';
import 'package:http/http.dart' as http;

class ContributorsList {
  List<Contributor> contributors = new List<Contributor>();

  Future fillAsync(String requestUrl) async 
  {
    Future request = http.get(requestUrl);
    await request
    .then((response) { 
      List<dynamic> jsonTree = json.decode(response.body);

      for (int i = 0; i < jsonTree.length; i++) {
        contributors.add(new Contributor.fillFromJson(jsonTree[i]));
      }

      contributors = Contributor.sortContributors(contributors);
    });
  }
}

class Contributor
{
  String nickname;

  String profileUrl;
  String avatarUrl;

  int commits;
  int additions;
  int deletions;

  Contributor.fillFromJson(Map<dynamic, dynamic> e)
  {
    nickname = e['author']['login'];
    profileUrl = e['author']['html_url'];
    avatarUrl = e['author']['avatar_url'];

    commits = e['total'];
    additions = 0;
    deletions = 0;
    for (int i = 0; i < e['weeks'].length; i++) {
      additions += e['weeks'][i]['a'];
      deletions += e['weeks'][i]['d'];
    }
  }

  static List<Contributor> sortContributors(List<Contributor> e)
  {
    e.sort((a, b) => b.commits.compareTo(a.commits));
    return e;
  }

  static Future<List<Contributor>> getListAsync(String requestUrl) async 
  {
    Future request = http.get(requestUrl);
    await request
    .then((response) { 
      List<dynamic> jsonTree = json.decode(response.body);
      var list = new List<Contributor>();
      
      for (int i = 0; i < jsonTree.length; i++) {
        list.add(new Contributor.fillFromJson(jsonTree[i]));
      }

      return Contributor.sortContributors(list);
    })
    .catchError((e) {
      return null;
    });

  }
}