import 'package:expenses_app/module/expenses_module.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expenses});

  final Expenses expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenses.title,style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(expenses.amount.toStringAsFixed(2) + ' E£'),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenses.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(expenses.getFormattedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
