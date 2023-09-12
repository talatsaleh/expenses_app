
import 'package:expenses_app/chart/chart_widget.dart';
import 'package:expenses_app/expenses_list.dart';
import 'package:expenses_app/module/expenses_module.dart';
import 'package:expenses_app/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expenses> _expenses = [
    Expenses(
        title: 'Taxi to work',
        amount: 15,
        category: Category.transport,
        date: DateTime.now()),
    Expenses(
        title: 'Breakfast',
        amount: 20,
        category: Category.food,
        date: DateTime.now()),
    Expenses(
        title: 'Biscuits to eat',
        amount: 12,
        category: Category.leisure,
        date: DateTime.now()),
    Expenses(
        title: 'some socks',
        amount: 15,
        category: Category.cloth,
        date: DateTime.now()),
    Expenses(
        title: 'Transport to home',
        amount: 15,
        category: Category.transport,
        date: DateTime.now()),
  ];

  void _addNewExpenses(Expenses expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expenses expense) {
    final index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('get it back?'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void _addExpensesPage() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            addNewExpenses: _addNewExpenses,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('There is no Expenses '),
    );
    if (_expenses.isNotEmpty) {
      mainContent =
          ExpensesList(listItems: _expenses, onRemove: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _addExpensesPage,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Chart(expenses: _expenses),
          ),
          Expanded(
            flex: 3,
            child: mainContent,
          )
        ],
      ),
    );
  }
}
