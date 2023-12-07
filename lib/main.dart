import 'package:flutter/material.dart';
import 'package:laf_1/routes.dart';
// import 'package:laf_1/screens/profile/profile_screen.dart';
import 'package:laf_1/screens/splash/prompt_screen.dart';
import 'package:laf_1/theme.dart';

// import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Me',
      theme: theme(),
      home: const PromptScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
