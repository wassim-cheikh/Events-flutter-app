import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class db {
  static Database? my_db;

  Future<Database> getDb() async {
    if (my_db == null) {
      my_db = await createDatabase();
    }
    return my_db!;
  }

  Future<Database> createDatabase() async {
      databaseFactory = databaseFactory;


    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'db999.db');
    var database = await openDatabase(dbPath, version: 1, onCreate: CreateTables);
    print('============== DATABASE CREATED');
    return database;
  }

  void CreateTables(Database database, int version) async {
    await database.execute('''
    CREATE TABLE "Users" (
        "username" TEXT PRIMARY KEY ,
        "email" TEXT,
        "password" TEXT,
        "first_name" Text,
        "last_name" TEXT,
        "birth_date" TEXT ,
        "sex" TEXT ,
        "phone_number" INTEGER,
        "bio" TEXT,
        "image_url" TEXT)
        ''');

    await database.execute('''
    CREATE TABLE "Comments" (
        "event_id" INTEGER,
        "username" TEXT,
        "comment" TEXT)
        ''');
    await database.execute('''
    CREATE TABLE "Reports" (
        "event_id" INTEGER,
        "username" TEXT,
        "report" TEXT)
        ''');
    await database.execute('''
    CREATE TABLE "Favorites" (
        "username" TEXT ,
        "event_id" INTEGER
        )
        ''');
    await database.execute('''
    CREATE TABLE "Admins" (
        "id" INTEGER PRIMARY KEY  ,
        "password" TEXT)
        ''');
    await database.rawInsert('''
  INSERT INTO "Admins" ("id", "password") VALUES (?, ?)
''', ['11111', '0000']);
    await database.execute('''
    CREATE TABLE "Events" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT,
        "type" TEXT,
        "city" TEXT,
        "adress" TEXT,
        "date" TEXT , 
        "time" TEXT,
        "theme" TEXT,
        "description" TEXT, 
        "price" DOUBLE ,
        "ntickets" INTEGER ,
        "image_url" TEXT
        
        
        )
        ''');
  }

  Future<List<Map>> readData(String sql) async {
    Database mydb = await getDb();
    List<Map> response = await mydb.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database mydb = await getDb();
    int response = await mydb.rawInsert(sql);
    return response;
  }


  updateData(String sql) async {
    Database? mydb = await  my_db ;
    int response =await my_db!.rawUpdate(sql);
    return response ;
  }
  deleteData(String sql) async {
    Database? mydb = await  my_db ;
    int response =await my_db!.rawDelete(sql);
    return response ;
  }}





