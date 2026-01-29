import 'package:drift/drift.dart';

@DataClassName("Status")
class Statuses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
}
