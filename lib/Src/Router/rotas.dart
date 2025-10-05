import 'package:app_academia/Src/Home/home_screen.dart';
import 'package:app_academia/Src/Treinos/treinoPage.dart';
import 'package:app_academia/Src/componets/bottom_navBar.dart';
import 'package:app_academia/Src/dashboard/perfil_board.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainNavigation()),
    GoRoute(path: 'treinos', builder: (context, state) => const TreinoPage()),
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(path: '/detail', builder: (context, state) => TreinoDetalhePage()),
    GoRoute(path: '/back', builder: (context, state) => const DashboardPage()),
  ],
);
