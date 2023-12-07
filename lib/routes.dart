import 'package:flutter/widgets.dart';
import 'package:laf_1/screens/upload/upload_screen.dart';
import 'package:laf_1/screens/forgot_password/forgot_password_screen.dart';
import 'package:laf_1/screens/home/home_screen.dart';
import 'package:laf_1/screens/login_success/login_success_screen.dart';
import 'package:laf_1/screens/sign_in/sign_in_screen.dart';
import 'package:laf_1/screens/splash/prompt_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  PromptScreen.routeName: (context) => const PromptScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  UploadItem.routeName: (context) => const UploadItem(),
};
