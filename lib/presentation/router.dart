import 'package:design_patterns/domain/item_model.dart';
import 'package:design_patterns/presentation/router_path.dart';
import 'package:design_patterns/presentation/ui/detail.dart';
import 'package:design_patterns/presentation/ui/home.dart';
import 'package:design_patterns/presentation/ui/item_list.dart';
import 'package:design_patterns/presentation/ui/some_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// goRouterProviderは、GoRouterを提供するProviderです。
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: Routes.home, // pathは、GoRouterで使用するパスを定義します。
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: Routes.item,
        builder: (context, state) {
          return const ListItemPage();
        },
      ),
      // 次のページに遷移する際に、extraでItemクラスのnameプロパティを渡しています。
      GoRoute(
        path: Routes.detail,
        builder: (context, state) {
          final item = state.extra as Item?;
          // nullチェックを行います。
          if (item != null) {
            // extraで渡されたItemクラスのnameプロパティを表示するぺージに遷移します。
            return DetailPage(item: item);
          } else {
            // エラーが発生した場合は、SomeErrorPageに遷移します。
            return const SomeErrorPage(); // 適切なエラーページに差し替えてください
          }
        },
      ),
    ],
  );
});
