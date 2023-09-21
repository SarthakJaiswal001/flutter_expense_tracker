import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onaddExpense});
  final void Function(Expense expense)
      onaddExpense; //this is the function addExpenses from expenses.dart file which adds the passed argument expense into _registeredExpenses list

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // String _enteredTitle = '';
  // void _saveEnteredValue(String inputValue) {
  //   _enteredTitle =
  //       inputValue; //this function is created in order to save the value of the entered title
  // }
  final _titleController =
      TextEditingController(); //this simply makes the task of saving the title received using controller in text-field easier
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  Category _selectedCategory =
      Category.travel; //initialized the selected category

  void _presentDatePicker() async {
    //this async function is called when calendar icon is pressed and  saving the present date and showing a calendar when the calendar icon is pressed
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    DateTime? datepicked = await showDatePicker(
        //this is widget which opens calendar
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate =
          datepicked; //this will change value of the selectedDate whenever new date is picked
    });
  }

  void submitData() {
    //this function will simply show error if any of the given field is not entered or filled
    final enteredAmount = double.tryParse(_amountController.text); //tryParse('hello)=null, tryParse('1.21')=1.21
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text == null ||amountIsValid ||selectedDate == null) {
      showDialog(//this will show dialog box if any of the details is not filled
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Fill Proper Input'),
              content: const Text(
                  'Please make sure you have entered Date, amount, title, category corrctly'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          });
      return;
    }
    widget.onaddExpense(Expense(
        //here we are passing the new expense item to be added in _registeredExpense
        date: selectedDate!,
        spendedAmount: enteredAmount,
        title: _titleController.text,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //this will dispose the previous value once its work is done
    // TODO: implement dispose
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            // onChanged:
            //     _saveEnteredValue, //this take function as an argument , a function which take input string as argument
            controller: _titleController,
            //controller saves the input provided by user in _titleController
            maxLength: 30,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              child: Row(
            children: [
              SizedBox(
                height: 45,
                width: 200,
                child: TextField(
                  // onChanged:
                  //     _saveEnteredValue, //this take function as an argument , a function which take input string as argument
                  controller: _amountController,

                  keyboardType: TextInputType.number,
                  //controller saves the input provided by user in _amountController
                  maxLength: 50,

                  decoration: const InputDecoration(
                    
                      label: Text('Amount Spended',textAlign: TextAlign.end,),
                      prefixText: '\$  ' //this will add prefix as dollar sign
                      ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(selectedDate == null
                      ? 'Date Not Selected'
                      : formatter.format(selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          )),
          const SizedBox(height: 15,),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category
                      .values //doopdown controller does not support controller which store the selected value
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    submitData();
                  },
                  child: const Text('Save Value')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
