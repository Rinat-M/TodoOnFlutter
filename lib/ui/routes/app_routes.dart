import 'package:flutter/material.dart';
import 'package:todos_app/ui/screens/create_todo_screen.dart';
import 'package:todos_app/ui/screens/edit_todo_screen.dart';

class AppRoutes {
  static const main = '/';
  static const createTodo = '/create_todo';
  static const editTodo = '/edit_todo';

  static Map<String, WidgetBuilder> get routes => {
    createTodo: (context) => const CreateTodoScreen(),
    editTodo: (context) => const EditTodoScreen(),
  };
}
