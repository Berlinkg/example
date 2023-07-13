import 'package:dead_code/class.dart';
import 'package:flutter/material.dart';

class ImageDetailsPage extends StatelessWidget {
  final ImageData imageData;

  const ImageDetailsPage({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imageData.imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    imageData.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${imageData.date}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: imageData.onPressed,
              child: Icon(
                imageData.icon,
                size: 48,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
