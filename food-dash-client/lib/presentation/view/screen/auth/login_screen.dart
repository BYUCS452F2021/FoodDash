import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:food_dash/presentation/config/theming/sample.dart';

import 'login_form.dart';

/// Auth Screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.lightTheme.primaryColor,
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}
