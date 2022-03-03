import 'package:ecommerce/screens/landing_screen.dart';
import 'package:ecommerce/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const MainScreen();
          } else {
            return const LandingScreen();
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occured'));
        }
        return const Text('Nothing');
      },
    );
  }
}
