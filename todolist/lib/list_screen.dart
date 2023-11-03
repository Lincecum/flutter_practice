import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOdo List'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('title 1'),
            subtitle: Text('sub1'),
          ),
          ListTile(
            title: Text('title 2'),
            subtitle: Text('sub2'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
