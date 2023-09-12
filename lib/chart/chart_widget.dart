import 'package:expenses_app/chart/chart_bar.dart';
import 'package:flutter/material.dart';

import '../module/expenses_module.dart';

class Chart extends StatelessWidget {
   Chart({super.key, required this.expenses});

  final List<Expenses> expenses;

  List<ExpensesBucket> get buckets {
    return [
      ExpensesBucket.forCategory(expenses, Category.leisure),
      ExpensesBucket.forCategory(expenses, Category.transport),
      ExpensesBucket.forCategory(expenses, Category.food),
      ExpensesBucket.forCategory(expenses, Category.cloth),
    ];
  }

  double get maxTotal {
    double max = 0;
    for (final bucket in buckets) {
      if (bucket.totalSum > max) {
        max = bucket.totalSum;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                      fill: bucket.totalSum == 0
                          ? 0
                          : bucket.totalSum / maxTotal),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              ...buckets.map(
                (bucket) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Icon(
                      categoryIcons[bucket.category],
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
