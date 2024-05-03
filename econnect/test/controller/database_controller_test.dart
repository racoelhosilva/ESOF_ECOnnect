import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'database_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Database>()])
void main() {
  late DatabaseController databaseController;
  late MockDatabase database;

  setUp(() {
    database = MockDatabase();
    databaseController = DatabaseController(db: database);
  });

  testWidgets('User is created in the database', (tester) async {
    const testMockStorage = '/tmp';
    const channel = MethodChannel(
      'plugins.flutter.io/path_provider',
    );
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (MethodCall methodCall) async {
      return testMockStorage;
    });

    const id = '123';
    const email = 'test@example.com';
    const username = 'testuser';

    final user = await databaseController.createUser(id, email, username);

    expect(user, isNotNull);
    expect(user!.id, id);
    expect(user.email, email);
    expect(user.username, username);
    verify(database.addUser(user));
  });

  test('User is retrieved properly', () async {
    const id = '123';
    final user = User(
        id: id,
        email: 'test@example.com',
        username: 'testuser',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '');

    when(database.getUser('123')).thenAnswer((_) => Future(() => user));

    final retrievedUser = await databaseController.getUser(id);
    expect(retrievedUser, user);
  });

  test('User is updated properly', () async {
    const id = '123';
    const email = 'test@example.com';
    const username = 'testuser';
    const description = 'Updated description';
    const imgPath = '/path/to/image.png';
    const imgUrl = 'https://example.com/image.png';

    final updatedUser = User(
      id: id,
      email: email,
      username: username,
      description: description,
      profilePicture: imgPath,
      score: 10,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
    );

    when(database.updateUser(any)).thenAnswer((_) async {});
    when(database.storeImage(imgPath)).thenAnswer((_) async => 'img/imageId');
    when(database.retrieveFileUrl('img/imageId'))
        .thenAnswer((_) async => imgUrl);

    final result = await databaseController.updateUser(updatedUser, imgPath);

    expect(result, isNotNull);
    expect(result!.id, updatedUser.id);
    expect(result.email, updatedUser.email);
    expect(result.username, updatedUser.username);
    expect(result.description, updatedUser.description);
    expect(result.score, updatedUser.score);
    expect(result.isBlocked, updatedUser.isBlocked);
    expect(result.registerDatetime, updatedUser.registerDatetime);
    expect(result.admin, updatedUser.admin);
    expect(result.profilePicture, imgUrl);

    verify(database.updateUser(result)).called(1);
  });

  test('User can follow another user', () async {
    const followerId = 'followerId';
    const followedId = 'followedId';

    await databaseController.addFollow(followerId, followedId);

    verify(database.addFollow(followerId, followedId)).called(1);
  });

  test('User can unfollow another user', () async {
    const followerId = 'followerId';
    const followedId = 'followedId';

    await databaseController.removeFollow(followerId, followedId);

    verify(database.removeFollow(followerId, followedId)).called(1);
  });

  test('User can get the users they follow', () async {
    const userId = 'userId';
    const followedId1 = 'followedId1';
    const followedId2 = 'followedId2';

    when(database.getFollowing(userId))
        .thenAnswer((_) async => [followedId1, followedId2]);

    final following = await databaseController.getFollowing(userId);

    expect(following, [followedId1, followedId2]);
  });

  test('User has no followers', () async {
    const userId = 'userId';

    when(database.getFollowing(userId)).thenAnswer((_) async => []);

    final following = await databaseController.getFollowing(userId);

    expect(following, isEmpty);
  });

  test('User can check if they are following another user', () async {
    const followerId = 'followerId';
    const followedId = 'followedId';

    when(database.isFollowing(followerId, followedId))
        .thenAnswer((_) async => true);

    final isFollowing =
        await databaseController.isFollowing(followerId, followedId);

    expect(isFollowing, true);
  });

  test('Get next posts', () async {
    const cursor = 'cursor';
    const numDocs = 10;
    final expectedPosts = [
      Post(
          user: 'user1',
          description: 'Description 1',
          image: 'www.img1.com',
          postDatetime: DateTime.now(),
          postId: ''),
      Post(
          user: 'user1',
          description: 'Description 2',
          image: 'www.img2.com',
          postDatetime: DateTime.now(),
          postId: '')
    ];
    const expectedCursor = 'nextCursor';

    when(database.getNextPosts(cursor, numDocs))
        .thenAnswer((_) async => (expectedPosts, expectedCursor));

    final result = await databaseController.getNextPosts(cursor, numDocs);

    expect(result.$1.length, expectedPosts.length);
    expect(result.$1[0].user, expectedPosts[0].user);
    expect(result.$1[0].description, expectedPosts[0].description);
    expect(result.$1[0].image, expectedPosts[0].image);
    expect(result.$1[0].postDatetime, expectedPosts[0].postDatetime);
    expect(result.$1[1].user, expectedPosts[1].user);
    expect(result.$1[1].description, expectedPosts[1].description);
    expect(result.$1[1].image, expectedPosts[1].image);
    expect(result.$1[1].postDatetime, expectedPosts[1].postDatetime);
    expect(result.$2, expectedCursor);
  });

  test('Get next posts of following', () async {
    const cursor = 'cursor';
    const numDocs = 10;
    const userId = 'userId';
    final expectedPosts = [
      Post(
          user: 'user1',
          description: 'Description 1',
          image: 'www.img1.com',
          postDatetime: DateTime.now(),
          postId: ''),
      Post(
          user: 'user1',
          description: 'Description 2',
          image: 'www.img2.com',
          postDatetime: DateTime.now(),
          postId: '')
    ];
    const expectedCursor = 'nextCursor';

    when(database.getNextPostsOfFollowing(cursor, numDocs, userId))
        .thenAnswer((_) async => (expectedPosts, expectedCursor));

    final result = await databaseController.getNextPostsOfFollowing(
        cursor, numDocs, userId);

    expect(result.$1.length, expectedPosts.length);
    expect(result.$1[0].user, expectedPosts[0].user);
    expect(result.$1[0].description, expectedPosts[0].description);
    expect(result.$1[0].image, expectedPosts[0].image);
    expect(result.$1[0].postDatetime, expectedPosts[0].postDatetime);
    expect(result.$1[1].user, expectedPosts[1].user);
    expect(result.$1[1].description, expectedPosts[1].description);
    expect(result.$1[1].image, expectedPosts[1].image);
    expect(result.$1[1].postDatetime, expectedPosts[1].postDatetime);
    expect(result.$2, expectedCursor);
  });

  test('Get next posts of non-following', () async {
    const cursor = 'cursor';
    const numDocs = 10;
    const userId = 'userId';
    final expectedPosts = [
      Post(
          user: 'user1',
          description: 'Description 1',
          image: 'www.img1.com',
          postDatetime: DateTime.now(),
          postId: ''),
      Post(
          user: 'user1',
          description: 'Description 2',
          image: 'www.img2.com',
          postDatetime: DateTime.now(),
          postId: '')
    ];
    const expectedCursor = 'nextCursor';

    when(database.getNextPostsOfNonFollowing(cursor, numDocs, userId))
        .thenAnswer((_) async => (expectedPosts, expectedCursor));

    final result = await databaseController.getNextPostsOfNonFollowing(
        cursor, numDocs, userId);

    expect(result.$1.length, expectedPosts.length);
    expect(result.$1[0].user, expectedPosts[0].user);
    expect(result.$1[0].description, expectedPosts[0].description);
    expect(result.$1[0].image, expectedPosts[0].image);
    expect(result.$1[0].postDatetime, expectedPosts[0].postDatetime);
    expect(result.$1[1].user, expectedPosts[1].user);
    expect(result.$1[1].description, expectedPosts[1].description);
    expect(result.$1[1].image, expectedPosts[1].image);
    expect(result.$1[1].postDatetime, expectedPosts[1].postDatetime);
    expect(result.$2, expectedCursor);
  });

  test('Get posts from user', () async {
    const userId = 'userId';
    final expectedPosts = [
      Post(
          user: 'user1',
          description: 'Description 1',
          image: 'www.img1.com',
          postDatetime: DateTime.now(),
          postId: ''),
      Post(
          user: 'user1',
          description: 'Description 2',
          image: 'www.img2.com',
          postDatetime: DateTime.now(),
          postId: '')
    ];

    when(database.getPostsFromUser(userId))
        .thenAnswer((_) async => expectedPosts);

    final result = await databaseController.getPostsFromUser(userId);

    expect(result.length, expectedPosts.length);
    expect(result[0].user, expectedPosts[0].user);
    expect(result[0].description, expectedPosts[0].description);
    expect(result[0].image, expectedPosts[0].image);
    expect(result[0].postDatetime, expectedPosts[0].postDatetime);
    expect(result[1].user, expectedPosts[1].user);
    expect(result[1].description, expectedPosts[1].description);
    expect(result[1].image, expectedPosts[1].image);
    expect(result[1].postDatetime, expectedPosts[1].postDatetime);
  });
}
