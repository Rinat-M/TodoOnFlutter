import 'package:drift/drift.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/entites/todo_entity.dart';

extension TodoMapper on Todo {
  TodoEntity toDomain() => TodoEntity(
    id: id,
    description: description,
    priority: priority,
    executor: executor,
    author: author,
    status: status,
    createdAt: createdAt,
    executionDate: executionDate,
  );
}

extension TodoDomainMapper on TodoEntity {
  Todo toDb({required int defaultStatus}) => Todo(
    id: id,
    description: description,
    priority: priority,
    executor: executor,
    author: author,
    status: status ?? defaultStatus,
    createdAt: createdAt ?? DateTime.now(),
    executionDate: executionDate,
  );

  TodosCompanion toDbCompanion({required int defaultStatus}) => TodosCompanion(
    description: Value(description),
    priority: Value(priority),
    executor: Value(executor),
    author: Value(author),
    status: Value(status ?? defaultStatus),
    executionDate: Value(executionDate),
  );
}
