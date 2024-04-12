import 'dart:io';
import 'dart:typed_data';

import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/view/post/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _postController = TextEditingController();
  final DatabaseController _dbController = DatabaseController(db: Database());
  File? _imageFile;

  int? _imageWidth;
  int? _imageHeight;

  void _getImageDimensions() async {
    final Uint8List bytes = await _imageFile!.readAsBytes();
    final image = await decodeImageFromList(bytes);
    setState(() {
      _imageWidth = image.width;
      _imageHeight = image.height;
    });
  }

  Future<void> _takePicture(ImageSource source) async {
    if (!_picker.supportsImageSource(source)) {
      return;
    }
    final file = await _picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _imageFile = File(file.path);
      });
      _getImageDimensions();
    }
  }

  Future<void> _post() async {
    if (_imageFile != null) {
      final post = await _dbController.createPost("user", "title", _imageFile!.path, _postController.text);
      if (post != null) {
        Navigator.pop(context);
      } else {
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select an image before posting.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: _imageWidth?.toDouble(),
                    height: _imageHeight?.toDouble(),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _imageFile != null
                        ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(_imageFile!, fit: BoxFit.cover),
                          )
                        : Center(child: Text('No image selected')),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () => _takePicture(ImageSource.camera),
                          tooltip: 'Pick Image from camera',
                          child: const Icon(Icons.add_a_photo),
                        ),
                        const SizedBox(width: 10),
                        FloatingActionButton(
                          onPressed: () => _takePicture(ImageSource.gallery),
                          tooltip: 'Pick Image from gallery',
                          child: const Icon(Icons.photo_library),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            DescriptionWidget(controller: _postController),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _post,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
