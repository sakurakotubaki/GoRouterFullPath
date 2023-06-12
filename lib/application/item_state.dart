import 'package:design_patterns/domain/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final errorMessageProvider = StateProvider<String?>((ref) => null);

final itemListProvider =
    NotifierProvider<ItemListNotifier, List<Item>>(ItemListNotifier.new);

class ItemListNotifier extends Notifier<List<Item>> {
  @override
  build() {
    return [];
  }

  void addItem(String name) {
    try {
      if (name.isEmpty) {
        ref.read(errorMessageProvider.notifier).state = 'nullはダメです!';
      }
      state = [...state, Item(name: name)];
    } catch (e) {
      throw (e.toString());
    }
  }

  void removeItem(int index) {
    state = [...state]..removeAt(index);
  }
}
