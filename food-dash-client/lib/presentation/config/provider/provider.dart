import 'package:dating_idea/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

///Provider has something to do with state management
///Put all of the global providers here
///ex. AuthProvider
class AppGlobalProvider extends StatelessWidget {
  final Widget rootApp;
  AppGlobalProvider({@required this.rootApp});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      BlocProvider(create: (context) => LoginCubit()),
      BlocProvider(create: (context) => RegisterCubit()),
      BlocProvider(create: (context) => SignOutCubit())
    ], child: rootApp);
  }
}
