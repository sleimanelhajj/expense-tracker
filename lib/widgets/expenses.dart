// import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // dynamically add a new UI element, to dispaly the window
    showModalBottomSheet(
      // takes full available height
      isScrollControlled: true,
      context: context,
      // builder, provide a function that returns a widget, context mnektreka
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final int expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // hayde la arje message when i remove an expense
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // time for it to stay
        duration: const Duration(
          seconds: 3,
        ),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo Removal',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses Found'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        onRemoveExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 132, 11, 2),
        title: const Text(
          "Flutter Expense Tracker",
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        // typically used to display the buttons
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Toolbar with the Add button => Row() its possible bas ma drure na3mela build, use Scaffold 3anda AppBar
          const Text('The chart'),
          Expanded(
            child: mainContent,
          ), // wrap with expanded la2an ka2an 7atit Column bi aleb Column so majbur 7ot Expanded
        ],
      ),
    );
  }
}

// defines a group of expenses
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

// this is how we add extra constructors
// filter out expenses that belong to a certain category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
