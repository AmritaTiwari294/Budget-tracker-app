import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expense.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Function(Expense) addExpense;

  ExpenseDetailScreen(this.addExpense);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text.trim();
                final double amount = double.tryParse(amountController.text) ?? 0.0;
                final String category = categoryController.text.trim();
                if (name.isNotEmpty && amount > 0 && category.isNotEmpty) {
                  addExpense(Expense(name: name, amount: amount, category: category));
                  Navigator.pop(context);
                } else {
                  // Show error message or validation
                }
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
