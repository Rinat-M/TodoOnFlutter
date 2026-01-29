import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/entites/priority_entity.dart';

extension PriorityMapper on Priority {
  PriorityEntity toDomain() =>
      PriorityEntity(id: id, description: description, name: name);
}
