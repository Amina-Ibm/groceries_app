import 'dart:async';
import 'package:groceries/models/groceryItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class groceryListNotifier extends AsyncNotifier<List<GroceryItem>> {
  Future<List<GroceryItem>> build() async {
    return [];
  }
  Future<void> additem(GroceryItem item) async{
    var updatedList = [...state.value!, item];
    state = AsyncData(updatedList);
  }
  Future<void> removeItem(GroceryItem item) async {
    var currentList = state.value;
    currentList!.remove(item);
    state = AsyncData(currentList);
  }
}
final groceryListProvider = AsyncNotifierProvider<groceryListNotifier, List<GroceryItem>>(
  groceryListNotifier.new,
);
