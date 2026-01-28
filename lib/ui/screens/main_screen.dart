import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/providers/repository_providers.dart';
import 'package:todos_app/ui/components/todo_bottom_nav_bar.dart';
import 'package:todos_app/ui/screens/todo_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
    final todosRepository = ref.watch(todosRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: todosRepository.watchTodos(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                leading: const Icon(Icons.list),
                title: Text(item.description),
              );
            },
          );
        },
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
