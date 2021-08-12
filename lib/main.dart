import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:research_sqfligt/db_manager.dart';
import 'package:sqflite/sqflite.dart';

// late Database db;

void main() async {
  // db = await DbManager.instance.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _runCode,
        child: Icon(Icons.run_circle),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _runCode() async {

    final db = await DbManager.instance.database;

    final result = await db.rawQuery(
      // "Select * from table1 left outer join table2 on table1.id = table2.person_id"
      'Select distinct firstname, surname from table1 left outer join table2 on table1.id = table2.person_id where table2.type = "type 3"'
    );

    dev.log("$result", name: "INSPECT");

  }

}
