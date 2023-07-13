import 'package:flutter/cupertino.dart';

class ImageData {
  final String imageUrl;
  final String description;
  final IconData icon;
  final VoidCallback? onPressed;
  final String date;

  ImageData({
    required this.imageUrl,
    required this.description,
    required this.icon,
    required this.onPressed,
    required this.date,
  });
}
