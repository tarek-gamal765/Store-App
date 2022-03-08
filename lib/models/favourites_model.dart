import 'package:flutter/material.dart';

class FavouritesModel with ChangeNotifier{
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  FavouritesModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}
