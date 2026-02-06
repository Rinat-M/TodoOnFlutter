import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/priority_enum.dart';
import 'package:todos_app/data/entites/status_entity.dart';
import 'package:todos_app/data/providers/data_providers.dart';
import 'package:todos_app/ui/components/dropdown_filter_chip.dart';
import 'package:todos_app/ui/components/styled_list_tile.dart';
import 'package:todos_app/ui/components/todo_bottom_nav_bar.dart';
import 'package:todos_app/ui/screens/create_todo_screen.dart';
import 'package:todos_app/utils/constants.dart';
import 'package:todos_app/utils/date_formater.dart';
import 'package:todos_app/utils/logger.dart';

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
    final todosAsync = ref.watch(todosProviders);
    final statusesAsync = ref.watch(statusesProviders);
    final prioritiesAsync = ref.watch(prioritesProviders);

    final selectedIndex = useState(0);
    final selectedPriority = useState<PriorityEntity?>(null);
    final selectedStatus = useState<StatusEntity?>(null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                prioritiesAsync.when(
                  data: (items) {
                    return DropdownFilterChip<PriorityEntity>(
                      label: Text(
                        selectedPriority.value?.description ??
                            StringConstants.allPriorities,
                      ),
                      items: [
                        DropdownMenuItem<PriorityEntity>(
                          value: null,
                          child: Text(StringConstants.allPriorities),
                        ),
                        ...items.map(
                          (p) => DropdownMenuItem<PriorityEntity>(
                            value: p,
                            child: Text(p.description),
                          ),
                        ),
                      ],
                      onChanged: (PriorityEntity? value) {
                        logger.i(value);
                        selectedPriority.value = value;
                      },
                    );
                  },
                  error: (error, stack) => Text('Error: $error'),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
                SizedBox(width: 8),
                statusesAsync.when(
                  data: (items) {
                    return DropdownFilterChip<StatusEntity>(
                      label: Text(
                        selectedStatus.value?.description ??
                            StringConstants.allStatuses,
                      ),
                      items: [
                        DropdownMenuItem<StatusEntity>(
                          value: null,
                          child: Text(StringConstants.allStatuses),
                        ),
                        ...items.map(
                          (p) => DropdownMenuItem<StatusEntity>(
                            value: p,
                            child: Text(p.description),
                          ),
                        ),
                      ],
                      onChanged: (StatusEntity? value) {
                        logger.i(value);
                        selectedStatus.value = value;
                      },
                    );
                  },
                  error: (error, stack) => Text('Error: $error'),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          Expanded(
            child: todosAsync.when(
              data: (items) {
                final filteredItems = items
                    .where((e) {
                      if (selectedIndex.value == 0) {
                        return e.todo.executor == currentUserId;
                      } else {
                        return e.todo.executor != currentUserId;
                      }
                    })
                    .where((e) {
                      if (selectedPriority.value != null) {
                        return e.todo.priority == selectedPriority.value?.id;
                      }
                      return true;
                    })
                    .where((e) {
                      if (selectedStatus.value != null) {
                        return e.todo.status == selectedStatus.value?.id;
                      }
                      return true;
                    })
                    .toList();
                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];

                    return SizedBox(
                      key: ValueKey(item.todo.id),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TodoScreen()),
        ),
        tooltip: StringConstants.createTodo,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: TodoBottomNavBar(
        selectedIndex: selectedIndex.value,
        onTab: (index) => selectedIndex.value = index,
      ),
    );
  }
}
