import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/ui/routes/app_routes.dart';
import 'package:todos_app/ui/screens/main_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.main,
      routes: AppRoutes.routes,
      title: StringConstants.appTitle,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
      home: const MainScreen(title: StringConstants.appTitle),
    );
  }
}
