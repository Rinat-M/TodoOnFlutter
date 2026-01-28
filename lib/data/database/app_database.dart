import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_app/data/database/daos/todos_dao.dart';
import 'package:todos_app/data/database/tables/executors.dart';
import 'package:todos_app/data/database/tables/priorities.dart';
import 'package:todos_app/data/database/tables/statuses.dart';
import 'package:todos_app/data/database/tables/todos.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Todos, Priorities, Statuses, Executors],
  daos: [TodosDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'todos.db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
