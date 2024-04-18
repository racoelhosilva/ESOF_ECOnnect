import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:logger/logger.dart';

class SessionController {
  SessionController(FirebaseAuth auth) : _auth = auth;
  final FirebaseAuth _auth;
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  Future<void> init(DatabaseController databaseController) async {
    final user = _auth.currentUser;
    if (user != null) {
      _loggedInUser = await databaseController.getUser(user.uid);
      Logger().i("User ${_loggedInUser!.email} is already logged in\n");
    }
  }

  bool isLoggedIn() => _loggedInUser != null;

  Future<void> loginUser(String email, String password,
      DatabaseController databaseController) async {
    if (_loggedInUser != null) {
      throw StateError("User ${_loggedInUser!.email} is already logged in\n");
    }

    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    _loggedInUser = await databaseController.getUser(credential.user!.uid);
    Logger().i("User ${_loggedInUser!.email} logged in successfully!\n");
  }

  Future<void> registerUser(String email, String password, String username,
      DatabaseController databaseController) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    _loggedInUser = await databaseController.createUser(
        credential.user!.uid, email, username);
    Logger().i("User ${_loggedInUser!.email} registered successfully!\n");
  }

  Future<void> logoutUser() async {
    if (_loggedInUser == null) {
      throw StateError("No user is logged in\n");
    }
    _loggedInUser = null;
    await _auth.signOut();
  }
}
