import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String name;
  final int amount;
  final String description;
  const BookDetailPage(this.name, this.amount, this.description, {Key? key})
      : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(name),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${amount}'),
            SizedBox(height: 8),
            Text('Description: ${description}'),
          ],
        ),
      ),
    );
  }
}
