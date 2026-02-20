import 'package:auto_route/auto_route.dart';
import 'package:todos_app/ui/routes/app_router.gr.dart';
import 'package:todos_app/ui/routes/app_routes_enum.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: AppRoutesEnum.main.path, page: MainRoute.page),
    AutoRoute(path: AppRoutesEnum.createTodo.path, page: CreateTodoRoute.page),
    AutoRoute(
      path: "${AppRoutesEnum.editTodo.path}/:id",
      page: EditTodoRoute.page,
    ),
    AutoRoute(path: AppRoutesEnum.executors.path, page: ExecutorsRoute.page),
    AutoRoute(
      path: AppRoutesEnum.createExecutor.path,
      page: CreateExecutorRoute.page,
    ),
  ];
}
