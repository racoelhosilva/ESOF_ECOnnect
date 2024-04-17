import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:econnect/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'session_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<fa.FirebaseAuth>(),
  MockSpec<fa.UserCredential>(),
  MockSpec<fa.User>()
])
void main() {
  late DatabaseController databaseController;
  late SessionController sessionController;
  late fa.FirebaseAuth firebaseAuth;
  late fa.UserCredential userCredential;
  late fa.User fauser;

  setUp(() {
    databaseController = MockDatabaseController();
    firebaseAuth = MockFirebaseAuth();
    sessionController = SessionController(firebaseAuth);
    userCredential = MockUserCredential();
    fauser = MockUser();
  });

  test('User is registered successfully', () async {
    const id = '123';
    const email = 'test@example.com';
    const username = 'testuser';
    const password = 'password';
    final user = User(
        id: id,
        email: email,
        username: username,
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '');

    expect(sessionController.isLoggedIn(), false);

    when(firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer((_) async => userCredential);

    when(userCredential.user).thenReturn(fauser);

    when(fauser.uid).thenReturn(id);

    when(firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer((_) async => userCredential);

    when(databaseController.createUser(id, email, username))
        .thenAnswer((_) async => user);

    await sessionController.registerUser(
        email, password, username, databaseController);

    verify(firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .called(1);
    verify(firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .called(1);
    verify(databaseController.createUser(id, email, username)).called(1);
    expect(sessionController.isLoggedIn(), true);
  });

  test('User is logged in successfully', () async {
    const id = '123';
    const email = 'test@example.com';
    const username = 'testuser';
    const password = 'password';
    final user = User(
        id: id,
        email: email,
        username: username,
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '');

    expect(sessionController.isLoggedIn(), false);

    when(userCredential.user).thenReturn(fauser);

    when(fauser.uid).thenReturn(id);

    when(firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer((_) async => userCredential);

    when(databaseController.getUser(id)).thenAnswer((_) async => user);

    await sessionController.loginUser(email, password, databaseController);

    verify(firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .called(1);
    verify(databaseController.getUser(id)).called(1);
    expect(sessionController.isLoggedIn(), true);
  });
}
