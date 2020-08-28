import 'package:chat_app/screen/all_user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screen/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/auth_screen.dart';
void main() async {
  // after august 7 we have to call firecore before using any firebase product so we call in main  this two line before the runApp(MyApp())
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.lightBlue,
        accentColor: Colors.lightBlueAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.cyanAccent,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), // this listen to change of firebaseAuth login logout sign up
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return DisplayUser(); //ChatScreen() ;
          }
          else{
            return  AuthScreen();
          }
        },
      )

    // should check if auth or then render different thing
//      routes: {
//        "/": (ctx)=> ,
//
//      },
    );
  }
}

