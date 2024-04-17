import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:logger/logger.dart';

class SessionController {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? loggedInUser;

  Future<void> loginUser(String email, String password, DatabaseController databaseController) async {
    if (loggedInUser != null) {
      throw StateError("User ${loggedInUser!.email} is already logged in\n");
    }

    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    loggedInUser = await databaseController.getUser(credential.user!.uid);
    Logger().i("User ${loggedInUser!.email} logged in successfully!\n");
  }

  Future<void> registerUser(String email, String password, String username, DatabaseController databaseController) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    await auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );

    loggedInUser = await databaseController.createUser(credential.user!.uid, email, username);
    Logger().i("User ${loggedInUser!.email} registered successfully!\n");
  }

  Future<void> logoutUser() async {
    if (loggedInUser == null) {
      throw StateError("No user is logged in\n");
    }
    loggedInUser = null;
    await auth.signOut();
  }
}