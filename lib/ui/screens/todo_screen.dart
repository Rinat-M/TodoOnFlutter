import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/providers/data_providers.dart';

// const List<String> priorities = ['Низкий', 'Средний', 'Высокий'];
const List<String> executors = ['Неизвестный', 'Вася', 'Петя'];

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  List<DropdownMenuItem<Priority>>? _buildPriorityItems(
    AsyncValue<List<Priority>> itemsAsync,
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

  List<DropdownMenuItem<Executor>>? _buildExecutorItems(
    AsyncValue<List<Executor>> itemsAsync,
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
    final selectedPriority = useState<Priority?>(null);
    final selectedExecutor = useState<Executor?>(null);

    final prioritiesAsync = ref.watch(prioritiesProviders);
    final executorsAsync = ref.watch(executorsProviders);

    final dateController = useTextEditingController();

    final dateFormKey = useMemoized(() => GlobalKey());

    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);

    DateTime? _selectedDate;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(StringConstants.task),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(StringConstants.taskDescription),
                  hint: Text(StringConstants.enterDescriptionOfTheTask),
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                minLines: 1,
                keyboardType: TextInputType.multiline,
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
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Выберите дату' : null,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: startOfDay,
                    lastDate: startOfDay.add(Duration(days: 365)),
                  );
                  if (date != null) {
                    _selectedDate = date;
                    dateController.text =
                        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<Executor?>(
                initialValue: selectedExecutor.value,
                hint: const Text(StringConstants.selectExecutor),
                items: _buildExecutorItems(executorsAsync),
                onChanged: (value) => selectedExecutor.value = value,
                decoration: const InputDecoration(
                  labelText: StringConstants.executor,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<Priority?>(
                initialValue: selectedPriority.value,
                hint: const Text(StringConstants.selectPriority),
                items: _buildPriorityItems(prioritiesAsync),
                onChanged: (value) => selectedPriority.value = value,
                decoration: const InputDecoration(
                  labelText: StringConstants.priority,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  onPressed: () {
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
    );
  }
}
