import 'package:dating_idea/presentation/config/config.dart';
import 'package:dating_idea/presentation/config/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

///This is where we define all the app route and style/theme for the entire app
///theme defines all of the themes for the entire app
///routes defines all of the routes for the entire app

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter _appRouter = AppRouter();
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return AppGlobalProvider(
        rootApp: MaterialApp(
            //Material App gives the app the google standard app style
            debugShowCheckedModeBanner: false,
            theme: AppTheme.define(),
            navigatorKey: navigatorKey,
            onGenerateRoute: _appRouter.onGenerateRoute,
            builder: EasyLoading.init()));
  }

  @override
  void dispose() {
    //Need to dispose the blocs
    _appRouter.dispose();
    super.dispose();
  }
}
