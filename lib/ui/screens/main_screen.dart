import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/priority_enum.dart';
import 'package:todos_app/data/providers/data_providers.dart';
import 'package:todos_app/ui/components/styled_list_tile.dart';
import 'package:todos_app/ui/components/todo_bottom_nav_bar.dart';
import 'package:todos_app/ui/screens/create_todo_screen.dart';
import 'package:todos_app/utils/date_formater.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  Image getPriorityIcon(PriorityEntity priority) {
    return switch (PriorityEnum.fromString(priority.name)) {
      PriorityEnum.low => Image.asset(
        'assets/images/low.png',
        width: 24.0,
        color: Colors.yellow, 
        colorBlendMode: BlendMode.srcIn,
      ),
      PriorityEnum.medium => Image.asset(
        'assets/images/medium.png',
        width: 24.0,
        color: Colors.green, 
        colorBlendMode: BlendMode.srcIn,
      ),
      PriorityEnum.high => Image.asset(
        'assets/images/high.png',
        width: 24.0,
        color: Colors.red, 
        colorBlendMode: BlendMode.srcIn,
      ),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProviders);

    final selectedIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: todos.when(
        data: (items) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return SizedBox(
                height: 90,
                child: StyledListTile(
                  leading: getPriorityIcon(item.priority),
                  title: item.todo.description,
                  subtitle: Text(
                    "${StringConstants.executionDate}: ${formatter.format(item.todo.executionDate)}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                ),
              );
            },
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TodoScreen()),
        ),
        tooltip: 'Create todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: TodoBottomNavBar(
        selectedIndex: selectedIndex.value,
        onTab: (index) => selectedIndex.value = index,
      ),
    );
  }
}
