part of 'providers.dart';

//final RxList<Remind> remindList = List<Remind>.empty().obs;
var remindList = <Remind>[];

Future<int> addRemind({Remind? remind}) async {
  return await DbHelper.insert(remind);
}

// Future<void> addRemind({required Remind? remind}) async {
//   await DbHelper.insert(remind);
// }

void getReminder() async {
  List<Map<String, dynamic>> reminder = await DbHelper.query();
  remindList.clear();
  remindList.addAll(reminder.map((data) => Remind.fromJson(data)).toList());
}

void delete(Remind remind) {
  DbHelper.delete(remind);
  getReminder();
}

void markRemindCompleted(int id) async {
  await DbHelper.update(id);
  getReminder();
}

class DbHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "Reminder";

  static Future<void> initDb() async {
    // Get a location using getDatabasesPath
    if (_db != null) {
      return;
    }

    try {
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'reminder.db');
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          print("Creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, dose TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print("Error opening DB $_db");
      print(e);
    }
  }

  static Future<int> insert(Remind? remind) async {
    print("insert function called");

    int id = DateTime.now().toString().hashCode;
    remind!.id = id;
    print("insert remind ${remind.toJson()}");
    return await _db?.insert(_tableName, remind.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Remind remind) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [remind.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE reminder
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }
}
