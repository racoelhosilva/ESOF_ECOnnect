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

  setUpAll(() {
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
    test('should add follow successfully', () async {
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

    test('should throw StateError if follow already exists', () async {
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
    test('should remove follow successfully', () async {
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

    test('should throw StateError if follow does not exist', () async {
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
    test('should return list of following users', () async {
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

    test('should return empty list if no following users', () async {
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
    test('should return true if user is following', () async {
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

    test('should return false if user is not following', () async {
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
}
