import 'package:logger/logger.dart';

Logger get logger => _instance;

final Logger _instance = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // последние 2 метода в стеке
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
