import 'package:econnect/firebase_options.dart';
import 'package:econnect/view/home/home_page.dart';
import 'package:econnect/view/login/login_page.dart';
import 'package:econnect/view/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECOnnect',
      theme: const MaterialTheme(TextTheme()).dark(),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        final transitions = {
          '/login':
              MaterialPageRoute<LoginPage>(builder: (_) => const LoginPage()),
          '/home':
              MaterialPageRoute<HomePage>(builder: (_) => const HomePage()),
        };
        return transitions[settings.name];
      },
    );
  }
}
