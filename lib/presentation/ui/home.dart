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
