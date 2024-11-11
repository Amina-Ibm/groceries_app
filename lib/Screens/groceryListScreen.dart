import 'package:flutter/material.dart';
import 'package:groceries/Screens/addItemScreen.dart';
import 'package:groceries/Widgets/groceryList.dart';
import 'package:groceries/models/groceryItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries/providers/groceryListProvider.dart';


class groceryListScreen extends ConsumerStatefulWidget{
  groceryListScreen({super.key});

  @override
  ConsumerState<groceryListScreen> createState() => _groceryListScreenState();
}

class _groceryListScreenState extends ConsumerState<groceryListScreen> {


  void onAdd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>
        addItemScreen()));

  }

  Widget build (BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [
          IconButton(
              onPressed: onAdd,
              icon: Icon(Icons.add))
        ],
      ),
      body: groceryList(),
    );
  }
}