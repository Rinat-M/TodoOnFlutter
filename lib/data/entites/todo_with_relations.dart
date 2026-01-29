import 'package:todos_app/data/entites/executor_entity.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/todo_entity.dart';

class TodoWithRelations {
  final TodoEntity todo;
  final PriorityEntity priority;
  final ExecutorEntity executor;

  const TodoWithRelations({
    required this.todo,
    required this.priority,
    required this.executor,
  });
}
