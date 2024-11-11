
import 'package:flutter/material.dart';
import 'package:groceries/data/dummy_items.dart';
import 'package:groceries/Screens/groceryListScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries/models/groceryItem.dart';
import 'package:groceries/providers/groceryListProvider.dart';

class groceryList extends ConsumerWidget{
  groceryList({super.key});

  Widget build(BuildContext context, WidgetRef ref){

    final updatedList = ref.watch(groceryListProvider);
    final listFunction = ref.watch(groceryListProvider.notifier);

    return updatedList.maybeWhen(
        data: (items) {
          if(items.isEmpty) {
            return Center(child: Text("No items added"));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {listFunction.removeItem(items[index]);},
                key: ValueKey(items[index].id),
                child: ListTile(
                  leading: Icon(Icons.square,
                    color: items[index].category.color,),
                  title: Text(items[index].name),
                  trailing: Text(items[index].quantity.toString()), // Assuming GroceryItem has a `name` field
                ),
              );
            },
          );
        }, orElse: () => Center(child: CircularProgressIndicator())
    );
  }
}
