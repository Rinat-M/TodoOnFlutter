import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());
