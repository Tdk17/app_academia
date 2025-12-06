import 'package:app_academia/Src/Home/home_screen.dart';
import 'package:app_academia/Src/Menu/menu_pages.dart';
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
    GoRoute(path: '/menu', builder: (context, state) => const MenuPages()),

    GoRoute(path: '/treino1', builder: (context, state) => const Treino1Page()),
    GoRoute(path: '/treino2', builder: (context, state) => const Treino2Page()),
    GoRoute(path: '/treino3', builder: (context, state) => const Treino3Page()),
    GoRoute(path: '/treino4', builder: (context, state) => const Treino4Page()),
    GoRoute(path: '/treino5', builder: (context, state) => const Treino5Page()),
  ],
);
