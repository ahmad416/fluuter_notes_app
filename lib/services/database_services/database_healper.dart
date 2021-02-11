import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notes/models/note.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // database credentials
  static final _dbName = "notes.db";
  static final _dbVersion = 1;
  static final _tableName = "notes";

  static Database _database;

  // getting the database
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initilizingDatabase();
    return _database;
  }

  // initilizing database
  _initilizingDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // oncreate method
  Future<void> _onCreate(Database db, int versiob) {
    return db.execute('''
    CREATE TABLE $_tableName(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      dateTimeCreated TEXT NOT NULL,
      dateTimeEdited TEXT NOT NULL
    )
    ''');
  }

  // add note
  Future<int> addNote(Note note) async {
    Database db = await instance.database;
    return await db.insert(_tableName, note.toMap());
  }

  //delete note
  Future<int> deleteNote(Note note) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: "id = ? ", whereArgs: [note.id]);
  }

  // delete all note
  Future<int> deleteAllNote() async {
    Database db = await instance.database;
    return await db.delete(_tableName);
  }

  // update note
  Future<int> updateNote(Note note) async {
    Database db = await instance.database;
    return await db.update(_tableName, note.toMap(),
        where: "id  = ? ", whereArgs: [note.id]);
  }

  // getting all notes
  Future<List<Note>> getNoteList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (index) {
      return Note(
          id: maps[index]['id'],
          title: maps[index]['title'],
          content: maps[index]['content'],
          dateTimeEdited: maps[index]['dateTimeEdited'],
          dateTimeCreated: maps[index]['dateTimeCreated']);
    });
  }
}
