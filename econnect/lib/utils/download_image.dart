import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

String downloadImageToTemp(String url) {
  final response = http.get(Uri.parse(url));

  final  =
      await rootBundle.load('assets/png/default_profile.png');
  final directory = getTemporaryDirectory();
  var pictureFile = File('${directory.path}/default_profile.png');
  pictureFile.writeAsBytesSync(pictureAsset.buffer.asUint8List());

}