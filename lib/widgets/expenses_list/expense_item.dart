import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ), // toStringAsFixed, 12.2422 => 12.24 display only 2 decimal digits
                const Spacer(), // will take the remaining space
                // hone 3melt Row tenye la2an i want to group 2 thigns sawa
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category]),
                    const SizedBox(height: 8),
                    Text(expense.formatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ); // styling purposes, it will put it in Container and style it
  }
}
