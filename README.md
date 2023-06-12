# GoRouter の画面遷移を使い分ける

context.push と context.go の違いについて比較してみた。

```dart
import 'package:design_patterns/presentation/router_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // pushは、現在のページをスタックに残したまま、新しいページをスタックに追加します。
                // ページ遷移のスタックとは、ページ遷移の履歴を保持するスタックのことです。
                context.push(Routes.item);
              },
              child: const Text('push'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // goは、現在のページをスタックから削除して、新しいページをスタックに追加します。
                // 新しいページのスタックとは、ページ遷移の履歴を保持するスタックのことです。
                // AppBarに戻るボタンが表示されないのは、スタックから削除されたためです。
                context.go(Routes.item);
              },
              child: const Text('go'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 次のページへ値を渡す
extra propertyを使用して、次のページへListで値を渡す。
Stringをそのまま渡す記事は見かけるが、Listを渡すのは、見かけないよう気がするので、やってみた。

https://pub.dev/documentation/go_router/latest/go_router/GoRouterState/extra.html

以下のように設定をする
```dart
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
```

ListTileでonTapする時に使うコードはこの様に書く
```dart
Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // pushの中に、extraとしてitemList[index]を渡す
                      context.push(Routes.detail, extra: itemList[index]);
                    },
                    title: Text(itemList[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref.read(itemListProvider.notifier).removeItem(index);
                        SnackBarUtil.show(context, 'Item removed');
                      },
                    ),
                  );
                },
              ),
            ),
```