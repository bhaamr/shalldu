import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqlite_provider_starter/firebase_options.dart';
import 'package:sqlite_provider_starter/routes/routes.dart';
import '../pages/todoList.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteManager.listPage,
        onGenerateRoute: RouteManager.generateRoute,
        home: Cloudtest()
    );
  }
}