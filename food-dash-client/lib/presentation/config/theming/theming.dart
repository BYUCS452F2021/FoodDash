import 'package:flutter/material.dart';

import 'package:food_dash/presentation/config/theming/sample.dart';

/// AppTheme gives the theme/style for the app
class AppTheme {
  const AppTheme._();

  static ThemeData define() {
    return CustomTheme.lightTheme;
  }
}
