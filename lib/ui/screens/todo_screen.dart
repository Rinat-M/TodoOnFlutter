import 'package:flutter/material.dart';
import 'package:todos_app/common/string_constants.dart';

const List<String> priorities = ['Низкий', 'Средний', 'Высокий'];
const List<String> executors = ['Неизвестный', 'Вася', 'Петя'];

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String priority = priorities[1];
  String executor = executors[0];
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);

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
                controller: _dateController,
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
                    _dateController.text =
                        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                initialValue: executor,
                hint: const Text(StringConstants.selectExecutor),
                items: executors
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (String? value) => setState(() => executor = value!),
                decoration: const InputDecoration(
                  labelText: StringConstants.executor,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                initialValue: priority,
                hint: const Text(StringConstants.selectPriority),
                items: priorities
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (String? value) => setState(() => priority = value!),
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
