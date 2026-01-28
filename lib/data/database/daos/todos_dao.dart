import 'package:drift/drift.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/database/tables/todos.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(super.attachedDatabase);

  Future<List<Todo>> get allTodos => select(todos).get();

   Stream<List<Todo>> get watchAllTodos => select(todos).watch();

  Future<int> insertTodo(Todo todo) => into(todos).insert(todo);

  Future<void> updateTodo(Todo todo) => update(todos).replace(todo);
}
