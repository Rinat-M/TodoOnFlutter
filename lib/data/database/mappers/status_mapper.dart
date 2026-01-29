import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/entites/status_entity.dart';

extension StatusMapper on Status {
  StatusEntity toDomain() =>
      StatusEntity(id: id, description: description, name: name);
}
