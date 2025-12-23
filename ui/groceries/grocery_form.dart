import 'package:flutter/material.dart';

import '../../models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // Default settings
  static const defautName = "";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    // Will be implemented later - Reset all fields to the initial values
    _nameController.text = defautName.trim();
    _quantityController.text = defaultQuantity.toString();
    _selectedCategory = defaultCategory;
  }

  void onAdd() {
    // Will be implemented later - Create and return the new grocery
    final quantity = int.parse(_quantityController.text);

    Grocery newGrocery = Grocery(
      id: '',
      name: _nameController.text.trim(),
      quantity: quantity,
      category: _selectedCategory,
    );

    Navigator.pop<Grocery>(context, newGrocery);
  }

  void _onCategoryChanged(value) {
    if (value != null) {
      setState(() {
        _selectedCategory = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(label: Text('Quantity')),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<GroceryCategory>(
                    initialValue: _selectedCategory,
                    items: GroceryCategory.values.map((GroceryCategory) {
                      return DropdownMenuItem(
                        value: GroceryCategory,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: GroceryCategory.color,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(GroceryCategory.label),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: _onCategoryChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onReset, child: const Text('Reset')),
                ElevatedButton(onPressed: onAdd, child: const Text('Add Item')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
