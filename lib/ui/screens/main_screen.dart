import 'package:flutter/material.dart';
import 'package:todos_app/ui/components/todo_bottom_nav_bar.dart';
import 'package:todos_app/ui/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _createTodo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TodoScreen()));
  }

  void _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTodo,
        tooltip: 'Create todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: TodoBottomNavBar(
        selectedIndex: _selectedIndex,
        onTab: _onTab,
      ),
    );
  }
}
