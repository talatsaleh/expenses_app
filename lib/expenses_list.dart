import 'package:expenses_app/expenses_item.dart';
import 'package:flutter/material.dart';

import 'module/expenses_module.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.listItems,
    required this.onRemove,
  });

  final List<Expenses> listItems;
  final void Function(Expenses expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(listItems[index]),
        onDismissed: (direction) => onRemove(listItems[index]),
        child: ExpensesItem(
          expenses: listItems[index],
        ),
      ),
    );
  }
}
