import 'dart:async';
import 'dart:convert';
import 'package:groceries/data/categories.dart';
import 'package:http/http.dart' as http;
import 'package:groceries/models/groceryItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
final url = Uri.https('groceriesapp-d3ba9-default-rtdb.firebaseio.com', 'shopping-list.json');


class groceryListNotifier extends AsyncNotifier<List<GroceryItem>> {
  Future<List<GroceryItem>> build() async {
    return await loadData();
  }
  Future<void> postData({
    required String name,
    required String quantity,
    required String categoryTitle
}) async {
    http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'quantity': int.parse(quantity),
          'category': categoryTitle
        },));
  await loadData();}
  Future<List<GroceryItem>> loadData() async {
    List<GroceryItem> fetchedList = [];
    final response = await http.get(url);
    final Map<String, dynamic> loadedData = jsonDecode(response.body);
    for (final item in loadedData.entries){
      final itemCategory = categories.entries.firstWhere(
              (catItem) => catItem.value.title == item.value['category']).value;
      fetchedList.add(
          GroceryItem(id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: itemCategory));
    }
    state = AsyncData(fetchedList);
    return fetchedList;
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
