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
        profilePicture: '',
        following: []);
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
        profilePicture: '',
        following: []);
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
}
