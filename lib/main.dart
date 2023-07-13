import 'package:dead_code/imagedetailspage.dart';
import 'package:dead_code/list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adding and searching images'),
          actions: [
            IconButton(
              onPressed: () {
                _pickImage(context, ImageSource.gallery);
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                _pickImage(context, ImageSource.camera);
              },
              icon: const Icon(Icons.add_a_photo),
            ),
          ],
        ),
        body: GridView.builder(
          itemCount: imageData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(0.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageDetailsPage(imageData: imageData[index]),
                  ),
                );
              },
              child: Container(
                color: Colors.black,
                child: Image.asset(
                  imageData[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _pickImage(BuildContext context, ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    final description = await showDialog(
      context: context,
      builder: (context) => _DescriptionDialog(),
    );

    if (description != null) {
      final date = DateTime.now(); //? Current date and time

      //! Perform action with the picked image, description, and date
      //! You can save the image, description, and date to a database or perform any other desired operation
    }
  }
}

class _DescriptionDialog extends StatefulWidget {
  @override
  _DescriptionDialogState createState() => _DescriptionDialogState();
}

class _DescriptionDialogState extends State<_DescriptionDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Description'),
      content: TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          hintText: 'Enter description',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context,
                null); // Return null if the description is not provided
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final description = _textEditingController.text;
            Navigator.pop(
                context, description); // Return the entered description
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
