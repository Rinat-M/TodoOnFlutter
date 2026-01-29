import 'package:drift/drift.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/database/mappers/executor_mapper.dart';
import 'package:todos_app/data/database/mappers/priority_mapper.dart';
import 'package:todos_app/data/database/mappers/todo_mapper.dart';
import 'package:todos_app/data/database/tables/todos.dart';
import 'package:todos_app/data/entites/todo_with_relations.dart';
import 'package:todos_app/utils/logger.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(super.attachedDatabase);

  Future<List<Todo>> get allTodos => select(todos).get();

  Stream<List<Todo>> get watchAllTodos => select(todos).watch();

  Future<List<Status>> get allStatuses => select(statuses).get();

  Future<Status> getStatusByName(String name) async {
    return (select(statuses)..where((e) => e.name.equals(name))).getSingle();
  }

  Future<List<Priority>> get allPriorities => select(priorities).get();

  Future<List<Executor>> get allExecutors => select(executors).get();

  Future<int> insertTodo(Todo todo) => into(todos).insert(todo);

  Future<int> insertTodoCompanion(TodosCompanion todo) =>
      into(todos).insert(todo);

  Future<void> updateTodo(Todo todo) => update(todos).replace(todo);

  Stream<List<TodoWithRelations>> watchAllTodoWithRelations() {
    logger.i("Running watchAllTodoWithRelations in TodosDao");

    final query = select(todos).join([
      innerJoin(priorities, priorities.id.equalsExp(todos.priority)),
      innerJoin(executors, executors.id.equalsExp(todos.executor)),
    ]);

    return query.watch().map((list) {
      logger.i("watchAllTodoWithRelations. Rows received: ${list.length}");
      return list
          .map(
            (e) => TodoWithRelations(
              todo: e.readTable(todos).toDomain(),
              priority: e.readTable(priorities).toDomain(),
              executor: e.readTable(executors).toDomain(),
            ),
          )
          .toList();
    });
  }
}
