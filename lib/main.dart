import 'package:flutter/material.dart';
import 'package:laf_1/routes.dart';
import 'package:laf_1/screens/home/home_screen.dart';
import 'package:laf_1/screens/splash/prompt_screen.dart';
import 'package:laf_1/size_config.dart';
// import 'package:laf_1/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laf_1/theme.dart';

// import 'package:firebase_core/firebase_core.dart';

String? token = null;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Me',
      theme: theme(),
      // home: PromptScreen(),
      initialRoute: token == null ? PromptScreen.routeName : HomeScreen.routeName,
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
