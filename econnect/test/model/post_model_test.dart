import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/model/post.dart';

void main() {
  group('Post', () {
    test('Constructor initializes Post fields correctly', () {
      final post = Post(
        user: 'John Doe',
        image: 'https://example.com/image.jpg',
        description: 'This is a test description.',
        postDatetime: DateTime.now(),
        postId: '',
      );

      expect(post.user, 'John Doe');
      expect(post.image, 'https://example.com/image.jpg');
      expect(post.description, 'This is a test description.');
      expect(post.postDatetime, isA<DateTime>());
      expect(post.postId, '');
    });
  });
}
