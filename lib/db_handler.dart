import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlliteoperation/note_model.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;
  Future<Database?> get db async{
    if(_database != null)
      {
        return _database;
      }
    _database = await initDatabase();
    return _database;
  }
  initDatabase() async
  {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'notes.db');
    var db = await openDatabase(path,version: 1,
        onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db,int version) async{
        await db.execute(
            "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, age INTEGER NOT NULL, description TEXT NOT NULL, email TEXT NOT NULL)",
        );
  }
  Future<NoteModel> insert(NoteModel noteModel)
  async {
    var dbClient = await db;
    await dbClient!.insert('notes', noteModel.toMap());
    print("sucessfully added");
    return noteModel;
  }

  Future<List<NoteModel>> getNoteList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryRes = await dbClient!.query("notes");
   return queryRes.map((e) => NoteModel.fromMap(e)).toList();

}
}