import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stupoll/providers/vote_provider.dart';
import 'package:stupoll/screens/auth/auth_screen.dart';
import 'package:stupoll/screens/custom_splash.dart';
import 'package:stupoll/screens/home2.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:stupoll/screens/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Start());
}
class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: Image.asset('assets/trans_logo.png',scale: 1,),
        nextScreen: MyApp(),
        splashTransition: SplashTransition.scaleTransition,
        duration: 3000,
        //pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.teal,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.tealAccent,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
        ),
        textTheme: TextTheme(subtitle1: TextStyle(color: Colors.tealAccent)),//change entered text color
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx, userSnapshot){
        /*if(userSnapshot.connectionState == ConnectionState.waiting){
          return CustomSplash();
        }*/
        if(userSnapshot.hasData){
          return StartPage();
        }
        return AuthScreen();
      },),
    );
  }
}