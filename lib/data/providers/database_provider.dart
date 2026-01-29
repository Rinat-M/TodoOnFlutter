import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/utils/logger.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  logger.i('Init databaseProvider');
  return AppDatabase();
});
