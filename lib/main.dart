import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migrane_helper/src/screens/welcome_screen.dart';
import 'src/themes/theme.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: context.theme.material,
            home: const AppStartingPage(),
          );
        },
      ),
    );
  }
}

class AppStartingPage extends StatelessWidget {
  const AppStartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen();
  }
}
