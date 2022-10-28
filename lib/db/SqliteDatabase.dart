import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:icddrb/model/student.dart';

class SqliteDatabase {
  final _dbName ="icddrb.db";
  final _tableName = "student";

  Future<Database> initDb() async{
    String path = await getDatabasesPath();
    String createTable = "CREATE TABLE ${_tableName}"
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

  Future<int> insertRecord(Student student) async{
    final Database db = await initDb();
    print(student.toJson());
    //var result = await db.insert(_tableName, member.toJson());
    var result = await db.rawInsert(
      "INSERT INTO $_tableName (`full_name`, `age`, `date`, `time`, `gender`, `education`)"
          " VALUES ('${student.fullName}', '${student.age}',"
          "'${student.date}', '${student.time}', '${student.gender}', '${student.education}')"
    );

    print("SELECT * FROM student");
    return result;
  }


  Future<List<Student>> getRecord() async{
    final Database db = await initDb();
    final List<Map<String,dynamic>> queryResult = await db.query(_tableName);
    
    return queryResult.map((e) => Student.fromJson(e)).toList();
  }

}