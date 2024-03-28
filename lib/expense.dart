import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'Flutter Course',
        amount: 19.90,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 12.56,
        date: DateTime.now(),
        category: Category.travel)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 80, 6),
        title: const Text(
          'Expenses Tracker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpenseList(expenses: _registeredExpense))
        ],
      ),
    );
  }
}
