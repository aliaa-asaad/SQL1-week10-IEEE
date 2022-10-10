import 'package:flutter/material.dart';
import 'package:sql1_week10/screens/to_do_screen.dart';

import 'model/db_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.instance.createDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: ToDoScreen(),
    );
  }
}
