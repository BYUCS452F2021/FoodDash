import 'package:food_dash/data/repository/fireauth_repository.dart';
import 'package:food_dash/presentation/view/screen/auth/login_screen.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///Entry Widget of the app
///Decides to route to home or auth depending on authentication state
class Root extends StatelessWidget {
  final _fireAuthRepository = FireAuthRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<User>(
          stream: _fireAuthRepository.authStateChange(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
                break;
              case ConnectionState.active:
                if (snapshot.hasError) {
                  return const Text("Has error");
                }
                return snapshot.hasData ? HomeScreen() : LoginScreen();
                break;
              case ConnectionState.done:
                return const Text("The connection is over");
                break;
              default:
                break;
            }
            return const Text("Error for now");
          }),
    );
  }
}
