import 'package:food_dash/data/data_provider/fireauth_provider.dart';
import 'package:food_dash/data/model/response.dart';
import 'package:food_dash/data/model/response/register_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FireAuthRepository {
  final _fireAuthProvider = FireAuthProvider();
  Stream<User> authStateChange() {
    return _fireAuthProvider.authStateChange();
  }

  Future<LoginResponse> login(
          {@required String email, @required String password}) async =>
      _fireAuthProvider.login(email: email, password: password);

  Future<RegisterResponse> register(
          {@required String email, @required String password}) async =>
      await _fireAuthProvider.register(email: email, password: password);

  Future signOut() async => await _fireAuthProvider.signOut();
}
