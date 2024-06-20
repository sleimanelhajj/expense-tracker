import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // object optimized to let flutter store the entered value
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(
        _amountController.text); // metel ParseInt bil java la 7awelaa la double
    final bool amountIsValid = (enteredAmount == null || enteredAmount <= 0);
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return; // dayman after dialog
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    // allow me to close the dialog after i add
    Navigator.pop(context);
  }

// kermel ma khaliyon in memory lama sakir il text window bi hayde il tari2a li ana 3am a3mela 3am elo la flutter to flush kel shi bil controller
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

// hayde future object bta3tine il value i pick deghre, btekhod method .then where the function will be executed when we choose a date, aw async and await for future value
  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,55,16,16),
      child: Column(
        children: [
          TextField(
            // multiple fields need multiple controllers
            controller: _titleController,
            maxLength: 50,
            // choose which type of keyboard should pop up, defualt is the TextInputType
            keyboardType: TextInputType.text,
            // decoration la 7ot label
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    // adds a dolar sign to the field bil awal 
                    prefixText: '\$',
                    label: Text('Enter Desired Amount'),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ! after possible null value, heke bejbera tozbat
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                // value li bi bayin men bara, initially ana 7atayto leisure
                value: _selectedCategory,
                // .map to change them to another list type, w .name 3al enum to get the name of it, menerja3 toString, . values bta3tine list of the Category
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        // value il 7a yen3amal store when its pressed
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                // value down here huwe il value li fo2
                onChanged: (value) {
                  // ensure that the value is not null, if it is then just return and dont do anything
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              // input element for Text
              TextButton(
                onPressed: () {
                  // removes the overlay from the screen
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* 
String _enteredTitle = '';

void _savetitleInput(String inputValue) {
     _enteredTitle = inputValue; \
     } 

     hayde one way to store the String w b7ota bil onChanged bi aleb il textfiled widget bas fi another way

*/
