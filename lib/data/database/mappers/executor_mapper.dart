import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/entites/executor_entity.dart';

extension ExecutorMapper on Executor {
  ExecutorEntity toDomain() => ExecutorEntity(id: id, name: name, phone: phone);
}
