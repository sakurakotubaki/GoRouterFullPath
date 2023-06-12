import 'package:design_patterns/application/item_state.dart';
import 'package:design_patterns/presentation/router_path.dart';
import 'package:design_patterns/presentation/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final controllerProvider = StateProvider((ref) => TextEditingController());
final errorMessageProvider = StateProvider<String?>((ref) => null);

class ListItemPage extends ConsumerWidget {
  const ListItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(itemListProvider);
    final _controller = ref.watch(controllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(itemListProvider.notifier).addItem(_controller.text);
                  SnackBarUtil.show(context, 'Item added');
                },
                child: const Text('Add Item')),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
