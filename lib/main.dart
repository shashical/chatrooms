import 'package:chatrooms/profile/edit.dart';
import 'package:chatrooms/profile/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

String? json;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences pref=await SharedPreferences.getInstance();
  json= pref.getString(MyApp.keyuser);
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});
  static final keyuser='user';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            title: 'Chat Room',
            debugShowCheckedModeBanner: false,
             home: json!=null? ProfileScreen():EditProfileScreen(),
          );
  }
}


