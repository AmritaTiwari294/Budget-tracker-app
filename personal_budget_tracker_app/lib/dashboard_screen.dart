import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'expense.dart';
import 'expense_detail_screen.dart';
import 'expense_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedExpenses = prefs.getString('expenses');
    if (storedExpenses != null) {
      setState(() {
        expenses = (jsonDecode(storedExpenses) as List)
            .map((e) => Expense.fromJson(e))
            .toList();
      });
    } else {
      final String initialData =
      await rootBundle.loadString('assets/initial_expenses.json');
      setState(() {
        expenses = (jsonDecode(initialData) as List)
            .map((e) => Expense.fromJson(e))
            .toList();
      });
      saveExpenses();
    }
  }

  Future<void> saveExpenses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('expenses', jsonEncode(expenses));
  }

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
    saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense.name),
            subtitle: Text('Category: ${expense.category}, Amount: \$${expense.amount.toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExpenseDetailScreen(addExpense)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}