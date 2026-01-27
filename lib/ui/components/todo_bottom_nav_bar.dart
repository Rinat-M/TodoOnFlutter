import 'package:flutter/material.dart';
import 'package:todo_app/common/string_constants.dart';

class TodoBottomNavBar extends StatelessWidget {
  final Function(int) onTab;
  final int selectedIndex;

  const TodoBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTab,
      items: const [
        BottomNavigationBarItem(
          label: StringConstants.myTodos,
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: StringConstants.todosFromMe,
          icon: Icon(Icons.list),
        ),
      ],
      selectedItemColor: Colors.amber[800],
    );
  }
}
