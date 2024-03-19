import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  Future<void> _takePicture() async {
    if (!_picker.supportsImageSource(ImageSource.camera)) {
      return;
    }
    final file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        _images.add(File(file.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _images.map((e) => Image.file(e)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}