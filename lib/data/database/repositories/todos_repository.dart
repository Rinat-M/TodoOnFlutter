import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/database/daos/todos_dao.dart';

class TodosRepository {
  final TodosDao _dao;

  TodosRepository(this._dao);

  Future<List<Todo>> get allTodos => _dao.allTodos;

  Stream<List<Todo>> watchTodos() => _dao.watchAllTodos;

  Future<int> addTodo(Todo todo) => _dao.insertTodo(todo);

  Future<void> updateTodo(Todo todo) => _dao.updateTodo(todo);
}
