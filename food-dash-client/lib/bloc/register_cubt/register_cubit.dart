import 'package:bloc/bloc.dart';
import 'package:dating_idea/data/repository/fireauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  FireAuthRepository _fireAuthRepository = FireAuthRepository();

  Future<User> register(
      {@required String email, @required String password}) async {
    emit(RegisterPendingState());
    final registerResponse =
        await _fireAuthRepository.register(email: email, password: password);

    registerResponse.user != null
        ? emit(RegisterSucceededState())
        : emit(RegisterFailedState(errorMessage: registerResponse.message));
  }
}
