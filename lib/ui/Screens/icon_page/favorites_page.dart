import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Favorite Item 1'),
              subtitle: Text('Description of favorite item 1'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Favorite Item 2'),
              subtitle: Text('Description of favorite item 2'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          // Add more favorite items here
        ],
      ),
    );
  }
}
