import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_app/data/database/daos/todos_dao.dart';
import 'package:todos_app/data/database/migrations/migrations.dart';
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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) => runOnBeforeOpen(this, details),
    onCreate: (m) => runOnCreate(this, m),
    onUpgrade: (m, from, to) => runOnUpgrade(this, m, from, to),
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'todos_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
