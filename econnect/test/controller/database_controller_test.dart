import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';
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
    const testMockStorage = './temp.png';
    const channel = MethodChannel(
      'plugins.flutter.io/path_provider',
    );
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
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
}
