import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

Future<String> downloadImageToTemp(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to download image');
  }

  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${const Uuid().v4()}.png');

  await file.writeAsBytes(response.bodyBytes);
  return file.path;
}
