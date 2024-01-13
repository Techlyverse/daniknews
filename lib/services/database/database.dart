// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
//
// class DatabaseApi {
//   DatabaseApi._privateConstructor();
//   static final DatabaseApi instance = DatabaseApi._privateConstructor();
//
//   static Database? _database;
//   Future<Database> get database async {
//     _database ??= await _initDatabase();
//   }
//
//
//   Future<Database> _initDatabase() async{
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, 'videos.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }
//
//   Future _onCreate(Database db, int version) async{
//     await db.execute('''
//   CREATE TABLE videos(
//   id INTEGER PRIMARY KEY,
//   name TEXT
//   )
//   ''');
//   }
// }