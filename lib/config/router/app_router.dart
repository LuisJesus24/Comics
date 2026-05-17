import 'package:comics/presentation/screens/comic_screen.dart';
import 'package:comics/presentation/screens/favorites_screen.dart';
import 'package:comics/presentation/screens/home_screen.dart';
import 'package:comics/presentation/screens/search_screen.dart';
import 'package:comics/presentation/widgets/bottom_navigation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigationScreen(navigationShell: navigationShell);
      },

      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, __) => const HomeScreen(),

              routes: [
                GoRoute(
                  path: '/comics/:id',

                  builder: (context, state) {
                    final int id = int.parse(state.pathParameters['id']!);

                    return ComicScreen(comicId: id);
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (_, __) => const SearchScreen(),

              routes: [
                GoRoute(
                  path: '/comics/:id',

                  builder: (context, state) {
                    final int id = int.parse(state.pathParameters['id']!);

                    return ComicScreen(comicId: id);
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (_, __) => const FavoritesScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
