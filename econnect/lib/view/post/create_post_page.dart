import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _postController = TextEditingController();
  final DatabaseController _dbController = DatabaseController(db: Database());
  PickedFile? _imageFile;
  
  Future<void> _takePicture(ImageSource source) async {
    if (!_picker.supportsImageSource(source)){
      return;
    }
    final file = await _picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _imageFile = file as PickedFile?;
      });
      final post = await _dbController.createPost("user", "title", file.path, "description");
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
          children: <Widget>[
            if (_imageFile != null)
              Image.network(_imageFile!.path),
            Row(
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
            TextField(
              controller: _postController,
              maxLines: null, 
              decoration: const InputDecoration(
                hintText: 'Write a caption here...',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String postText = _postController.text;
                Navigator.pop(context); 
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
