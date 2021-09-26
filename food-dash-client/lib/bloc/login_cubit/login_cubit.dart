import 'package:bloc/bloc.dart';
import 'package:dating_idea/data/model/response.dart';
import 'package:dating_idea/data/repository/fireauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  FireAuthRepository _fireAuthRepository = FireAuthRepository();

  Future<void> login(
      {@required String email, @required String password}) async {
    emit(LoginPendingState());
    final LoginResponse loginResponse =
        await _fireAuthRepository.login(email: email, password: password);

    loginResponse.user != null
        ? emit(LoginSucceededState(user: loginResponse.user))
        : emit(LoginFailedState(errorMessage: loginResponse.message));
  }
}
