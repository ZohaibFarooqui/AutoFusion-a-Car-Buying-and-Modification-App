import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<String> favorites;

  FavoritesScreen({required this.favorites});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: widget.favorites.isEmpty
          ? Center(
        child: Text('No favorites yet.'),
      )
          : ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.favorites[index]),
            // You can add more details or actions for each favorite car
          );
        },
      ),
    );
  }
}
