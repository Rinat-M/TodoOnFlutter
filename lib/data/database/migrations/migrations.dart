import 'package:drift/drift.dart';
import 'package:todos_app/common/app_constants.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/common/logger.dart';

Future<void> runOnBeforeOpen(AppDatabase db, OpeningDetails details) async {
  logger.i('Migrations. runOnBeforeOpen');
  await db.customStatement('PRAGMA foreign_keys = ON');
}

Future<void> runOnCreate(AppDatabase db, Migrator m) async {
  logger.i('Migrations. runOnCreate');

  await m.createAll();

  await initializePriorities(db, m);

  await initializeStatuses(db, m);

  await initializeExecutorMe(db, m);
}

Future<void> initializePriorities(AppDatabase db, Migrator migrator) async {
  await db.batch((b) {
    b.insertAll(db.priorities, [
      PrioritiesCompanion.insert(name: 'Low', description: 'Низкий'),
      PrioritiesCompanion.insert(name: 'Medium', description: 'Средний'),
      PrioritiesCompanion.insert(name: 'High', description: 'Высокий'),
    ]);
  });
}

Future<void> initializeStatuses(AppDatabase db, Migrator migrator) async {
  await db.batch((b) {
    b.insertAll(db.statuses, [
      StatusesCompanion.insert(name: 'Assigned', description: 'Назначена'),
      StatusesCompanion.insert(name: 'InProcess', description: 'В процессе'),
      StatusesCompanion.insert(name: 'Completed', description: 'Выполнена'),
    ]);
  });
}

Future<void> initializeExecutorMe(AppDatabase db, Migrator migrator) async {
  await db
      .into(db.executors)
      .insert(ExecutorsCompanion(name: Value('Я'), phone: Value('')));
}

Future<void> runOnUpgrade(AppDatabase db, Migrator m, int from, int to) async {
  if (from < 2) {
    logger.i("Migration from $from to $to of the schema is in progress");

    await m.alterTable(
      TableMigration(
        db.todos,
        columnTransformer: {db.todos.author: Constant(currentUserId)},
        newColumns: [db.todos.author],
      ),
    );

    logger.i("Migration from $from to $to of the schema is complete");
  }
}
