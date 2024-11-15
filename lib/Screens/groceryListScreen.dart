import 'package:flutter/material.dart';
import 'package:groceries/Screens/addItemScreen.dart';
import 'package:groceries/Widgets/groceryList.dart';


class groceryListScreen extends StatefulWidget{
  groceryListScreen({super.key});

  @override
  State<groceryListScreen> createState() => _groceryListScreenState();
}

class _groceryListScreenState extends State<groceryListScreen> {


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