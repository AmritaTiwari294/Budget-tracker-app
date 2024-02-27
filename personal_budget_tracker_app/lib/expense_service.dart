
import 'dart:convert';

import 'expense.dart';



class ExpenseService {
  static const String _keyExpenses = 'expenses';

  static Future<List<Expense>> getExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(_keyExpenses);
    if (jsonData != null) {
      Iterable decoded = jsonDecode(jsonData);
      List<Expense> expenses = decoded.map((e) => Expense.fromJson(e)).toList();
      return expenses;
    }
    return [];
  }

  static Future<void> addExpense(Expense expense) async {
    List<Expense> expenses = await getExpenses();
    expenses.add(expense);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyExpenses, jsonEncode(expenses));
  }

  static Future<void> updateExpense(Expense expense) async {
    List<Expense> expenses = await getExpenses();
    int index = expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      expenses[index] = expense;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyExpenses, jsonEncode(expenses));
    }
  }
}

class SharedPreferences {
  static getInstance() {}

  String? getString(String keyExpenses) {
  }

  setString(String keyExpenses, String jsonEncode) {}
}

