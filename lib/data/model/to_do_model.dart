

import '../loacal_data/db_helper.dart';

class ToDoModel{
  int? id;
  String title;
  String desc;
  bool? isCompleted;

  ToDoModel({this.id,required this.title,required this.desc,this.isCompleted = false });


  /// Model To Map
  factory ToDoModel.fromMap(Map<String,dynamic> map){
    return ToDoModel(
        id: map[DBHelper.TODO_COLUMN_TASK_ID],
        title: map[DBHelper.TODO_COLUMN_TITLE],
        desc:map[DBHelper.TODO_COLUMN_DESC],
        isCompleted: map[DBHelper.TODO_COLUMN_IS_COMPLETE] == 1,
    );
  }

  /// Map to Model

Map<String,dynamic> toMap(){
    return {
      DBHelper.TODO_COLUMN_TITLE: title,
      DBHelper.TODO_COLUMN_DESC : desc,
      DBHelper.TODO_COLUMN_IS_COMPLETE: isCompleted
    };
}

}