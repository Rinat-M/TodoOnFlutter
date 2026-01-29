import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/entites/executor_entity.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/todo_entity.dart';
import 'package:todos_app/data/providers/data_providers.dart';
import 'package:todos_app/data/providers/repository_providers.dart';
import 'package:todos_app/utils/date_formater.dart';

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  List<DropdownMenuItem<PriorityEntity>>? _buildPriorityItems(
    AsyncValue<List<PriorityEntity>> itemsAsync,
  ) {
    return itemsAsync.when(
      data: (items) {
        return items
            .map(
              (item) =>
                  DropdownMenuItem(value: item, child: Text(item.description)),
            )
            .toList();
      },
      error: (error, _) => [
        DropdownMenuItem(value: null, child: Text('Ошибка: $error')),
      ],
      loading: () => [
        const DropdownMenuItem(
          value: null,
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<ExecutorEntity>>? _buildExecutorItems(
    AsyncValue<List<ExecutorEntity>> itemsAsync,
  ) {
    return itemsAsync.when(
      data: (items) {
        return items
            .map(
              (item) => DropdownMenuItem(value: item, child: Text(item.name)),
            )
            .toList();
      },
      error: (error, _) => [
        DropdownMenuItem(value: null, child: Text('Ошибка: $error')),
      ],
      loading: () => [
        const DropdownMenuItem(
          value: null,
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPriority = useState<PriorityEntity?>(null);
    final selectedExecutor = useState<ExecutorEntity?>(null);
    final selectedDate = useState<DateTime?>(null);

    final prioritiesAsync = ref.watch(prioritiesProviders);
    final executorsAsync = ref.watch(executorsProviders);

    final dateController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(StringConstants.task),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    label: Text(StringConstants.taskDescription),
                    hint: Text(StringConstants.enterDescription),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  validator: (value) => (value?.trim().length ?? 0) < 5
                      ? StringConstants.minimumFiveCharacters
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  readOnly: true, // Только выбор
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: StringConstants.executionDate,
                    icon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true
                      ? StringConstants.requiredField
                      : null,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: startOfDay,
                      lastDate: startOfDay.add(Duration(days: 365)),
                    );
                    if (date != null) {
                      selectedDate.value = date;
                      dateController.text = formatter.format(date);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<ExecutorEntity?>(
                  initialValue: selectedExecutor.value,
                  hint: const Text(StringConstants.selectExecutor),
                  items: _buildExecutorItems(executorsAsync),
                  onChanged: (value) => selectedExecutor.value = value,
                  decoration: const InputDecoration(
                    labelText: StringConstants.executor,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null ? StringConstants.requiredField : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<PriorityEntity?>(
                  initialValue: selectedPriority.value,
                  hint: const Text(StringConstants.selectPriority),
                  items: _buildPriorityItems(prioritiesAsync),
                  onChanged: (value) => selectedPriority.value = value,
                  decoration: const InputDecoration(
                    labelText: StringConstants.priority,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null ? StringConstants.requiredField : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final todosRepository = ref.read(todosRepositoryProvider);

                      todosRepository.addTodo(
                        TodoEntity(
                          id: 0,
                          description: descriptionController.text,
                          priority: selectedPriority.value?.id ?? 0,
                          executor: selectedExecutor.value?.id ?? 0,
                          executionDate: selectedDate.value!,
                        ),
                      );

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringConstants.taskHasBeenCreated),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(StringConstants.createTask),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
