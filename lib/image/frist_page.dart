// import 'dart:html';

// import 'dart:html';

// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<ImageData> imageList = [];

  // get http => null;

  Future<void> _captureImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageList.add(ImageData(
          imageFile: File(image.path),
          description: '',
        ));
      });
    }
  }

  Future<void> _selectImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageList.add(ImageData(
          imageFile: File(image.path),
          description: '',
        ));
      });
    }
  }

  Future<void> _fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.example.com/data'));
      if (response.statusCode == 200) {
        final dataList = response.body.split('\n');
        setState(() {
          imageList = dataList
              .map((data) => ImageData(
                    imageFile: null,
                    description: data,
                  ))
              .toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _showImagePickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Capture from Camera'),
              onTap: () {
                Navigator.pop(context);
                _captureImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _selectImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateDescription(int index, String description) {
    setState(() {
      imageList[index].description = description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                final imageData = imageList[index];
                return ListTile(
                  leading: imageData.imageFile != null
                      ? Image.file(imageData.imageFile!)
                      : Container(),
                  title: TextField(
                    onChanged: (value) => _updateDescription(index, value),
                    decoration: const InputDecoration(
                      labelText: 'Image Description',
                    ),
                  ),
                  subtitle: Text('Description: ${imageData.description}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _showImagePickerDialog(context),
            child: const Text('Pick Image'),
          ),
          ElevatedButton(
            onPressed: () => _fetchData(),
            child: const Text('Fetch Data'),
          ),
        ],
      ),
    );
  }
}

class ImageData {
  final File? imageFile;
  String description;

  ImageData({
    this.imageFile,
    required this.description,
  });
}
