import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/media_model.dart';
import '../model/to_do_model.dart';

class DBHelper{
  
  DBHelper._();
  
  static final DBHelper getInstance = DBHelper._();

  /// Global Variables for TODO Table

  static final String TODO_TABLE = 'toDoTable';
  static final String TODO_COLUMN_TASK_ID = 'id';
  static final String TODO_COLUMN_TITLE = 'title';
  static final String TODO_COLUMN_DESC = 'desc';
  static final String TODO_COLUMN_IS_COMPLETE = 'isComplete';

  /// Global Variables For Images/Media Table

  static final String MEDIA_TABLE = 'mediTable';
  static final String MEDIA_COLUMN_ID = 'mediaId';
  static final String MEDIA_COLUMN_IMG = 'imgPath';
  static final String MEDIA_COLUMN_VID = 'vidPath';



  Database? mainDB;

  /// Get DataBase
  Future<Database> getDB() async{
    mainDB ??= await openDB();
    return mainDB!;
  }
  
  /// Open Data Base & Create Table
  Future<Database> openDB() async{
   Directory appDirectory = await getApplicationDocumentsDirectory();
   var rootPath = appDirectory.path;
   var dbPath = join(rootPath, 'todo.db');
   
   return openDatabase(dbPath,version: 1,onCreate: (db,version){
     db.execute("create table $TODO_TABLE ($TODO_COLUMN_TASK_ID integer primary key autoincrement, $TODO_COLUMN_TITLE text, $TODO_COLUMN_DESC text, $TODO_COLUMN_IS_COMPLETE integer default 0)");
     db.execute("create table $MEDIA_TABLE ($MEDIA_COLUMN_ID integer primary key autoincrement, $MEDIA_COLUMN_IMG text, $MEDIA_COLUMN_VID text)");
   });
  }


  /// Add TODO Task
Future<bool> addTask({required ToDoModel addTodo}) async{
    var db = await getDB();

    int rowsEffected = await db.insert(TODO_TABLE, addTodo.toMap());
    return rowsEffected>0;
}

/// Fetch all Task Data
  Future<List<ToDoModel>> getAllTask() async{
    var db = await getDB();
    List<ToDoModel> allTask = [];

    var toDoData = await db.query(TODO_TABLE);
    for(Map<String,dynamic> eachTask in toDoData){
      ToDoModel eachModel = ToDoModel.fromMap(eachTask);
      allTask.add(eachModel);
    }
    return allTask;
  }

  /// ToDo Is completed or not

  Future<bool> isCompleted ({required int id,required bool isComplete}) async{
    var db = await getDB();

   int rowsEffected = await db.update(TODO_TABLE, {
     TODO_COLUMN_IS_COMPLETE : isComplete ? 1:0,
   }, where: "$TODO_COLUMN_TASK_ID =?" , whereArgs: ['$id'] );

   return rowsEffected>0;

  }


  /// Delete Task
Future<bool> deleteTask({required int id}) async{
    var db = await getDB();

    int rowsEffected = await db.delete(TODO_TABLE,where: "$TODO_COLUMN_TASK_ID =? ", whereArgs: ['$id']);

    return rowsEffected>0;
}


/// ADD IMAGES/MEDIA

Future<bool> addMedia({required MediaModel mMedia}) async{
    var db = await getDB();
    int rowsEffected = await db.insert(MEDIA_TABLE, mMedia.toMap());
    return rowsEffected>0;
}

/// Fetch all Media
Future<List<MediaModel>> fetchAllMedia() async{
    var db = await getDB();
    List<MediaModel> allMedia = [];

    var mediaData = await db.query(MEDIA_TABLE);

    for(Map<String,dynamic> eachMedia in mediaData  ){
      MediaModel eachModel = MediaModel.fromMap(eachMedia);
      allMedia.add(eachModel);
    }
    return allMedia;
}

/// Delete Media
  Future<bool> deleteMedia({required int id}) async {
    var db = await getDB();
    int rowsEffected = await db.delete(MEDIA_TABLE, where: "$MEDIA_COLUMN_ID = ?", whereArgs: [id]);
    return rowsEffected > 0;
  }

  
}