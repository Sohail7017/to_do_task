
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/to_do_model.dart';
import '../../../providers/to_do_provider.dart';

class ToDoScreen extends StatefulWidget {

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
    var titleController = TextEditingController();

    var descController = TextEditingController();
    List<ToDoModel> allTask = [];
    bool isComplete = false;
    bool _isLight = false;
    @override
  void initState() {
    super.initState();
    context.read<ToDoProvider>().fetchTask();
  }


  @override
  Widget build(BuildContext context) {
    allTask = context.watch<ToDoProvider>().getAllTask();
    _isLight =  Theme.of(context).brightness==Brightness.light;


    return Scaffold(
      body: Column(
        children: [
         SizedBox(
           height: MediaQuery.of(context).size.height*0.014,
         ),
          Text("Today's Task",style: TextStyle(fontSize: 25),),
          
          /// TASK Data Show in UI
          
          Expanded(
            child: Consumer(builder: (_,provider,__){
              return allTask.isNotEmpty ?  ListView.builder(
                  itemCount: allTask.length,
                  itemBuilder: (_,index){
                return Card(
                  
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  color: _isLight ? Colors.purple.shade300 : Colors.black54,
                  elevation: 7,

                  child: ListTile(
                    leading: Checkbox(
            
                        checkColor: Colors.white,
                        value: allTask[index].isCompleted ?? false,
                        onChanged: (Value){
                          context.read<ToDoProvider>().isComplete(
                              id: allTask[index].id!,
                              isCompleted: Value!
                          );
                    }),
                    title: Text(allTask[index].title,style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600,
                        decoration: allTask[index].isCompleted==true ? TextDecoration.lineThrough :TextDecoration.none  ),),
                    subtitle: Text(allTask[index].desc,style: TextStyle(
                        fontSize: 15,
                        decoration: allTask[index].isCompleted==true ? TextDecoration.lineThrough :TextDecoration.none ),),
                    trailing: InkWell(
                        onTap: (){

                          String msg = "Task Delete Successful!!";
                          if(allTask[index].isCompleted == true){

                            context.read<ToDoProvider>().deleteTask(id: allTask[index].id!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                          }else{
                            msg = "This task can't be deleted Please complete the task first";
                            showDialog(context: context, builder: (_){
                              return alertBox(
                                isLight: _isLight,
                                  mHeight: MediaQuery.of(context).size.height*0.60,
                                  message: msg);
                            });

                          }

                          },
                        child: Icon(Icons.delete,size: 25,color: Colors.red.shade600,)),
                  ),
                );
              }) : Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_rounded,size: 55,color: Colors.deepPurple.shade100,),
                            Text(
                              'No Task Yet !!!',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _isLight ? Colors.black26 : Colors.white),
                            ),
                          ],
              ),);
            }),
          ),
        ],
      ),








        floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
          shape: CircleBorder(),
          onPressed: () {
          showDialog(context: context, builder: (_){
            return dialogBox(
              isLight: _isLight,
                mHeight: MediaQuery.of(context).size.height*0.18,
             mAction: [

               TextButton(onPressed: (){
                 Navigator.pop(context);
               }, child: Text('Cancel')),

               /// ADD TASK

               TextButton(onPressed: ()  {
                 var mTitle = titleController.text.toString();
                 var mDesc = descController.text.toString();

                 context.read<ToDoProvider>().addTask(addToDo: ToDoModel(title: mTitle, desc: mDesc));
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task Added Successful!!')));
                  Navigator.pop(context);
                  titleController.clear();
                  descController.clear();

               }, child: Text('Add')),
             ]
               );
          });

          },
        child: Icon(Icons.add,size: 35,),
     )
    );

  }

    Widget alertBox({required double mHeight,required String message,required bool isLight}) {
      return AlertDialog(
        backgroundColor: isLight?Colors.deepPurple.shade100: Colors.white12,
        title: const Text('Alert!!', style: TextStyle(fontSize: 25,color: Colors.red),textAlign: TextAlign.center),
        content: Text(message,style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('OK',style: TextStyle(fontSize: 18),))
        ],
      );
    }

    Widget dialogBox({ required double mHeight, required List<Widget> mAction , required bool isLight }){
    return AlertDialog(
      backgroundColor: isLight ? Colors.deepPurple.shade100 :Colors.black,
      title:  Text('Add Task',style: TextStyle(fontSize: 20, color: isLight ? Colors.black : Colors.white) ,),
      content: SizedBox(
        height: mHeight,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: isLight ? Colors.black : Colors.white),
              ),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  labelText: 'Desc',
                labelStyle: TextStyle(color: isLight ? Colors.black : Colors.white),
              ),
            ),
          ],
        ),
      ),
      actions: mAction,
    );
}
}
