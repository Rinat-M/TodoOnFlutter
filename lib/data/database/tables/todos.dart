import 'package:drift/drift.dart';
import 'package:todos_app/data/database/tables/executors.dart';
import 'package:todos_app/data/database/tables/priorities.dart';
import 'package:todos_app/data/database/tables/statuses.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  IntColumn get priority => integer().references(Priorities, #id)();
  IntColumn get executor => integer().references(Executors, #id)();
  IntColumn get status => integer().references(Statuses, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get executionDate => dateTime()();
}
