import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/entites/status_enum.dart';
import 'package:todos_app/data/entites/todo_with_relations.dart';
import 'package:todos_app/data/providers/data_providers.dart';
import 'package:todos_app/data/providers/repository_providers.dart';
import 'package:todos_app/common/date_formater.dart';
import 'package:todos_app/common/logger.dart';

@RoutePage()
class EditTodoScreen extends HookConsumerWidget {
  final int todoId;

  const EditTodoScreen({super.key, @PathParam('id') required this.todoId});

  void changeTodoStatus(WidgetRef ref, TodoWithRelations item) {
    final todosRepository = ref.read(todosRepositoryProvider);
    final statusEnum = StatusEnum.fromString(item.status.name);

    if (statusEnum == StatusEnum.completed) {
      return;
    }

    final ({String dialogText, StatusEnum newStatus}) statusData =
        switch (statusEnum) {
          StatusEnum.assigned => (
            dialogText: StringConstants.takeOnTheTask,
            newStatus: StatusEnum.inProcess,
          ),
          StatusEnum.inProcess => (
            dialogText: StringConstants.completeTheTask,
            newStatus: StatusEnum.completed,
          ),
          _ => (dialogText: '', newStatus: StatusEnum.assigned),
        };

    todosRepository.updateTodoStatus(item.todo.id, statusData.newStatus);
  }

  Widget getActionButtonText(TodoWithRelations item) {
    final statusEnum = StatusEnum.fromString(item.status.name);

    return switch (statusEnum) {
      StatusEnum.assigned => const Text(StringConstants.takeOn),
      StatusEnum.inProcess => const Text(StringConstants.complete),
      _ => const Text(''),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoDataAsync = ref.watch(todoDataProvider(todoId));

    final statusController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(StringConstants.task),
      ),
      body: todoDataAsync.when(
        data: (item) {
          logger.i("Obtaining data on a task ${item.todo.id}");

          statusController.text = item.status.description;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: item.todo.description,
                    decoration: const InputDecoration(
                      label: Text(StringConstants.taskDescription),
                      hint: Text(StringConstants.enterDescription),
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    readOnly: true,
                    maxLines: null,
                    minLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: formatter.format(item.todo.executionDate),
                    decoration: const InputDecoration(
                      labelText: StringConstants.executionDate,
                      icon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: item.executor.name,
                    decoration: const InputDecoration(
                      labelText: StringConstants.executor,
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: item.priority.description,
                    decoration: const InputDecoration(
                      labelText: StringConstants.priority,
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(
                      labelText: StringConstants.status,
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                if (StatusEnum.fromString(item.status.name) !=
                    StatusEnum.completed)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: ElevatedButton(
                        onPressed: () {
                          changeTodoStatus(ref, item);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                StringConstants.statusHasBeenChanged,
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: getActionButtonText(item),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
