import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/image_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favourites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favourites(
        id INTEGER PRIMARY KEY,
        imageUrl TEXT NOT NULL,
        originalUrl TEXT NOT NULL,
        photographer TEXT NOT NULL,
        altText TEXT NOT NULL
      )
    ''');
  }

  Future<void> addFavourite(ImageModel image) async {
    final db = await instance.database;
    await db.insert(
      'favourites', 
      image.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> removeFavourite(int id) async {
    final db = await instance.database;
    await db.delete(
      'favourites', 
      where: 'id = ?', 
      whereArgs: [id]
    );
  }

  Future<List<ImageModel>> getFavourites() async {
    final db = await instance.database;
    final orderBy = 'id DESC'; 
    final maps = await db.query('favourites');

    if (maps.isNotEmpty) {
      return maps.map((map) => ImageModel.fromMap(map)).toList().reversed.toList();
    } else {
      return [];
    }
  }

  Future<bool> isFavourite(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'favourites', 
      where: 'id = ?', 
      whereArgs: [id]
    );
    return result.isNotEmpty;
  }
}
