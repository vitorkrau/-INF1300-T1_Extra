import 'package:flutter/material.dart';
import '../Model/user.dart';

// Widget create to handle a new user
class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  String name;
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text(
          "Add User",
          style: TextStyle(color: Colors.black),
        ),
        leadingWidth: 70,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              "Confirm",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                child: buildForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Build the form to get user info input. It uses a special way to handle the date picker to disable the keyboard.
  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (val) => name = val,
            decoration: InputDecoration(
              labelText: 'Name',
              icon: Icon(Icons.account_circle),
            ),
            validator: _validateName,
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                onSaved: (val) {
                  selectedDate = selectedDate;
                },
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "Birth Date",
                  icon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value.isEmpty) return "Please enter your birth date";
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Perform a validations of input fields before adding to the users list
  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(
        context,
        User(name: name, birthDate: selectedDate),
      );
    }
  }

  //Validate's the user's name
  String _validateName(value) {
    //Regex pattern to check if there is a number between the letters
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Please enter a valid name";
    } else if (!regExp.hasMatch(value)) {
      return "Your name must contain only alphabetic characters";
    }

    return null;
  }

  //Handle date picker
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }
}
