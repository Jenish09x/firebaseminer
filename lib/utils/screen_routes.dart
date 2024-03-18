import 'package:firebaseminer/screen/contact/view/contact_screen.dart';
import 'package:firebaseminer/screen/home/view/home_screen.dart';
import 'package:firebaseminer/screen/login/view/sign_in_screen.dart';
import 'package:firebaseminer/screen/login/view/sign_up_screen.dart';
import 'package:firebaseminer/screen/profile/view/profile_screen.dart';
import 'package:firebaseminer/screen/setting/view/setting_screen.dart';
import 'package:firebaseminer/screen/splash/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screen/chat/view/chat_screen.dart';
import '../screen/dash/view/dash_screen.dart';

Map<String,WidgetBuilder>screen_routes={
  '/':(context) => const SplashScreen(),
  'dash':(context) => const DashScreen(),
  'signin':(context) => const SignInScreen(),
  'signup':(context) => const SignUpScreen(),
  'home':(context) => const HomeScreen(),
  'profile':(context) => const ProfileScreen(),
  'contact':(context) => const ContactScreen(),
  'chat':(context) => const ChatScreen(),
  'setting':(context) => const SettingScreen(),
};