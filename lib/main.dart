import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:task_todo/providers/media_provider.dart';
import 'package:task_todo/providers/theme_provides.dart';
import 'package:task_todo/providers/to_do_provider.dart';
import 'package:task_todo/view/tab_bar/screen/splash_screen.dart';
import 'package:task_todo/view/tab_bar/tab_bar_page.dart';

import 'data/loacal_data/db_helper.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ToDoProvider(myDB: DBHelper.getInstance)),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => MediaProvider(myDb: DBHelper.getInstance)),
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     /// Dark Theme
     darkTheme: ThemeData(
       canvasColor: Colors.black,
       brightness: Brightness.dark,
     ),

     themeMode: context.watch<ThemeProvider>().getTheme() ? ThemeMode.dark : ThemeMode.light,

     /// Light Theme
      theme: ThemeData(
        canvasColor: Colors.white,
        brightness: Brightness.light,
        /*colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      */  useMaterial3: true,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

