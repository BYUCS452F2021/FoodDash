import 'dart:developer';
import 'package:food_dash/presentation/config/config.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser.getIdToken().then((value) {
      // This will log the token of the current user.
      // This token can be used in Postman to log in to the server.
      log(value);
      Navigator.of(context)
          .pushReplacementNamed(AppRouter.restaurantsListScreen);
    });
    return const Text("This is the home screen.");
  }
}
