import 'dart:convert';
import 'package:http/http.dart' as http;

// Interfaces
class IUsersManadger
{
  bool isFill;                         /* Заполнен ли класс? */
  List<User> users;                    /* Список пользователей */

  int getAllTimeCommits() {}           /* Получает количество коммитов за все время в репозитории */
  int getAllTimeAdditions() {}         /* Получает количество добавлений за все время в репозитории */
  int getAllTimeDeletions() {}         /* Получает количество удалений за все время в репозитории */
}

class IUser
{
  List<WeekUserCommits> weeksCommits;  /* Список WeekUserCommits за все время существования репозитория */
  UserData userInfo;                   /* Информация о пользователе */

  int getAllTimeCommits() {}           /* Получает количество коммитов за все время пользователем */
  int getAllTimeAdditions() {}         /* Получает количество добавлений за все время пользователем */
  int getAllTimeDeletions() {}         /* Получает количество удалений за все время пользователем */

  WeekUserCommits getLastWeek() {}     /* Получает WeekUserCommits класс за последнюю неделю */
}

class IWeekUserCommits
{
  int week;                            /* Получает неделю в UNIX */
  int commits;                         /* Получает количество коммитов за неделю */
  int additions;                       /* Получает количество добавлений за неделю */
  int deletions;                       /* Получает количество удалений за неделю */
}

class IUserData
{
  String nickname;                     /* Получает имя пользователя */
  Uri avatarUri;                       /* Получает сылку на фото профиля пользователя */
  Uri profileUri;                      /* Получает ссылку на профильпользователя */
}

// Classes
class UsersManadger implements IUsersManadger
{
  bool isFill = false;
  List<User> users = new List<User>();

  Future fillAsync(Uri request) async
  {
    isFill = false;
    Future e = http.get(request); /* get request */

    await e.then((response) { /* fill tree from request */
      List<dynamic> lusers = json.decode(response.body);
      users = lusers.map((model) => User.fillFromJson(model)).toList();
      
      _sortingUsers();

      isFill = true;
    }).catchError( (err) { /* catch error */
      isFill = false;
    });
  }

  void _sortingUsers() /* From max commits set*/
  {
    users.sort( (a, b) => b.getAllTimeCommits().compareTo(a.getAllTimeCommits()));
  }

  int getAllTimeCommits()
  {
    if (isFill) {
      int total = 0;

      for (int i = 0; i < users.length; i++) {
        total += users[i].getAllTimeCommits();
      }

      return total;
    }
    return null;
  }

  int getAllTimeAdditions()
  {
    if (isFill) {
      int total = 0;

      for (int i = 0; i < users.length; i++) {
        total += users[i].getAllTimeAdditions();
      }

      return total;
    }
    return null;
  }

  int getAllTimeDeletions()
  {
    if (isFill) {
      int total = 0;

      for (int i = 0; i < users.length; i++) {
        total += users[i].getAllTimeDeletions();
      }

      return total;
    }
    return null;
  }
}

// !Lib classes
class User implements IUser
{
  int _allTimeCommits;
  List<WeekUserCommits> weeksCommits = new List<WeekUserCommits>();
  UserData userInfo;

  User.fillFromJson(Map e)
  {
    _allTimeCommits = e['total'];

    userInfo = new UserData.fillFromJson(e['author']);
    
    List<dynamic> weeks = e['weeks'];
    weeksCommits = weeks.map( (model) => WeekUserCommits.fillFromJson(model) ).toList();

    _sortingWeeks();
  }

  void _sortingWeeks() /* for reinsurance */
  {
    weeksCommits.sort( (a, b) => b.week.compareTo(a.week) );
  }

  WeekUserCommits getLastWeek()
  {
    return weeksCommits[0];
  }

  int getAllTimeCommits()
  {
    return  _allTimeCommits;
  }

  int getAllTimeAdditions()
  {
    if (weeksCommits.length > 0) {
      int allTimeAdditions = 0;
      for (int i = 0; i < weeksCommits.length; i++) {
        allTimeAdditions += weeksCommits[i].additions;
      }
      
      return allTimeAdditions;
    }
    return null;
  }

  int getAllTimeDeletions()
  {
    if (weeksCommits.length > 0) {
      int allTimeDeletions = 0;
      for (int i = 0; i < weeksCommits.length; i++) {
        allTimeDeletions += weeksCommits[i].deletions;
      }

      return allTimeDeletions;
    }
    return null;
  }
}

class WeekUserCommits implements IWeekUserCommits
{
  int week;
  int commits;
  int additions;
  int deletions;

  WeekUserCommits.fillFromJson(Map e)
  {
    week = e['w']; /* TODO: Custom unix date converter. */  /* Don't use DateTime */
    commits = e['c'];
    additions = e['a'];
    deletions = e['d'];
  }
}

class UserData  implements IUserData
{
  String nickname;
  Uri avatarUri;
  Uri profileUri;

  UserData.fillFromJson(Map e)
  {
    nickname = e['login'];
    avatarUri = Uri.parse( e['avatar_url'] );
    profileUri = Uri.parse( e['url'] );
  }
}