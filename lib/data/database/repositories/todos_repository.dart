import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/database/daos/todos_dao.dart';
import 'package:todos_app/data/database/mappers/executor_mapper.dart';
import 'package:todos_app/data/database/mappers/priority_mapper.dart';
import 'package:todos_app/data/database/mappers/status_mapper.dart';
import 'package:todos_app/data/database/mappers/todo_mapper.dart';
import 'package:todos_app/data/entites/executor_entity.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/status_entity.dart';
import 'package:todos_app/data/entites/todo_entity.dart';
import 'package:todos_app/data/entites/todo_with_relations.dart';

class TodosRepository {
  final TodosDao _dao;

  const TodosRepository(this._dao);

  Future<List<TodoEntity>> get allTodos async {
    final todosDb = await _dao.allTodos;
    return todosDb.map((e) => e.toDomain()).toList();
  }

  Stream<List<TodoEntity>> watchTodos() {
    return _dao.watchAllTodos.map(
      (list) => list.map((e) => e.toDomain()).toList(),
    );
  }

  Stream<List<TodoWithRelations>> watchTodosWithRelations() =>
      _dao.watchAllTodoWithRelations();

  Future<int> addTodo(TodoEntity todo) async {
    final defaultStatus = await _dao.getStatusByName('Assigned');
    return _dao.insertTodoCompanion(
      todo.toDbCompanion(defaultStatus: defaultStatus.id),
    );
  }

  Future<void> updateTodo(Todo todo) async {
    return _dao.updateTodo(todo);
  }

  Future<List<PriorityEntity>> get allPriorities async {
    final prioritiesDb = await _dao.allPriorities;
    return prioritiesDb.map((e) => e.toDomain()).toList();
  }

  Future<List<ExecutorEntity>> get allExecutors async {
    final executorsDb = await _dao.allExecutors;
    return executorsDb.map((e) => e.toDomain()).toList();
  }

  Future<List<StatusEntity>> get allStatuses async {
    final statusesDb = await _dao.allStatuses;
    return statusesDb.map((e) => e.toDomain()).toList();
  }
}
