import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/query/query_database.dart';
import 'package:food_ordering_app/update/update.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'dbhelper/mangodb_connection.dart';
import 'delete/delete.dart';
import 'displaydata/display_data.dart';
import 'insertdata/insert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MangoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: QueryDatabase(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(


      ),
      body:SafeArea(child: Text("Hello"),)

    );
  }
}
