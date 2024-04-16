import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget(this._imagePath, {super.key, required this.setImagePath});

  String? _imagePath;
  final Function(String?) setImagePath;

  @override
  State<StatefulWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture(ImageSource source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        widget._imagePath = file.path;
      });
      widget.setImagePath(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * (4 / 3),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: widget._imagePath != null
              ? Image.file(
                  File(widget._imagePath!),
                  fit: BoxFit.cover,
                )
              : const Center(child: Text('No image selected')),
        ),
        Positioned(
          bottom: 24.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => _takePicture(ImageSource.gallery),
                tooltip: 'Pick Image from gallery',
                child: const Icon(LucideIcons.imagePlus),
              ),
              const SizedBox(width: 8.0),
              FloatingActionButton(
                onPressed: () => _takePicture(ImageSource.camera),
                tooltip: 'Pick Image from camera',
                child: const Icon(LucideIcons.aperture),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
