import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:basic_note_taking_app/model/note_model.dart';

class DatabaseHelper{
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  // Get Database
  Future<Database> get getDatabase async{
    if(_database !=null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  // Initialize Database
  Future<Database> _initDB(String dbName) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return openDatabase(path,version: 1, onCreate: _onCreate);
  }

  // Create Database
  Future<void> _onCreate(Database getDb, int version)async{
    await getDb.execute(
      '''
        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT
        )
      '''
    );
  }

  // Insert into Database
  Future<int> insertNote(Note note) async{
    final db = await instance.getDatabase;
    return await db.insert('notes', note.toMap());
  }

  // Read from Database
  Future<List<Note>> readNotes() async{
    final db = await instance.getDatabase;
    final result = await db.query('notes');

    return result.map((row) => Note.fromMap(row)).toList();
  }

  // Update Database
  Future<int> updateNote(Note note) async{
    final db = await instance.getDatabase;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  // Delete from Database
  Future<int> deleteNote(int id) async{
    final db = await instance.getDatabase;
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }


}
