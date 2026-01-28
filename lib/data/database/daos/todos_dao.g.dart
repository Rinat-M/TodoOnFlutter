// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_dao.dart';

// ignore_for_file: type=lint
mixin _$TodosDaoMixin on DatabaseAccessor<AppDatabase> {
  $PrioritiesTable get priorities => attachedDatabase.priorities;
  $ExecutorsTable get executors => attachedDatabase.executors;
  $StatusesTable get statuses => attachedDatabase.statuses;
  $TodosTable get todos => attachedDatabase.todos;
  TodosDaoManager get managers => TodosDaoManager(this);
}

class TodosDaoManager {
  final _$TodosDaoMixin _db;
  TodosDaoManager(this._db);
  $$PrioritiesTableTableManager get priorities =>
      $$PrioritiesTableTableManager(_db.attachedDatabase, _db.priorities);
  $$ExecutorsTableTableManager get executors =>
      $$ExecutorsTableTableManager(_db.attachedDatabase, _db.executors);
  $$StatusesTableTableManager get statuses =>
      $$StatusesTableTableManager(_db.attachedDatabase, _db.statuses);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db.attachedDatabase, _db.todos);
}
