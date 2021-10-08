import 'package:food_dash/presentation/view/screen/auth/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:food_dash/presentation/config/theming/sample.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.lightTheme.primaryColor,
      body: Center(
        child: RegisterForm(),
      ),
    );
  }
}
