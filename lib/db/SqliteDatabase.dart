import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:icddrb/model/members.dart';

class SqliteDatabase {
  final _dbName ="icddrb.db";
  final _tableName = "members";

  Future<Database> initDb() async{
    String path = await getDatabasesPath();
    String createTable = "CREATE TABLE $_tableName"
        "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "full_name TEXT NOT NULL,"
        "age INTEGER NOT NULL,"
        "date TEXT NOT NULL,"
        "time TEXT NOT  NULL,"
        "gender TEXT NOT NULL,"
        "education TEXT NOT NULL);";
    
    return openDatabase(join(path,_dbName),
      onCreate: (database,version) async{
        await database.execute(createTable);
      },
      version: 1,
    );
  }

  Future<int> insertRecord(Member member) async{
    final Database db = await initDb();
    print(member.toJson());
    //var result = await db.insert(_tableName, member.toJson());
    var result = await db.rawInsert(
      "INSERT INTO $_tableName (`full_name`, `age`, `date`, `time`, `gender`, `education`)"
          " VALUES ('${member.fullName}', '${member.age}',"
          "'${member.date}', '${member.time}', '${member.gender}', '${member.education}')"
    );

    print("SELECT * FROM members");
    return result;
  }


  Future<List<Member>> getRecord() async{
    final Database db = await initDb();
    final List<Map<String,dynamic>> queryResult = await db.query(_tableName);
    
    return queryResult.map((e) => Member.fromJson(e)).toList();
  }

}