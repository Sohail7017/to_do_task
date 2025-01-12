import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/view/tab_bar/screen/media_screen.dart';
import 'package:task_todo/view/tab_bar/screen/to_do_screen.dart';

import '../../providers/theme_provides.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  TabController? mController;
bool _isLight = false;
  @override
  void initState() {
    super.initState();
    mController = TabController(length: 2, vsync: this);

    mController!.index = 0;
  }
  @override
  Widget build(BuildContext context) {
    _isLight = Theme.of(context).brightness==Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold,color:_isLight ? Colors.black :Colors.white),
                children: [
                  TextSpan( text:'ToDo ' ,),
                  TextSpan(text: 'Manager',style: TextStyle(color: Colors.deepPurple)),
                ])),

        /*Text(  'ToDo' ,style: TextStyle(fontSize: 25),),*/
        actions: [ Switch.adaptive(

            inactiveTrackColor: Colors.white,
            activeColor: Colors.green.shade500,
            value: context.watch<ThemeProvider>().getTheme(),
            onChanged: (value){
              context.read<ThemeProvider>().changeTheme(value);
            }),
        ],
        bottom: TabBar(

            controller: mController,

            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.task),
                    Text('ToDo Tasks'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.perm_media),
                    Text('Image/Media'),
                  ],
                ),
              ),
            ]),
      ),
      body: TabBarView(
          controller: mController,
          children: [
        ToDoScreen(),
        MediaScreen(),

      ]),
    );
  }
}
