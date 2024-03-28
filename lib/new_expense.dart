import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;

    final pcikedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pcikedDate;
    });
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      // Error handling
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('အချက်အလက်များ ဖြည့်သွင်းပါ'),
                content: const Text(
                    'အသစ်အကြောင်းအရာ, ပမာဏ, နေ့စွဲ နှင့် အမျိုးအစားရွေးပါ'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('အိုကေ'),
                  ),
                ],
              ));
      return;
    }

    widget.onAddExpense(Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!));

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Center(child: Text('အသုံးစရိတ် အသစ်ထည့်ပါ')),
          const SizedBox(
            height: 16,
          ),
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('အကြောင်းအရာ'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // onChanged: _saveTitleInput,
                  controller: _amountController,
                  maxLength: 50,

                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('ပမာဏ'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_today),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) return;
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('သိမ်းမည်'),
              )
            ],
          )
        ],
      ),
    );
  }
}
