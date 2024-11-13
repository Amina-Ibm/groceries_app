import 'package:flutter/material.dart';
import 'package:groceries/data/categories.dart';
import 'package:groceries/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries/providers/groceryListProvider.dart';

class addItemScreen extends ConsumerStatefulWidget{
  addItemScreen({super.key});
  @override
  ConsumerState<addItemScreen> createState() {
    return _addIemScreenState();
  }
}
class _addIemScreenState extends ConsumerState<addItemScreen>{
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  var _selectedCategory = categories[Categories.carbs];
  final _formkey = GlobalKey<FormState>();
  final url = Uri.https('groceriesapp-d3ba9-default-rtdb.firebaseio.com', 'shopping-list.json');
  @override
  Widget build(BuildContext context) {
    final groceryProvider = ref.watch(groceryListProvider.notifier);
    @override
    void dispose(){
      nameController.dispose();
      quantityController.dispose();
      super.dispose();
    }


    void addItem(){
      if(_formkey.currentState!.validate()){
        groceryProvider.postData(name: nameController.text,
            quantity: quantityController.text,
            categoryTitle: _selectedCategory!.title);

        Navigator.of(context).pop();
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
      child: Form(
        key: _formkey,
          child: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: nameController,
                maxLength: 50,
                decoration: InputDecoration(
                    label: Text('Name')
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <2){
                    return 'Name should have length greater than 2';
                  }
                  return null;
                },
              )),],),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: quantityController,
                decoration: InputDecoration(
                    label: Text('Quantity')
                ),
                    validator: (value){
                      if (value == null || value.isEmpty
                          || int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0){
                        return 'quantity should be a valid, positive number';
                      }
                      return null;
                    },
                  )
              ),
              SizedBox(width: 20,),
              Expanded(child: DropdownButtonFormField(
                  items: categories.entries.map(
                          (category) {
                        return DropdownMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.square,
                                  color: category.value.color,),
                                Text(category.value.title)
                              ],
                            ),
                            value: category.value
                        );
                      }).toList()
                  , onChanged:(value) {
                    _selectedCategory = value;
              }))
            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){ _formkey.currentState!.reset(); }, child: Text('Reset')),
              ElevatedButton(onPressed: addItem, child: Text('Add Item'))
            ],)],
      )),),
    );}}