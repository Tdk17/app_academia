import 'package:go_router/go_router.dart';
import '../componets/bottom_navBar.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigation(),
    ),
  ],
);
