import 'package:flutter/material.dart';
import 'package:t1_extra/View/AddUserView.dart';
import 'UserCardView.dart';
import '../Model/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = [
    User(name: "Teste", birthDate: DateTime.now()),
  ];
  User newUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text(
          "Users",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, index) {
              return _buildDismissibleCard(context, index);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _awaitReturnValueFromForm(context, AddUser()),
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[600],
      ),
    );
  }

  // Wait for a new user to be back to add into the users list
  _awaitReturnValueFromForm(BuildContext context, Widget page) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        )) as User;
    if (result != null) {
      newUser = result;
      setState(() {
        users.add(newUser);
      });
    }
  }

  // Allows the user to swipe from left to right to delete any user
  Dismissible _buildDismissibleCard(context, index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        setState(() {
          users.removeAt(index);
        });
      },
      child: UserCard(user: users[index]),
      background: Card(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
