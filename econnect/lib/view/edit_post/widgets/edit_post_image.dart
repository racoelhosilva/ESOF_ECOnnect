import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditPostImage extends StatelessWidget {
  const EditPostImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath == "") {
      return Container();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * (4 / 3),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
