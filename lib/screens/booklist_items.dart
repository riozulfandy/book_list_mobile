import 'package:flutter/material.dart';
import 'package:book_list/widgets/left_drawer.dart';
import 'package:book_list/screens/booklist_form.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Item List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text(
                'Amount: ${items[index].amount}\nDescription: ${items[index].description}'),
            // Add an onTap handler if you want to do something when the user taps a product
            onTap: () {},
          );
        },
      ),
    );
  }
}
