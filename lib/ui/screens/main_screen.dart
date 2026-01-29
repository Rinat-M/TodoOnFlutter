import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/providers/data_providers.dart';
import 'package:todos_app/ui/components/todo_bottom_nav_bar.dart';
import 'package:todos_app/ui/screens/create_todo_screen.dart';
import 'package:todos_app/utils/date_formater.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  Image getPriorityIcon(PriorityEntity priority) {
    return switch (priority.name) {
      'Low' => Image.asset('assets/images/low.png', width: 24.0),
      'Medium' => Image.asset('assets/images/medium.png', width: 24.0),
      'High' => Image.asset('assets/images/high.png', width: 24.0),
      _ => Image.asset('assets/images/low.png', width: 24.0),
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
          return ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return SizedBox(
                height: 80,
                child: ListTile(
                  leading: getPriorityIcon(item.priority),
                  title: Text(
                    item.todo.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "${StringConstants.executionDate}: ${formatter.format(item.todo.executionDate)}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade300,
              indent: 16,
            ),
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
