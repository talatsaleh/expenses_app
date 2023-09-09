import 'package:expenses_app/module/expenses_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpenses});

  final void Function(Expenses) addNewExpenses;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime? _dateTime;
  DateTime now = DateTime.now();

  String returnDateOrText() {
    if (_dateTime == null) {
      return 'Select Date';
    } else {
      return formatterDate.format(_dateTime!);
    }
  }

  void _submittedData() {
    final isDataValid =
        double.tryParse(_amountController.text) == null || _dateTime == null;
    if (_titleController.text.trim().isEmpty ||
        isDataValid ||
        _selectCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text(
              'You have entered Invalid title, amount, date or category..'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Ok'))
          ],
        ),
      );
      return;
    }
    widget.addNewExpenses(Expenses(
        title: _titleController.text,
        amount: double.tryParse(_amountController.text)!,
        category: _selectCategory!,
        date: _dateTime!));
    Navigator.of(context).pop();
  }

  void _showDataPicker() {
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    ).then((datePicked) {
      setState(() {
        _dateTime = datePicked;
        now = _dateTime ?? DateTime.now();
      });
    });
  }

  Category? _selectCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 50,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  controller: _titleController,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButton(
                    hint: const Text(
                      'Category',
                    ),
                    value: _selectCategory,
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      );
                    }).toList(),
                    onChanged: (selected) {
                      if (selected == null) {
                        return;
                      }
                      setState(() {
                        _selectCategory = selected;
                      });
                    }),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    suffixText: 'E£',
                  ),
                  controller: _amountController,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextButton.icon(
                icon: Icon(Icons.date_range),
                label: Text(returnDateOrText()),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: _showDataPicker,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submittedData,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
