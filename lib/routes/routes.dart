import 'package:flutter/material.dart';
//import 'package:sqlite_provider_starter/pages/login.dart';
//import 'package:sqlite_provider_starter/pages/register.dart';
import 'package:sqlite_provider_starter/pages/todoList.dart';
import 'package:sqlite_provider_starter/pages/todoEdit.dart';
import '../pages/todoPage.dart';
import 'package:sqlite_provider_starter/pages/todoAdd.dart';
class RouteManager {
  //static const String loginPage = '/';
  //static const String registerPage = '/registerPage';
  static const String todoPage = '/';
  static const String listPage = 'listPage';
  static const String todo = 'todoPage';
  static const String addTodo = 'addTodo';
  static const String editTodo = 'editTodo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case listPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: "listPage"),
          builder: (context) => Cloudtest(),
        );

      case todo:
        return MaterialPageRoute(
          builder: (context) => Todo(),
        );
      case addTodo:
        return MaterialPageRoute(
            builder: (context)=> Addtodo()
        );

      case editTodo:
        return MaterialPageRoute(
            builder: (context)=> TodoEdit()
        );

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
