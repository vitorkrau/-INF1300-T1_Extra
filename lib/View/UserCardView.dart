import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/user.dart';

// Widget created to build the cards with circle avatar, name and birth date
class UserCard extends StatelessWidget {
  final User user;

  UserCard({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Colors.grey[350],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(handleDateTime(user.birthDate))
            ],
          )
        ],
      ),
    );
  }

  // Format the birth date of the user. When the date is picked, it's come with an DateTime format and it needs to be formatted into a string
  String handleDateTime(DateTime birthDate) {
    return DateFormat('dd/MM/yyyy').format(birthDate);
  }
}
