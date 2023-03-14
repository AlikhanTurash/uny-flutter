import 'package:go_router/go_router.dart';

GoRoute unyRoute({required String name, GoRouterWidgetBuilder? builder}) =>
    GoRoute(name: name, path: '/$name', builder: builder);
