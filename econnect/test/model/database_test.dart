import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'database_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<FirebaseStorage>(),
  MockSpec<Reference>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
])
void main() {
  late FirebaseFirestore firestore;
  late FirebaseStorage storage;
  late Reference storageRef;
  late Database database;
  late CollectionReference<Map<String, dynamic>> collectionReference;

  setUp(() {
    firestore = MockFirebaseFirestore();
    storage = MockFirebaseStorage();
    storageRef = MockReference();
    collectionReference = MockCollectionReference();

    when(storage.ref()).thenReturn(storageRef);

    database = Database(firestore, storage);
  });

  setUp(() {
    when(firestore.collection('users')).thenReturn(collectionReference);
  });

  test('User is created in the database if it does not exist', () async {
    final user = User(
        id: '123',
        email: 'example@example.com',
        username: 'example',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '');
    final documentReference = MockDocumentReference();
    final documentSnapshot = MockDocumentSnapshot();

    when(collectionReference.doc(user.id)).thenReturn(documentReference);
    when(documentReference.get())
        .thenAnswer((_) => Future(() => documentSnapshot));
    when(documentSnapshot.exists).thenReturn(false);

    await database.addUser(user);

    verify(documentReference.set(any, null));
  });

  test('User is not created in the database if it exists', () async {
    final user = User(
        id: '123',
        email: 'example@example.com',
        username: 'example',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '');
    final documentReference = MockDocumentReference();
    final documentSnapshot = MockDocumentSnapshot();

    when(collectionReference.doc(user.id)).thenReturn(documentReference);
    when(documentReference.get())
        .thenAnswer((_) => Future(() => documentSnapshot));
    when(documentSnapshot.exists).thenReturn(true);

    expect(() async => await database.addUser(user), throwsStateError);
  });

  test('User is retrieved with id if exists', () async {
    const id = '123';
    final documentReference = MockDocumentReference();
    final documentSnapshot = MockDocumentSnapshot();
    final userInfo = {
      'id': '123',
      'username': 'test',
      'email': 'test',
      'description': 'test',
      'profilePicture': 'test',
      'score': 0,
      'isBlocked': false,
      'registerDatetime':
          Timestamp.fromDate(DateTime.parse('1969-07-20 20:18:04Z')),
      'isAdmin': false,
    };

    when(collectionReference.doc(id)).thenReturn(documentReference);
    when(documentReference.get())
        .thenAnswer((_) => Future(() => documentSnapshot));
    when(documentSnapshot.exists).thenReturn(true);
    when(documentSnapshot[any])
        .thenAnswer((i) => userInfo[i.positionalArguments[0]]);

    final user = await database.getUser(id);

    expect(user, isNotNull);
    expect(user!.id, userInfo['id']);
    expect(user.username, userInfo['username']);
    expect(user.email, userInfo['email']);
    expect(user.description, userInfo['description']);
    expect(user.profilePicture, userInfo['profilePicture']);
    expect(user.score, userInfo['score']);
    expect(user.isBlocked, userInfo['isBlocked']);
    expect(user.registerDatetime,
        (userInfo['registerDatetime'] as Timestamp).toDate());
    expect(user.admin, userInfo['isAdmin']);
  });

  test('User is not retrieved if it does not exist', () async {
    const id = '123';
    final documentReference = MockDocumentReference();
    final documentSnapshot = MockDocumentSnapshot();

    when(collectionReference.doc(id)).thenReturn(documentReference);
    when(documentReference.get())
        .thenAnswer((_) => Future(() => documentSnapshot));
    when(documentSnapshot.exists).thenReturn(false);

    final user = await database.getUser(id);

    expect(user, isNull);
  });

  test('User is updated in the database correctly', () async {
    final user = User(
      id: '123',
      email: 'example@example.com',
      username: 'example',
      score: 0,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
      profilePicture: '',
    );

    final usersCollection = MockCollectionReference();
    final userDocument = MockDocumentReference();
    final documentSnapshot = MockDocumentSnapshot();

    when(firestore.collection('users')).thenReturn(usersCollection);
    when(usersCollection.doc(user.id)).thenReturn(userDocument);
    when(userDocument.get()).thenAnswer((_) async => documentSnapshot);
    when(documentSnapshot.exists).thenReturn(true);
    when(userDocument.update(any)).thenAnswer((_) async {});

    await database.updateUser(user);

    verify(userDocument.update(argThat(
      equals({
        'username': user.username,
        'email': user.email,
        'description': user.description,
        'profilePicture': user.profilePicture,
        'score': user.score,
        'isBlocked': user.isBlocked,
        'registerDatetime': user.registerDatetime,
        'isAdmin': user.admin,
      }),
    ))).called(1);
  });

  group('addFollow', () {
    test('Adds follow successfully', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      final followsDocument = MockDocumentReference();
      final followsCollection = MockCollectionReference();
      final query1 = MockQuery();
      final query2 = MockQuery();
      final querySnapshot = MockQuerySnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.where('followed', isEqualTo: userId2)).thenReturn(query2);
      when(query2.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([]);
      when(followsCollection.add(any)).thenAnswer((_) async => followsDocument);

      await database.addFollow(userId1, userId2);

      verify(followsCollection.add({
        'follower': userId1,
        'followed': userId2,
      })).called(1);
    });

    test('Throws StateError if follow already exists', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      final followsDocument = MockDocumentReference();
      final followsCollection = MockCollectionReference();
      final query1 = MockQuery();
      final query2 = MockQuery();
      final querySnapshot = MockQuerySnapshot();
      final queryDocymentSnapshot = MockQueryDocumentSnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.where('followed', isEqualTo: userId2)).thenReturn(query2);
      when(query2.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([queryDocymentSnapshot]);
      when(queryDocymentSnapshot['follower']).thenReturn(userId1);
      when(queryDocymentSnapshot['followed']).thenReturn(userId2);
      when(followsCollection.add(any)).thenAnswer((_) async => followsDocument);

      expect(() => database.addFollow(userId1, userId2), throwsStateError);
    });
  });

  group('removeFollow', () {
    test('Removes follow successfully', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      final followsDocument = MockDocumentReference();
      final followsCollection = MockCollectionReference();
      final query1 = MockQuery();
      final query2 = MockQuery();
      final querySnapshot = MockQuerySnapshot();
      final queryDocumentSnapshot = MockQueryDocumentSnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.where('followed', isEqualTo: userId2)).thenReturn(query2);
      when(query2.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([queryDocumentSnapshot]);
      when(queryDocumentSnapshot.reference).thenReturn(followsDocument);
      when(followsDocument.delete()).thenAnswer((_) async {});

      await database.removeFollow(userId1, userId2);

      verify(followsDocument.delete()).called(1);
    });

    test('Throws StateError if follow does not exist', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      final followsCollection = MockCollectionReference();
      final query1 = MockQuery();
      final query2 = MockQuery();
      final querySnapshot = MockQuerySnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.where('followed', isEqualTo: userId2)).thenReturn(query2);
      when(query2.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([]);

      expect(() => database.removeFollow(userId1, userId2), throwsStateError);
    });
  });

  group('getFollowing', () {
    test('Returns list of following users', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      const userId3 = 'user3';
      final followsCollection = MockCollectionReference();
      final querySnapshot = MockQuerySnapshot();
      final query1 = MockQuery();
      final queryDocumentSnapshot1 = MockQueryDocumentSnapshot();
      final queryDocumentSnapshot2 = MockQueryDocumentSnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs)
          .thenReturn([queryDocumentSnapshot1, queryDocumentSnapshot2]);
      when(queryDocumentSnapshot1['followed']).thenReturn(userId2);
      when(queryDocumentSnapshot2['followed']).thenReturn(userId3);

      final following = await database.getFollowing(userId1);

      expect(following, ['user2', 'user3']);
    });

    test('Returns empty list if there are no following users', () async {
      const userId1 = 'user1';
      final followsCollection = MockCollectionReference();
      final querySnapshot = MockQuerySnapshot();
      final query1 = MockQuery();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([]);

      final following = await database.getFollowing(userId1);

      expect(following, []);
    });
  });

  group('isFollowing', () {
    test('Returns true if user is following', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      final followsCollection = MockCollectionReference();
      final query1 = MockQuery();
      final query2 = MockQuery();
      final querySnapshot = MockQuerySnapshot();
      final queryDocumentSnapshot = MockQueryDocumentSnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.where('followed', isEqualTo: userId2)).thenReturn(query2);
      when(query2.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([queryDocumentSnapshot]);

      final isFollowing = await database.isFollowing(userId1, userId2);

      expect(isFollowing, true);
    });

    test('Returns false if user is not following', () async {
      const userId1 = 'user1';
      const userId2 = 'user2';
      final followsCollection = MockCollectionReference();
      final query1 = MockQuery();
      final query2 = MockQuery();
      final querySnapshot = MockQuerySnapshot();

      when(firestore.collection('follows')).thenReturn(followsCollection);
      when(followsCollection.where('follower', isEqualTo: userId1))
          .thenReturn(query1);
      when(query1.where('followed', isEqualTo: userId2)).thenReturn(query2);
      when(query2.get()).thenAnswer((_) async => querySnapshot);
      when(querySnapshot.docs).thenReturn([]);

      final isFollowing = await database.isFollowing(userId1, userId2);

      expect(isFollowing, false);
    });
  });

  test('Retrieves the posts correctly', () async {
    final postsCollection = MockCollectionReference();
    final postsQuery1 = MockQuery();
    final postsQuery2 = MockQuery();
    final queryDocumentSnapshot1 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot2 = MockQueryDocumentSnapshot();
    const documentId1 = 'doc1';
    const documentId2 = 'doc2';
    final querySnapshot = MockQuerySnapshot();

    when(firestore.collection('posts')).thenReturn(postsCollection);
    when(postsCollection.orderBy('postDatetime', descending: true))
        .thenReturn(postsQuery1);
    when(postsQuery1.limit(any)).thenReturn(postsQuery2);
    when(postsQuery2.get()).thenAnswer((_) async => querySnapshot);
    when(querySnapshot.docs).thenReturn([
      queryDocumentSnapshot1,
      queryDocumentSnapshot2,
    ]);
    when(queryDocumentSnapshot1.id).thenReturn(documentId1);
    when(queryDocumentSnapshot2.id).thenReturn(documentId2);

    when(queryDocumentSnapshot1['user']).thenReturn('user1');
    when(queryDocumentSnapshot1['image']).thenReturn('image1');
    when(queryDocumentSnapshot1['description']).thenReturn('description1');
    when(queryDocumentSnapshot1['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 1)));
    when(queryDocumentSnapshot1['likes']).thenReturn(0);
    when(queryDocumentSnapshot2['user']).thenReturn('user2');
    when(queryDocumentSnapshot2['image']).thenReturn('image2');
    when(queryDocumentSnapshot2['description']).thenReturn('description2');
    when(queryDocumentSnapshot2['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 2)));
    when(queryDocumentSnapshot2['likes']).thenReturn(0);

    final result = await database.getNextPosts(null, 2);

    expect(result.$1.length, 2);
    expect(result.$1[0].user, 'user1');
    expect(result.$1[0].image, 'image1');
    expect(result.$1[0].description, 'description1');
    expect(result.$1[0].postDatetime, DateTime(2022, 1, 1));
    expect(result.$1[0].likes, 0);

    expect(result.$1[1].user, 'user2');
    expect(result.$1[1].image, 'image2');
    expect(result.$1[1].description, 'description2');
    expect(result.$1[1].postDatetime, DateTime(2022, 1, 2));
    expect(result.$1[1].likes, 0);
    expect(result.$2, documentId2);
  });

  test('Retrieves only wanted posts', () async {
    final postsCollection = MockCollectionReference();
    final postsQuery1 = MockQuery();
    final postsQuery2 = MockQuery();
    final postsQuery3 = MockQuery();
    final postsQuery4 = MockQuery();
    final postsQuery5 = MockQuery();
    final postsQuery6 = MockQuery();
    final queryDocumentSnapshot1 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot2 = MockQueryDocumentSnapshot();
    final documentRef1 = MockDocumentReference();
    final documentRef2 = MockDocumentReference();
    final documentSnapshot1 = MockDocumentSnapshot();
    final documentSnapshot2 = MockDocumentSnapshot();
    final querySnapshot1 = MockQuerySnapshot();
    final querySnapshot2 = MockQuerySnapshot();
    final querySnapshot3 = MockQuerySnapshot();
    const documentId1 = 'doc1';
    const documentId2 = 'doc2';

    when(firestore.collection('posts')).thenReturn(postsCollection);
    when(postsCollection.orderBy('postDatetime', descending: true))
        .thenReturn(postsQuery1);
    when(postsQuery1.startAfterDocument(documentSnapshot1))
        .thenReturn(postsQuery2);
    when(postsQuery2.limit(1)).thenReturn(postsQuery3);
    when(postsQuery1.startAfterDocument(documentSnapshot2))
        .thenReturn(postsQuery4);
    when(postsQuery4.limit(1)).thenReturn(postsQuery5);
    when(postsQuery1.limit(1)).thenReturn(postsQuery6);

    when(postsQuery3.get()).thenAnswer((_) async => querySnapshot1);
    when(postsQuery5.get()).thenAnswer((_) async => querySnapshot2);
    when(postsQuery6.get()).thenAnswer((_) async => querySnapshot3);

    when(querySnapshot3.docs).thenReturn([
      queryDocumentSnapshot1,
    ]);
    when(querySnapshot1.docs).thenReturn([
      queryDocumentSnapshot2,
    ]);
    when(querySnapshot2.docs).thenReturn([]);

    when(postsCollection.doc(documentId1)).thenReturn(documentRef1);
    when(postsCollection.doc(documentId2)).thenReturn(documentRef2);
    when(documentRef1.get()).thenAnswer((_) async => documentSnapshot1);
    when(documentRef2.get()).thenAnswer((_) async => documentSnapshot2);

    when(documentSnapshot1['user']).thenReturn('user1');
    when(documentSnapshot1['image']).thenReturn('image1');
    when(documentSnapshot1['description']).thenReturn('description1');
    when(documentSnapshot1['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 1)));
    when(queryDocumentSnapshot1['likes']).thenReturn(0);

    when(documentSnapshot2['user']).thenReturn('user2');
    when(documentSnapshot2['image']).thenReturn('image2');
    when(documentSnapshot2['description']).thenReturn('description2');
    when(documentSnapshot2['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 2)));
    when(queryDocumentSnapshot2['likes']).thenReturn(0);

    when(queryDocumentSnapshot1['user']).thenReturn('user1');
    when(queryDocumentSnapshot1['image']).thenReturn('image1');
    when(queryDocumentSnapshot1['description']).thenReturn('description1');
    when(queryDocumentSnapshot1['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 1)));
    when(queryDocumentSnapshot1['likes']).thenReturn(0);

    when(queryDocumentSnapshot2['user']).thenReturn('user2');
    when(queryDocumentSnapshot2['image']).thenReturn('image2');
    when(queryDocumentSnapshot2['description']).thenReturn('description2');
    when(queryDocumentSnapshot2['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 2)));
    when(queryDocumentSnapshot2['likes']).thenReturn(0);

    when(queryDocumentSnapshot1.id).thenReturn(documentId1);
    when(queryDocumentSnapshot2.id).thenReturn(documentId2);
    when(documentSnapshot1.id).thenReturn(documentId1);
    when(documentSnapshot2.id).thenReturn(documentId2);

    var result = await database.getNextPosts(null, 1);

    expect(result.$1.length, 1);
    expect(result.$1[0].user, 'user1');
    expect(result.$1[0].image, 'image1');
    expect(result.$1[0].description, 'description1');
    expect(result.$1[0].postDatetime, DateTime(2022, 1, 1));
    expect(result.$1[0].likes, 0);

    expect(result.$2, documentId1);

    result = await database.getNextPosts(documentId1, 1);
    expect(result.$1[0].user, 'user2');
    expect(result.$1[0].image, 'image2');
    expect(result.$1[0].description, 'description2');
    expect(result.$1[0].postDatetime, DateTime(2022, 1, 2));
    expect(result.$1[0].likes, 0);
    expect(result.$2, documentId2);

    result = await database.getNextPosts(documentId2, 1);
    expect(result.$1, isEmpty);
    expect(result.$2, isNull);
  });

  test('Retrieves only posts of users that the user follows', () async {
    final postsCollection = MockCollectionReference();
    final followsCollection = MockCollectionReference();
    final postsQuery1 = MockQuery();
    final postsQuery2 = MockQuery();
    final postsQuery3 = MockQuery();
    final postsQuery4 = MockQuery();
    final followsQuery1 = MockQuery();
    final queryDocumentSnapshot1 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot2 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot3 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot4 = MockQueryDocumentSnapshot();
    const documentId1 = 'doc1';
    const documentId2 = 'doc2';
    final querySnapshot = MockQuerySnapshot();
    final followsQuerySnapshot = MockQuerySnapshot();
    const userId = 'user-id';

    when(firestore.collection('posts')).thenReturn(postsCollection);
    when(postsCollection.where('user', whereIn: anyNamed('whereIn')))
        .thenReturn(postsQuery1);
    when(postsQuery1.orderBy('user')).thenReturn(postsQuery2);
    when(postsQuery2.orderBy('postDatetime', descending: true))
        .thenReturn(postsQuery3);
    when(postsQuery3.limit(2)).thenReturn(postsQuery4);
    when(postsQuery4.get()).thenAnswer((_) async => querySnapshot);
    when(querySnapshot.docs).thenReturn([
      queryDocumentSnapshot1,
      queryDocumentSnapshot2,
    ]);
    when(queryDocumentSnapshot1.id).thenReturn(documentId1);
    when(queryDocumentSnapshot2.id).thenReturn(documentId2);

    when(queryDocumentSnapshot1['user']).thenReturn('user1');
    when(queryDocumentSnapshot1['image']).thenReturn('image1');
    when(queryDocumentSnapshot1['description']).thenReturn('description1');
    when(queryDocumentSnapshot1['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 1)));
    when(queryDocumentSnapshot1['likes']).thenReturn(0);

    when(queryDocumentSnapshot2['user']).thenReturn('user2');
    when(queryDocumentSnapshot2['image']).thenReturn('image2');
    when(queryDocumentSnapshot2['description']).thenReturn('description2');
    when(queryDocumentSnapshot2['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 2)));
    when(queryDocumentSnapshot2['likes']).thenReturn(0);

    when(firestore.collection('follows')).thenReturn(followsCollection);
    when(followsCollection.where('follower', isEqualTo: userId))
        .thenReturn(followsQuery1);
    when(followsQuery1.get()).thenAnswer((_) async => followsQuerySnapshot);
    when(followsQuerySnapshot.docs).thenReturn([
      queryDocumentSnapshot3,
      queryDocumentSnapshot4,
    ]);
    when(queryDocumentSnapshot3['followed']).thenReturn('user1');
    when(queryDocumentSnapshot4['followed']).thenReturn('user2');

    final result = await database.getNextPostsOfFollowing(null, 2, userId);

    expect(result.$1.length, 2);
    expect(result.$1[0].user, 'user1');
    expect(result.$1[0].image, 'image1');
    expect(result.$1[0].description, 'description1');
    expect(result.$1[0].postDatetime, DateTime(2022, 1, 1));
    expect(result.$1[0].likes, 0);
    expect(result.$1[1].user, 'user2');
    expect(result.$1[1].image, 'image2');
    expect(result.$1[1].description, 'description2');
    expect(result.$1[1].postDatetime, DateTime(2022, 1, 2));
    expect(result.$1[1].likes, 0);
    expect(result.$2, documentId2);
  });

  test('Retrieves only posts of users that the user does not follow',
      () async {
    final postsCollection = MockCollectionReference();
    final followsCollection = MockCollectionReference();
    final postsQuery1 = MockQuery();
    final postsQuery2 = MockQuery();
    final postsQuery3 = MockQuery();
    final postsQuery4 = MockQuery();
    final followsQuery1 = MockQuery();
    final queryDocumentSnapshot1 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot2 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot3 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot4 = MockQueryDocumentSnapshot();
    const documentId1 = 'doc1';
    const documentId2 = 'doc2';
    final querySnapshot = MockQuerySnapshot();
    final followsQuerySnapshot = MockQuerySnapshot();
    const userId = 'user-id';

    when(firestore.collection('posts')).thenReturn(postsCollection);
    when(postsCollection.where('user', whereNotIn: anyNamed('whereNotIn')))
        .thenReturn(postsQuery1);
    when(postsQuery1.orderBy('user')).thenReturn(postsQuery2);
    when(postsQuery2.orderBy('postDatetime', descending: true))
        .thenReturn(postsQuery3);
    when(postsQuery3.limit(2)).thenReturn(postsQuery4);
    when(postsQuery4.get()).thenAnswer((_) async => querySnapshot);
    when(querySnapshot.docs).thenReturn([
      queryDocumentSnapshot1,
      queryDocumentSnapshot2,
    ]);
    when(queryDocumentSnapshot1.id).thenReturn(documentId1);
    when(queryDocumentSnapshot2.id).thenReturn(documentId2);

    when(queryDocumentSnapshot1['user']).thenReturn('user1');
    when(queryDocumentSnapshot1['image']).thenReturn('image1');
    when(queryDocumentSnapshot1['description']).thenReturn('description1');
    when(queryDocumentSnapshot1['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 1)));
    when(queryDocumentSnapshot1['likes']).thenReturn(0);
    when(queryDocumentSnapshot2['user']).thenReturn('user2');
    when(queryDocumentSnapshot2['image']).thenReturn('image2');
    when(queryDocumentSnapshot2['description']).thenReturn('description2');
    when(queryDocumentSnapshot2['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 2)));
    when(queryDocumentSnapshot2['likes']).thenReturn(0);

    when(firestore.collection('follows')).thenReturn(followsCollection);
    when(followsCollection.where('follower', isEqualTo: userId))
        .thenReturn(followsQuery1);
    when(followsQuery1.get()).thenAnswer((_) async => followsQuerySnapshot);
    when(followsQuerySnapshot.docs).thenReturn([
      queryDocumentSnapshot3,
      queryDocumentSnapshot4,
    ]);
    when(queryDocumentSnapshot3['followed']).thenReturn('user3');
    when(queryDocumentSnapshot4['followed']).thenReturn('user4');

    final result = await database.getNextPostsOfNonFollowing(null, 2, userId);

    expect(result.$1.length, 2);
    expect(result.$1[0].user, 'user1');
    expect(result.$1[0].image, 'image1');
    expect(result.$1[0].description, 'description1');
    expect(result.$1[0].postDatetime, DateTime(2022, 1, 1));
    expect(result.$1[0].likes, 0);
    expect(result.$1[1].user, 'user2');
    expect(result.$1[1].image, 'image2');
    expect(result.$1[1].description, 'description2');
    expect(result.$1[1].postDatetime, DateTime(2022, 1, 2));
    expect(result.$1[1].likes, 0);
    expect(result.$2, documentId2);
  });

  test('Retrieves posts from user', () async {
    final postsCollection = MockCollectionReference();
    final postsQuery1 = MockQuery();
    final postsQuery2 = MockQuery();
    final queryDocumentSnapshot1 = MockQueryDocumentSnapshot();
    final queryDocumentSnapshot2 = MockQueryDocumentSnapshot();
    const documentId1 = 'doc1';
    const documentId2 = 'doc2';
    final querySnapshot = MockQuerySnapshot();
    const userId = 'user-id';

    when(firestore.collection('posts')).thenReturn(postsCollection);
    when(postsCollection.where('user', isEqualTo: userId))
        .thenReturn(postsQuery1);
    when(postsQuery1.orderBy('postDatetime', descending: true))
        .thenReturn(postsQuery2);
    when(postsQuery2.get()).thenAnswer((_) async => querySnapshot);
    when(querySnapshot.docs).thenReturn([
      queryDocumentSnapshot1,
      queryDocumentSnapshot2,
    ]);
    when(queryDocumentSnapshot1.id).thenReturn(documentId1);
    when(queryDocumentSnapshot2.id).thenReturn(documentId2);

    when(queryDocumentSnapshot1['user']).thenReturn('user1');
    when(queryDocumentSnapshot1['image']).thenReturn('image1');
    when(queryDocumentSnapshot1['description']).thenReturn('description1');
    when(queryDocumentSnapshot1['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 1)));
    when(queryDocumentSnapshot1['likes']).thenReturn(0);

    when(queryDocumentSnapshot2['user']).thenReturn('user2');
    when(queryDocumentSnapshot2['image']).thenReturn('image2');
    when(queryDocumentSnapshot2['description']).thenReturn('description2');
    when(queryDocumentSnapshot2['postDatetime'])
        .thenReturn(Timestamp.fromDate(DateTime(2022, 1, 2)));
    when(queryDocumentSnapshot2['likes']).thenReturn(0);

    final result = await database.getPostsFromUser(userId);

    expect(result[0].user, 'user1');
    expect(result[0].image, 'image1');
    expect(result[0].description, 'description1');
    expect(result[0].postDatetime, DateTime(2022, 1, 1));
    expect(result[0].likes, 0);
    expect(result[1].user, 'user2');
    expect(result[1].image, 'image2');
    expect(result[1].description, 'description2');
    expect(result[1].postDatetime, DateTime(2022, 1, 2));
    expect(result[1].likes, 0);
  });
}
