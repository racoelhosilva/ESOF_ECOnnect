import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff1e1e1e),
              Color(0x601e1e1e),
              Color(0x001e1e1e),
              Color(0x001e1e1e),
              Color(0x601e1e1e),
              Color(0xff1e1e1e),
            ],
            stops: [
              0.0,
              0.15,
              0.25,
              0.75,
              0.85,
              1.0
            ]),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
      ),
    );
  }
}
