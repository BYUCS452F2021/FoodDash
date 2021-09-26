import 'package:dating_idea/presentation/root/myApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// This is the entry point of the program
/// runApp accept a Widget as argument to start the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
