import 'package:drift/drift.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/entites/executor_entity.dart';

extension ExecutorMapper on Executor {
  ExecutorEntity toDomain() => ExecutorEntity(id: id, name: name, phone: phone);
}

extension ExecutorDomainMapper on ExecutorEntity {
  Executor toDb() => Executor(id: id, name: name, phone: phone);

  ExecutorsCompanion toDbCompanion() =>
      ExecutorsCompanion(name: Value(name), phone: Value(phone));
}
