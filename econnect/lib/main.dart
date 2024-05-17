import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/firebase_options.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/create_post/create_post_page.dart';
import 'package:econnect/view/edit_post/edit_post_page.dart';
import 'package:econnect/view/home/home_page.dart';
import 'package:econnect/view/login/login_page.dart';
import 'package:econnect/view/login/register_page.dart';
import 'package:econnect/view/post/post_page.dart';
import 'package:econnect/view/profile/profile_page.dart';
import 'package:econnect/view/search/search_page.dart';
import 'package:econnect/view/settings/settings_page.dart';
import 'package:econnect/view/theme.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final dbController = DatabaseController(
    db: Database(FirebaseFirestore.instance, FirebaseStorage.instance),
  );
  final sessionController = SessionController(FirebaseAuth.instance);
  await sessionController.init(dbController);

  runApp(App(dbController: dbController, sessionController: sessionController));
}

class App extends StatelessWidget {
  const App(
      {super.key, required this.dbController, required this.sessionController});

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  Widget build(BuildContext context) {
    sessionController.init(dbController);

    return MaterialApp(
      title: 'ECOnnect',
      theme: const MaterialTheme(TextTheme()).dark(),
      initialRoute: sessionController.isLoggedIn() ? '/home' : '/login',
      onGenerateRoute: (settings) {
        final transitions = {
          '/login': MaterialPageRoute<LoginPage>(
            settings: settings,
            builder: (_) => LoginPage(
              dbController: dbController,
              sessionController: sessionController,
            ),
          ),
          '/home': MaterialPageRoute<HomePage>(
            settings: settings,
            builder: (_) => HomePage(
              dbController: dbController,
              sessionController: sessionController,
            ),
          ),
          '/register': MaterialPageRoute<RegisterPage>(
            settings: settings,
            builder: (_) => RegisterPage(
              dbController: dbController,
              sessionController: sessionController,
            ),
          ),
          '/createpost': MaterialPageRoute<CreatePostPage>(
            builder: (_) => CreatePostPage(
              dbController: dbController,
              sessionController: sessionController,
            ),
          ),
          '/editpost': MaterialPageRoute<EditPostPage>(
            builder: (_) => EditPostPage(
              dbController: dbController,
              post: settings.arguments as Post,
            ),
          ),
          '/profile': MaterialPageRoute<ProfilePage>(
            builder: (_) => ProfilePage(
              dbController: dbController,
              sessionController: sessionController,
              userId: settings.arguments as String,
            ),
          ),
          '/settings': MaterialPageRoute<SettingsPage>(
            builder: (_) => SettingsPage(
              dbController: dbController,
              sessionController: sessionController,
            ),
          ),
          '/postpage': MaterialPageRoute<PostPage>(
            builder: (_) => PostPage(
              dbController: dbController,
              sessionController: sessionController,
              post: settings.arguments as Post,
            ),
          ),
          '/search': MaterialPageRoute<SearchPage>(
            builder: (_) => SearchPage(
              dbController: dbController,
              sessionController: sessionController,
            ),
          ),
        };
        return transitions[settings.name];
      },
    );
  }
}
