import 'package:flutter/material.dart';

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
