import 'package:chat_app/screens/Chatscreen.dart';
import 'package:chat_app/screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'screens/WelcomeScreen.dart';
import 'screens/Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: 'AIzaSyAvni11B03PgqRlNC5CVpx-ViJgqVWTf1o', appId: '1:106451926413:android:1931ce37d8a4f51a0091c4', messagingSenderId: '106451926413',
        projectId:'myproject-4b57e'
        ,)

  );
  runApp(FlashChat());
}


class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light().copyWith(
            textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        home:WelcomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '':(context)=> WelcomeScreen(),
          'Registration_screen':(context)=>Registration_screen() ,
          'LoginScreen':(context)=> LoginScreen(),
          'Chatscreen':(context)=> ChatScreen(),


        }
    );
  }
}
