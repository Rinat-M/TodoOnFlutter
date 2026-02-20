// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:todos_app/ui/screens/create_executor_screen.dart' as _i1;
import 'package:todos_app/ui/screens/create_todo_screen.dart' as _i2;
import 'package:todos_app/ui/screens/edit_todo_screen.dart' as _i3;
import 'package:todos_app/ui/screens/executors_screen.dart' as _i4;
import 'package:todos_app/ui/screens/main_screen.dart' as _i5;

/// generated route for
/// [_i1.CreateExecutorScreen]
class CreateExecutorRoute extends _i6.PageRouteInfo<void> {
  const CreateExecutorRoute({List<_i6.PageRouteInfo>? children})
    : super(CreateExecutorRoute.name, initialChildren: children);

  static const String name = 'CreateExecutorRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreateExecutorScreen();
    },
  );
}

/// generated route for
/// [_i2.CreateTodoScreen]
class CreateTodoRoute extends _i6.PageRouteInfo<void> {
  const CreateTodoRoute({List<_i6.PageRouteInfo>? children})
    : super(CreateTodoRoute.name, initialChildren: children);

  static const String name = 'CreateTodoRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.CreateTodoScreen();
    },
  );
}

/// generated route for
/// [_i3.EditTodoScreen]
class EditTodoRoute extends _i6.PageRouteInfo<EditTodoRouteArgs> {
  EditTodoRoute({
    _i7.Key? key,
    required int todoId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         EditTodoRoute.name,
         args: EditTodoRouteArgs(key: key, todoId: todoId),
         rawPathParams: {'id': todoId},
         initialChildren: children,
       );

  static const String name = 'EditTodoRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EditTodoRouteArgs>(
        orElse: () => EditTodoRouteArgs(todoId: pathParams.getInt('id')),
      );
      return _i3.EditTodoScreen(key: args.key, todoId: args.todoId);
    },
  );
}

class EditTodoRouteArgs {
  const EditTodoRouteArgs({this.key, required this.todoId});

  final _i7.Key? key;

  final int todoId;

  @override
  String toString() {
    return 'EditTodoRouteArgs{key: $key, todoId: $todoId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditTodoRouteArgs) return false;
    return key == other.key && todoId == other.todoId;
  }

  @override
  int get hashCode => key.hashCode ^ todoId.hashCode;
}

/// generated route for
/// [_i4.ExecutorsScreen]
class ExecutorsRoute extends _i6.PageRouteInfo<void> {
  const ExecutorsRoute({List<_i6.PageRouteInfo>? children})
    : super(ExecutorsRoute.name, initialChildren: children);

  static const String name = 'ExecutorsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.ExecutorsScreen();
    },
  );
}

/// generated route for
/// [_i5.MainScreen]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainScreen();
    },
  );
}
