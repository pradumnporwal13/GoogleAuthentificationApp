// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

//import 'dart:html';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

googleLogin() async {
  print("googleLogin method Called");
  GoogleSignIn _googleSignIn = GoogleSignIn();
  try {
    var result = await _googleSignIn.signIn();
    if (result == null) {
      return;
    }

    final userData = await result.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken, idToken: userData.idToken);
    
    var finalResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("Result $result");
    print(result.displayName);
    print(result.email);
    print(result.photoUrl);
  } catch (error) {
    print(error);
  }
}

Future<void> logout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      //theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("https://static.thenounproject.com/png/3321515-200.png",height: 200,),
            //InkWell(
            //  onTap: () => googleLogin(),
            //  splashColor: Colors.lightBlueAccent,
            //  radius: 200,
            //  child: Image.network("https://aws1.discourse-cdn.com/auth0/optimized/3X/8/a/8a06490f525c8f65d4260204bc3bc7b0e1fb0ba7_2_500x500.png",height: 200,)
            //  ),

            Center(
              child: MaterialButton(
                onPressed: () {
                  googleLogin();
                },
                color: Colors.white,
                splashColor: Colors.blueAccent,
                minWidth: 100,
                height: 40,
                // ignore: sort_child_properties_last
                child: Image.network(
                  "https://aws1.discourse-cdn.com/auth0/optimized/3X/8/a/8a06490f525c8f65d4260204bc3bc7b0e1fb0ba7_2_500x500.png",
                  height: 30,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200)),

                //child: const Text("GOOGLE LOGIN",
                //    style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
