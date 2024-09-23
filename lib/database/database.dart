import 'dart:io';
//import "package:crud_sqflite_app/models/note_model.dart";
import 'package:list_app/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';




class DatabaseHelper{
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Null  _db = null;

  DatabaseHelper._instance();


  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String coldate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  /*


   */

Future<Database?> get db async{
  if(_db == null){
 _db = (await _initDb()) as Null;
  }
  return _db;
}

Future<Database> _initDb() async {

  Directory dir = await getApplicationDocumentsDirectory();
  String path = dir.path + 'todo_list.db';
  final todoListDB = await openDatabase(
    path, version: 1, onCreate: _createDb
  );
 return todoListDB;
}
void _createDb(Database db, int version) async {
  await db.execute(
      'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $coldate TEXT, $colPriority TEXT, $colStatus INTEGER)'
  );
}

Future<List<Map<String, dynamic>>> getNoteMapList() async{
  Database? db = await this.db;
  final List<Map<String, dynamic>> result = await db!.query(noteTable);
  return result;
}

Future<List<Note>> getNoteList() async{
  final List<Map<String, dynamic>> noteMapList = await getNoteMapList();

  final List<Note> noteList = [];

  noteMapList.forEach((noteMap) {

  });
  noteList.sort((noteA, noteB) => noteA.date!.compareTo(noteB.date!));

  return noteList;
}

Future<int> insertNote(Note note) async{
  Database? db = await this.db;
  final int result = await db!.update(
    noteTable,
    note.toMap(),
    where: '$colId = ?',
    whereArgs: [note.id],
  );
  return result;
}

Future<int> updateNote(Note note) async{
    Database? db = await this.db;
    final int result = await db!.update(
      noteTable,
      note.toMap(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );
    return result;
  }
  Future<int> deleteNote(int id) async{
    Database? db = await this.db;
    final int result = await db!.delete(
      noteTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }


  openDatabase(String path, {required int version, required void Function(Database db, int version) onCreate}) {}

  getApplicationDocumentsDirectory() {}


 }

class Database {
  execute(String s) {}

  query(String noteTable) {}

  delete(String noteTable, {required String where, required List<int> whereArgs}) {}

  update(String noteTable, Map<String, dynamic> map, {required String where, required List<int?> whereArgs}) {}
}