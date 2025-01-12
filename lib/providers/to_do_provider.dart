import 'package:flutter/cupertino.dart';

import '../data/loacal_data/db_helper.dart';
import '../data/model/to_do_model.dart';

class ToDoProvider extends ChangeNotifier{
  DBHelper? myDB;
  ToDoProvider({required this.myDB});
  List<ToDoModel> _allToDo = [];

  /// Events

/// 1. Add Todo Task
  void addTask({required ToDoModel addToDo}) async{
   bool isAdd =  await myDB!.addTask(addTodo: addToDo);
    if(isAdd){
      _allToDo = await myDB!.getAllTask();
      notifyListeners();
    }
  }

  /// 2. Fetch all Task for
  void fetchTask()async{
    _allToDo = await myDB!.getAllTask();
    notifyListeners();
  }

  /// 3. Fetch Task after add Task

  List<ToDoModel> getAllTask() {
    return _allToDo;
  }

  /// 4. Delete Task
void deleteTask({required int id})async{
    bool isDelete = await myDB!.deleteTask(id: id);
    if(isDelete){
      _allToDo = await myDB!.getAllTask();
      notifyListeners();
    }
}

/// 5. ToDo isComplete

void isComplete({required int id, required bool isCompleted}) async{
    bool isComplete = await myDB!.isCompleted(id: id, isComplete: isCompleted);

    if(isComplete){
      _allToDo = await myDB!.getAllTask();
      notifyListeners();
    }
}

}